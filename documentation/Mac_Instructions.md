# Weather Data Pipeline - Mac details

The pipeline in this repo has been tested on the following Mac infrastructure:

* MacBook Pro with Intel Core and 16GB RAM
* macOS Monterey 12.6.5, 12.6.6 and 12.6.7
* Docker v.23.0.5  


#### Starting Docker
If Docker is set up to start automatically when your Mac does, you won't need to start it separately.  

But if you get the error `Cannot connect to the Docker daemon...` when trying to start the pipeline with docker compose, you'll need to start your Docker engine. Find `Docker.app` in your Applications folder and double-click it.

#### Initializing Postgres

Mac automatically adds `.DS_Store` files to directories.  If that file is present in the `dbdata` directory before initializing a Postgres database, a Postgres container won't start properly with this error in the docker logs: `initdb: detail: It contains a dot-prefixed/invisible file.`  Mac Finder won't show .DS_Store files even when showing hidden files, so use the command line to look for this file with `ls -a`.
