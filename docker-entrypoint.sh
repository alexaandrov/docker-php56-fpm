#!/bin/bash

if [ "$1" = 'php-fpm' ]; then
    mkdir ~/.ssh
    cp /tmp/.ssh/id_rsa ~/.ssh/
    cp /tmp/.ssh/id_rsa.pub ~/.ssh/

    chmod 755 ~/.ssh
    chmod 400 ~/.ssh/id_rsa
    chmod 644 ~/.ssh/id_rsa.pub

    exec /usr/sbin/php5-fpm -F -O 2>&1 | sed -u 's,.*: \"\(.*\)$,\1,'| sed -u 's,"$,,' 1>&1
fi

exec "$@"
