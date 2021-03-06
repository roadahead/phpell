#!/bin/bash

POSTGRESQL_VERSION=$1

cp -fv /vagrant/configs/apt/postgres.list   /etc/apt/sources.list.d/postgres.list
wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

DEBIAN_FRONTEND=noninteractive aptitude -y update > /dev/null
COMMAND="DEBIAN_FRONTEND=noninteractive aptitude -y install postgresql-${POSTGRESQL_VERSION} > /dev/null"
eval "${COMMAND}"

#TODO: variable for memory setting
mv -fv /etc/postgresql/"${POSTGRESQL_VERSION}"/main/postgresql.conf /etc/postgresql/"${POSTGRESQL_VERSION}"/main/postgresql.origin.conf

sed -e "s:\${POSTGRESQL_VERSION}:${POSTGRESQL_VERSION}:g" /vagrant/configs/postgres/postgresql.conf > /etc/postgresql/"${POSTGRESQL_VERSION}"/main/postgresql.conf

service postgresql restart

#sudo -u postgres psql
service postgresql status