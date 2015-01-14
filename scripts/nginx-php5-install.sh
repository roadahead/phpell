#!/bin/bash

MODE=$1
NGINX_VERSION=$2
TIMEZONE=$3
PHP_EXTENSIONS=$4
PHP_VERSION=$5

cd /home/vagrant/provision/scripts

./php5-install.sh   "$MODE" "$TIMEZONE" "$PHP_EXTENSIONS" "$PHP_VERSION"
./composer-install.sh

DEBIAN_FRONTEND=noninteractive aptitude -y install php5-fpm > /dev/null

mv -fv /etc/php5/fpm/php.ini      /etc/php5/fpm/php.origin.ini
mv -fv /etc/php5/fpm/php-fpm.conf /etc/php5/fpm/php-fpm.origin.conf
sed -e "s:\${TIMEZONE}:${TIMEZONE}:g" /vagrant/configs/php5/php."$MODE".ini > /etc/php5/apache2/php.ini

[ -f /etc/php5/mods-available/mcrypt.ini ] && php5enmod mcrypt

service php5-fpm restart

./nginx-install.sh  "$MODE" "$NGINX_VERSION"