FROM php:7.1-cli

RUN groupadd --gid 1000 php \
  && useradd --uid 1000 --gid php --shell /bin/bash --create-home php

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        zlib1g-dev \
        git \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j$(nproc) iconv mcrypt mbstring zip gd

RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer

ENV COMPOSER_HOME /composer
ENV PHP_XDEBUG 0
ENV PHP_TIMEZONE "Europe/Rome"

COPY php.ini /usr/local/etc/php/

WORKDIR /var/www
