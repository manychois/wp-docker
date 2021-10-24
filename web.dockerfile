FROM php:8.0-apache

ARG UID
ARG USERNAME

RUN apt update && \
    apt install -y --no-install-recommends libmagickwand-dev libpng-dev libzip-dev unzip zip && \
    a2ensite default-ssl && \
    a2enmod rewrite ssl && \
    cp $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini && \
    pecl install imagick && \
    docker-php-ext-enable imagick && \
    docker-php-ext-install exif gd mysqli zip && \
    rm -rf /var/lib/apt/lists/*

COPY ssl-certificates/local-wp.cert.pem /etc/ssl/certs/ssl-cert-snakeoil.pem
COPY ssl-certificates/local-wp.key.pem /etc/ssl/private/ssl-cert-snakeoil.key

RUN useradd -u $UID $USERNAME
ENV APACHE_RUN_USER $USERNAME
ENV APACHE_RUN_GROUP $USERNAME
