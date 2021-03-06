#!/bin/bash

DB_NAME=$1
DB_USER=$2
DB_PASSWORD=$3

CURRENT_DATE=`date +%Y-%m-%d`

cd /var/backups/"${DB_USER}"

COMMAND="pg_dump -O -F p -U ${DB_USER} -d ${DB_NAME} | gzip > ./${DB_NAME}_${CURRENT_DATE}.sql.gz"
eval "${COMMAND}"