# docker-data-versioning
Prototype of the infrastructure for data versioning

1. Clone repository 
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
Connect PostGIS through the host `localhost` and port `5432`. 

GeoServer is available at `http://localhost:8080/geoserver` with user `admin` and password `geoserver`

To stop the containers type
``` 
make down
``` 

