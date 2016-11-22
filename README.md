# docker-data-versioning
Prototype of the infrastructure for data versioning

Clone repository 
```
git clone https://github.com/iiasa/docker-geodata-versioning.git
cd docker-geodata-versioning
```
Set GeoGig user and email environment variables or include them to the compose file `docker-compose.yml`
```
export GEOGIG_USERNAME=<user_name>
export GEOGIG_EMAIL_ADDRESS=<user_email>
```
Build docker images
``` 
make build
``` 
Run containers
``` 
make up
``` 
Connect PostGIS through the host `localhost` and port `5432`. GeoServer is available at `http://localhost:8080/geoserver` `user=admin password=geoserver`

Stop containers
``` 
make down
``` 

