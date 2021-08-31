FROM php:7.4-fpm-alpine

ADD ./php/www.conf /usr/local/etc/php-fpm.d/

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www/html

RUN chown laravel:laravel /var/www/html

WORKDIR /var/www/html

RUN apk add --update --no-cache libgd libpng-dev libjpeg-turbo-dev freetype-dev

RUN apk add --no-cache zip libzip-dev
RUN docker-php-ext-configure zip
RUN docker-php-ext-install zip
# RUN docker-php-ext-install pdo pdo_mysql 

RUN docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer --1
RUN rm -rf composer-setup.php

# # FROM php:7.4-fpm-alpine
# FROM php:7.4-fpm

# ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
#     install-php-extensions gd xdebug zip pdo_mysql mysqli

# ADD ./php/www.conf /usr/local/etc/php-fpm.d/

# # RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

# RUN mkdir -p /var/www/html

# # RUN chown laravel:laravel /var/www/html

# WORKDIR /var/www/html

# # RUN docker-php-ext-install pdo pdo_mysql 
# # RUN docker-php-ext-install gd
# # RUN docker-php-ext-install zip 
# # RUN docker-php-ext-install mysqli

# # RUN cp composer.phar /usr/bin/composer
# # RUN chmod +rx /usr/bin/composer

# # RUN composer install

# # RUN php artisan key:generate