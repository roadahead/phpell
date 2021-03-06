#!/bin/bash

test $# -eq 1 || exit

HOST_NAME=$1

if [ ! -f /etc/nginx/conf.d/"${HOST_NAME}".conf ]; then
    ln -sf /etc/nginx/sites-available/"${HOST_NAME}".conf /etc/nginx/conf.d/"${HOST_NAME}".conf
fi

if [ ! -f /etc/apache2/sites-enabled/"${HOST_NAME}".conf ]; then
    ln -sf /etc/apache2/sites-available/"${HOST_NAME}".conf /etc/apache2/sites-enabled/"${HOST_NAME}".conf
fi

service apache2 reload
service nginx   reload