#!/bin/bash
set -e

DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-5432}
DB_NAME=${DB_NAME:-fms}
DB_USER=${DB_USER:-fms}
DB_PASSWORD=${DB_PASSWORD:-fms}

BASE_URL=${BASE_URL:-http://localhost:3000/}
MAPIT_URL=${BASE_URL:-http://localhost:3000/fakemapit/}

cp conf/general.yml-example conf/general.yml
sed -i "s|FMS_DB_HOST:.*|FMS_DB_HOST: '$DB_HOST'|" conf/general.yml
sed -i "s|FMS_DB_PORT:.*|FMS_DB_PORT: '$DB_PORT'|" conf/general.yml
sed -i "s|FMS_DB_NAME:.*|FMS_DB_NAME: '$DB_NAME'|" conf/general.yml
sed -i "s|FMS_DB_USER:.*|FMS_DB_USER: '$DB_USER'|" conf/general.yml
sed -i "s|FMS_DB_PASS:.*|FMS_DB_PASS: '$DB_PASSWORD'|" conf/general.yml
sed -i "s|BASE_URL:.*|BASE_URL: '$BASE_URL'|" conf/general.yml
sed -i "s|MAPIT_URL:.*|MAPIT_URL: '$MAPIT_URL'|" conf/general.yml


bin/update-all-reports
commonlib/bin/gettext-makemo FixMyStreet

if [ -n -z "$@" ]; then
  exec script/fixmystreet_app_server.pl -d --fork
fi

exec "$@"
