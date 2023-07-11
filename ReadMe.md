# Weather Data Pipeline
This data solution automatically loads daily weather data from NOAA into a PostgreSQL database using a microservices architecture with Docker containers.

Currently this pipeline is designed for a local machine with a few requirements detailed below and loads a small sample dataset.

This is a work in progress and new components and platforms will be added regularly.


## Repo organization
`builds` contains Dockerfiles and other requirements for running containers  
`data` holds raw data. Sample daily files are in `sample` subdirectory  
`dbdata` holds the Postgres database (empty before first initializing database)  
`documentation` holds detailed information and instructions  
`logs` holds runtime logs and/or error reports  
`scripts`  holds scripts used in the pipeline  

## Quickstart

Confirm the requirements are met and follow the instructions below to run this data solution from scratch. More details about each step and different platforms are in this repo's `documentation` folder.


##### Requirements
**OS**: This pipeline has been tested on macOS Monterey on a MacBook Pro<br>
**Docker**  [Install Docker](https://docs.docker.com/engine/install/)<br>
**Git**  [Install Git](https://github.com/git-guides/install-git)<br>


1. Clone this repo to anywhere on your local machine.
2. Via a shell prompt on your local machine, navigate to the top level of this repo (`weather-data-pipeline`). Run all commands below from this location.
3. Choose a password and add it to the code below before running it. Files containing passwords will only be stored locally.
```
echo 'POSTGRES_USER=weatherdata' > .env
echo 'POSTGRES_PASSWORD=[your_password]' >> .env
echo '*:*:*:weatherdata:[your_password]' > .pgpass
```
4. Start the pipeline.
```
docker compose up -d
```
The Postgres container will take a few minutes to be ready to accept incoming connections. If the next step loading data returns a `Connection refused` error, wait a few minutes and try again.

5. Load sample data into Postgres.  This may take a minute or two. This script will report loading each weather element from each file.
```
 docker compose exec python_service python \
 scripts/py/load_sample_data.py
```

6. To connect to Postgres container to execute SQL queries via a psql prompt:
 ```
 docker compose exec postgres_service \
 psql -h postgres_service -U weatherdata \
 passfile=.pgpass
 ```
 To quit:
 ```
 \q
 ```

7. To connect to Python container via python interpreter:
```
docker compose exec python_service python
```
To quit:
```
exit()
```

8. Shut it down
```
docker compose down
```


#### Errors?

Some potential errors and issues are addressed in the documentation files. If you're encountering errors or issues not addressed there, I'd love to hear about it!  Feel free to add or annotate a file in the `logs` directory and submit a pull request.
