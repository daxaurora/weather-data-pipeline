# Weather Data Pipeline - Data Details

### Data Source
NOAA National Climatic Data Center
https://www.ncei.noaa.gov/metadata/geoportal/rest/metadata/item/gov.noaa.ncdc:C00861/html

### Data Description
* Worldwide daily weather data.
* Years and type of data vary per station.
* Sample data is from 8 Grand Canyon National Park weather stations, with varying date ranges spanning from 1903 to current data.
* Daily files are updated regularly from stations still collecting data.

### Raw Data Format
* Text files, space delimited, fixed width columns. Values contain spaces within columns.
* More details here:  
https://www.ncei.noaa.gov/pub/data/ghcn/daily/readme.txt

### Raw Data Filenames

*Metadata*   
`ghcnd-countries.txt`  
`ghcnd-states.txt`  
`ghcnd-stations.txt`

*Sample Data*
* Stored in `data/sample` directory
* 8 files with .dly extension
* Station name range: USC00023581 - USC00023596

*All Data*  
* The `all` directory at data source holds individual, uncompressed files for each station.
* All files in the `all` directory are contained in this single compressed file: `ghcnd_all.tar.gz`  

### Data Ingestion
*Sample data*  
 Direct manual download of `ghcnd_all.tar.gz` from
https://www.ncei.noaa.gov/pub/data/ghcn/daily/ followed by manual individual file selection.

### Data Source Citation
*Sample data*  
Menne, Matthew J., Imke Durre, Bryant Korzeniewski, Shelley McNeill, Kristy Thomas, Xungang Yin, Steven Anthony, Ron Ray, Russell S. Vose, Byron E.Gleason, and Tamara G. Houston (2012): Global Historical Climatology Network - Daily (GHCN-Daily), Version 3. NCEI Direct Download. NOAA National Climatic Data Center. doi:10.7289/V5D21VHZ Accessed June 19, 2023.
