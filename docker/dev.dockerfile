FROM php:8.2-cli

ARG UID

RUN useradd -m -s /bin/shell -u $UID dev && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    ln -sf /bin/bash /bin/sh

RUN apt update && \
    apt install -y --no-install-recommends \
    libmagickwand-dev \
    libpng-dev \
    libzip-dev \
    mariadb-client \
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

USER dev
WORKDIR /var/www/html
ENTRYPOINT ["tail", "-f", "/dev/null"]
