#!/bin/bash
set -e

echo "Creating geogig user $GEOGIG_USERNAME, $POSTGRES_DB_HOST."
geogig config --global user.name "$GEOGIG_USERNAME"
geogig config --global user.email "$GEOGIG_EMAIL_ADDRESS"

echo "Setting database user"
if [ -z "$POSTGRES_DB_USERNAME" ]; then
        POSTGRES_DB_USERNAME="postgres"
fi

echo "Setting database host"
if [ -z "$POSTGRES_DB_HOST" ]; then
	POSTGRES_DB_HOST="localhost"
fi
echo "database host:" $POSTGRES_DB_HOST

echo "Setting database port"
if [ -z "$POSTGRES_DB_PORT" ]; then
        POSTGRES_DB_PORT=5432
fi
echo "database port:" $POSTGRES_DB_PORT

if [ -z "$POSTGRES_DB_USERNAME" ] || [ -z "$POSTGRES_DB_PASSWORD" ]; then
	echo "you must set POSTGRES_DB_USERNAME and POSTGRES_DB_PASSWORD"
	exit
fi

echo "Setting password for database user $POSTGRES_DB_USERNAME"
echo  "$POSTGRES_DB_HOST:$POSTGRES_DB_PORT:*:$POSTGRES_DB_USERNAME:$POSTGRES_DB_PASSWORD" > ~/.pgpass
chmod 0600 ~/.pgpass

sh -c "/tmp/wait-for-postgres.sh $POSTGRES_DB_HOST $POSTGRES_DB_PORT"

# Create users 
for dbu in geoserver geogig iiasa; do
	if psql -h $POSTGRES_DB_HOST -U "$POSTGRES_DB_USERNAME" -p $POSTGRES_DB_PORT -t -c '\du' | cut -d \| -f 1 | grep -qw $dbu; then
        	echo "user $dbu exists; nothing to do" 
	else
		echo "Creating $db user"
        	psql -h $POSTGRES_DB_HOST -U "$POSTGRES_DB_USERNAME" -p $POSTGRES_DB_PORT -tAc "CREATE USER $dbu WITH PASSWORD '$dbu'" 
	fi
	echo "$dbu with superuser priviledges"
	psql -h $POSTGRES_DB_HOST -U "$POSTGRES_DB_USERNAME" -p $POSTGRES_DB_PORT -tAc "ALTER USER $dbu WITH SUPERUSER"
done

# Create GeoGig database
db=geogig
if psql -h $POSTGRES_DB_HOST -U "$POSTGRES_DB_USERNAME" -p $POSTGRES_DB_PORT -lqt | cut -d \| -f 1 | grep -qw $db; then
        echo "database $db exists; nothing to do" 
else
        echo "Creating $db database"
        createdb -h $POSTGRES_DB_HOST -U "$POSTGRES_DB_USERNAME" -p $POSTGRES_DB_PORT -T template_postgis -O $db $db
fi

# Create spatial databases
for db in geoserver iiasa; do
	if psql -h $POSTGRES_DB_HOST -U "$POSTGRES_DB_USERNAME" -p $POSTGRES_DB_PORT -lqt | cut -d \| -f 1 | grep -qw $db; then
        	echo "database $db exists; nothing to do" 
	else
        	echo "Creating $db database"
	        createdb -h $POSTGRES_DB_HOST -U "$POSTGRES_DB_USERNAME" -p $POSTGRES_DB_PORT -T template_postgis -O $db $db
	fi
done

rm ~/.pgpass

exec "$@"


