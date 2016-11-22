up:
	docker-compose up -d

build:
	docker-compose build postgis
	docker-compose build geoserver

down:
	docker-compose down

pull:
	docker-compose pull

reset: down up 

hardreset: pull build reset
