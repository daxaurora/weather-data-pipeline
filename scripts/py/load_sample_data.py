"""
This script does the following:
1) reads all daily weather data files in the data/sample directory and
2) loads weather data into PostgreSQL tables
PostgreSQL tables are created in initialization scripts in scripts/sql.
Loads only weather elements identfied in the core_elements variable below
"""

import numpy as np
import pandas as pd
import os
import psycopg2
import sqlalchemy
import time

# initialize variables
pg_user = os.environ.get('POSTGRES_USER')
pg_passwd = os.environ.get('POSTGRES_PASSWORD')
pg_connection = 'postgresql+psycopg2://' + \
                pg_user + ':' + pg_passwd +  \
                '@postgres_service:5432/' + pg_user
engine = sqlalchemy.create_engine(pg_connection)
core_elements = ['PRCP', 'SNOW', 'SNWD', 'TMAX', 'TMIN']
table_names = {'SNOW': 'snow',
               'PRCP': 'precip',
               'SNWD': 'snow_depth',
               'TMAX': 'max_temp',
               'TMIN': 'min_temp'}
cols = ['year', 'month', 'element', 'station_id',
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
        16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28,
        29, 30, 31]
start = 21
end = 26
start_list = [start]
end_list = [end]
for i in range(30):
    start += 8
    end += 8
    start_list.append(start)
    end_list.append(end)
day_cols = [(i, j) for (i, j) in zip(start_list, end_list)]
colspecs = [(11, 15), (15, 17), (17, 21), (0, 11)]
colspecs.extend(day_cols)


def df_to_sql(df):
    """Input: staging dataframe loaded with raw data
       Output: weather data loaded into sql tables
    """

    def row_to_df(row):
        """Input: single row (one month) of staging dataframe
           Output: dataframe with one day per row
        """
        dates = []
        values = []
        year = str(row['year'])
        month = str(row['month'])
        for i in days_of_month:
            dates.append(year + '-' + month + '-' + str(i))
            values.append(row[i])
        date_idx = pd.to_datetime(dates, errors='coerce')
        row_df = pd.DataFrame(values,
                              index=date_idx,
                              columns=['value'])
        return row_df

    for element in core_elements:
        table_name = table_names.get(element)
        if table_name is None:
            print("Weather element not in \
                   table_names dictionary. \
                   Data not loaded into SQL.")
        else:
            element_df = df[df['element'] == element]
            row_total = element_df.shape[0]
            if row_total > 0:
                for i in range(row_total):
                    row = element_df.iloc[i]
                    row_df = row_to_df(row)
                    if i == 0:
                        df_final = row_df
                    else:
                        df_final = pd.concat([df_final, row_df])
                # remove out of range dates, add station id
                df_final = df_final[df_final.index.notnull()]
                df_final.insert(loc=0,
                                column='station_id',
                                value=station_id)
                # insert into sql table
                df_final.to_sql(name=table_name,
                                con=engine,
                                if_exists='append',
                                index_label='value_date',
                                chunksize=10000)
                print('Loaded', table_name, 'data from', filename)


if __name__ == '__main__':
    start_time = time.time()
    for filename in os.listdir('/data/sample'):
        # create staging dataframe
        if filename.endswith('.dly'):
            df = pd.read_fwf('data/sample/' + filename,
                             header=0,
                             names=cols,
                             colspecs=colspecs,
                             on_bad_lines='warn')
            # initialize variables
            station_id = df.loc[0]['station_id']
            days_of_month = df.columns.values[4:]
            # load data from staging dataframe into sql
            df_to_sql(df)
    print("Total load time {} seconds".format(time.time() - start_time))
