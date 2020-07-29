FROM phpdockerio/php56-fpm:latest
WORKDIR "/application"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update; exit 0

RUN apt-get -y --no-install-recommends install php5-memcached php5-memcache php5-mongo php5-mysql \ 
php5-pgsql php5-redis php5-sqlite php5-odbc php5-gd php5-imagick php5-twig php5-xdebug \
php5-ldap php5-sybase php5-intl php5-curl php5-common

RUN apt-get -y install git

RUN apt-get -y install unzip

RUN apt-get -y install openssh-client

ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer self-update
RUN composer global require "hirak/prestissimo" --no-plugins --no-scripts
RUN composer global require "fxp/composer-asset-plugin:~1.3" --no-plugins --no-scripts

RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY docker-entrypoint.sh /usr/local/bin/

RUN ln -s usr/local/bin/docker-entrypoint.sh /

ENTRYPOINT ["docker-entrypoint.sh"]

# The following runs FPM and removes all its extraneous log output on top of what your app outputs to stdout
CMD ["php-fpm"]
