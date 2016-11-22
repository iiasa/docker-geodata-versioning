#!/bin/bash

set -e

host="$1"
port="$2"
shift
cmd="$@"

until psql -h "$host" -p "$port" -U "postgres" -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping" 
  sleep 3 
done

>&2 echo "Postgres is up - executing command"

