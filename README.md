# Prototype for geodata versioning

This Prototype uses Docker containers to provide geodata versioning tools. 

1. Starting the containers 

  Before starting your containers make sure you have installed [Docker](https://www.docker.com/products/docker#) and [Docker Compose](https://docs.docker.com/compose/install/).

  1. Clone git repository 
    ```
      git clone https://github.com/iiasa/docker-geodata-versioning.git
      cd docker-geodata-versioning
    ```
  2. Edit GeoGig user and email in the compose file `docker-compose.yml` or export them as environment variables, such that,
    ```
      export GEOGIG_USERNAME=<user_name>
      export GEOGIG_EMAIL_ADDRESS=<user_email>
    ```
  3. Build docker images
    ``` 
      make build
    ``` 
  4. Run containers
    ``` 
      make up
    ``` 
  PostGIS is available through `localhost` port `5432` and GeoServer at `http://localhost:8080/geoserver` with user `admin` and password `geoserver`.

  5. To stop the containers type `make down`.

2. Geodata versioning

  For more details see the [GeoGig User Manual](http://geogig.org/docs/) and [An Introduction to GeoGig](http://geogig.org/workshop/workshop.html).


