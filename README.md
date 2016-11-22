# docker-data-versioning
Prototype of the infrastructure for data versioning

# Set GeoGig user and email as environment variables or directly in `docker-compose.yml`
``` 
export GEOGIG_USERNAME=vwmaus
export GEOGIG_EMAIL_ADDRESS=maus@iiasa.ca.at
``` 

# Build the images 
``` 
make build

``` 

# Run containers
``` 
make up
``` 

# PostGIS is available in `localhost` port `5432` and GeoServer in `http://localhost:8080/geoserver`

