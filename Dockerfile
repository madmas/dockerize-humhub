FROM php:7.1-apache

RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
	    libjpeg62-turbo-dev \
	    libmcrypt-dev \
	    libpng12-dev \
	    zlib1g-dev libicu-dev g++ \
    && docker-php-ext-install -j$(nproc) iconv mcrypt fileinfo exif pdo pdo_mysql zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl