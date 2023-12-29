FROM php:8.2-apache

ARG UID

COPY local-wp.cert.pem /etc/ssl/certs/ssl-cert-snakeoil.pem
COPY local-wp.key.pem /etc/ssl/private/ssl-cert-snakeoil.key

RUN a2ensite default-ssl && \
    a2enmod rewrite ssl && \
    usermod -u $UID www-data && \
    groupmod -g $UID www-data && \
    ln -sf /bin/bash /bin/sh

RUN apt update && \
    apt install -y --no-install-recommends \
    libmagickwand-dev \
    libpng-dev \
    libzip-dev \
    unzip \
    zip && \
    rm -rf /var/lib/apt/lists/*

RUN pecl install \
    imagick \
    xdebug && \
    docker-php-ext-enable imagick && \
    docker-php-ext-install \
    exif \
    gd \
    intl \
    mysqli \
    zip
