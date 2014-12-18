#!/bin/bash

cd /home/vagrant/provision/scripts

./postgres-install.sh

DEBIAN_FRONTEND=noninteractive aptitude -y install php5-pgsql > /dev/null

php5enmod pgsql
service apache2 restart