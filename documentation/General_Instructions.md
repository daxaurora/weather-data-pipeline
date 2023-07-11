# Weather Data Pipeline - General Instructions

### Postgres password
Postgres requires a password to initialize a database. This automated pipeline stores a password in two files in the local root directory of this repo: `.env` and `.pgpass`.

These files cannot be committed to public github repo unless `.gitignore` is explicitly overridden.

Entering passwords is only necessary once with the instructions in this repo's ReadMe file, unless the `.env` and `.pgpass` files are deleted.

Note that the password is also stored in the Docker Postgres image created for this pipeline. So if the password is changed in the .env and .pgpass file after first creating those files and starting the pipeline, that Postgres Docker image will need to be deleted and the pipeline restarted with docker compose. 

Postgres does have an option to turn off the password requirement, but that's not a best practice and hasn't been tested in this pipeline.

### Initializing Postgres

The `dbdata` directory must be completely empty when initializing database. If that directory is not empty, the Postgres container won't initialize properly and will repeatedly attempt to restart.

If a Postgres database has already been initialized in `dbdata` with a different user (i.e., postgres), this pipeline will not eliminate that database, but it won't initialize a new one to work with this pipeline either.

After the database is initialized, it will persist independently in the `dbdata` directory.  The whole pipeline and/or individual containers can be stopped and restarted and will reconnect with the existing database using the credentials in the `.env` file and the `dbdata` volume (as bound in `docker-compose.yml`).

Starting the pipeline runs these containers:
* Raw data container with volume for raw data
* Postgres container
* Python container

The Postgres container will create all table structures and load metadata (country, state and weather station information) when the database is first initialized.

### Connecting to the Postgres container

The postgres container will require a few minutes to spin up completely, run initialization scripts, and accept incoming connections. To see if postgres container is ready, see logs at ```docker compose logs```. Look for `PostgreSQL init process complete; ready for start up.` After initialization scripts have run, Postgres will restart and report when it's ready to accept connections.  

Methods to connect to the Postgres container or to run scripts other than what's in `ReadMe`:

To run scripts at the psql prompt after connecting to the container:
```
\i [path/filename]
```

To run a sql script without creating an interactive connection to the container:
```
docker compose exec postgres_service \
psql -h postgres_service -U weatherdata \
passfile=.pgpass \
-f [path/filename]
```

### Connecting to the Python container

Methods to connect to the Python container or to run scripts other than what's in `ReadMe`:

To connect to shell inside Python container:
```
docker compose exec python_service /bin/bash
```
To quit:
```
exit
```

To run a script without without creating an interactive connection to the container:
```
docker compose exec python_service \
python [path/filename]
```

### Clean up
After shutting down the pipeline with `docker compose down`, to list and remove images created from this project:
```
docker image ls
```
```
docker image rm [image name]
```

The contents of `dbdata` can be deleted and the database can be recreated from scratch using the instructions in the ReadMe file.

### About loading this weather data into Postgres

The weather data from NOAA used in this pipeline is space delimited with fixed column widths, and includes spaces inside column values. Neither a space nor tab delimiter works for loading data using COPY in SQL. Postgres does not have a direct method for loading fixed width column text files.  (Though other SQL platforms, like Amazon Redshift, do.)

*Metadata files*   
Metadata files are first loaded via SQL into an interim staging table, where one row of raw data equals a single SQL table column.

SQL can load fixed widths of characters from another SQL table, so the final metadata tables extract data from the staging tables.

*Weather data*  
Each file of daily weather data contains data from one weather station. Each row of these files contains one month of data in fixed-width columns.  This data was loaded with a similar strategy as the metadata files, but using Python pandas.

Raw weather data files were loaded into a staging pandas DataFrame, where one column equals one row (one month) of raw data.

Custom functions transform the staging DataFrame into a DataFrame with the final structure of the SQL tables, where each row equals one day of data. The data is loaded from the pandas DataFrame directly into Postgres.

### Design choices for the SQL table structure

* If all of the raw data were loaded into one table, this would increase the computational cost of queries within that large table.
*  If a separate table were created for each of the over 120,000 stations (mimicking the raw data file structure of one file per station), this would create an unwieldy number of tables to join when looking for weather trends over large geographic areas.
* Loading data into SQL tables designed to hold one type of weather data per table strikes a balance between one large table and a large number of small tables, expecting that queries will join a smaller number of weather elements than they would join stations.
* This pipeline currently loads 5 types of weather data into 5 separate SQL tables: snow, snow_depth, precipitation, maximum temperature, and minimum temperature identified from NOAA as core weather data.
* Compound primary key of station name and date prevents duplicate loading of weather data.

### Possible modifications
* This pipeline can be modified to extract other types of weather data (in addition to the 5 core elements identified above) into new SQL tables from any stations that collect that weather data.
* This pipeline could also be modified to load only data from weather stations within certain regions or countries, using country codes, US state codes, or latitude and longitude.
* This pipeline ignores flags on measurements - quality, source, and measurement type.  This pipeline could also  be modified to load flags for any weather element value loaded from the raw data.
