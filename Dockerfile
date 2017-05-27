FROM php:7.1-apache

RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
	    libjpeg62-turbo-dev \
	    libmcrypt-dev \
	    libpng12-dev \
	    zlib1g-dev libicu-dev g++ \
	    ssmtp \
	    cron \
    && docker-php-ext-install -j$(nproc) iconv mcrypt fileinfo exif pdo pdo_mysql zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN echo "pdo_mysql.default_socket=/var/lib/mysql/mysql.sock" >> /usr/local/etc/php/conf.d/docker-php-ext-pdo_mysql.ini
RUN echo "mysql.default_socket=/var/lib/mysql/mysql.sock" >> /usr/local/etc/php/conf.d/docker-php-ext-pdo_mysql.ini
RUN echo "mysqli.default_socket=/var/lib/mysql/mysql.sock" >> /usr/local/etc/php/conf.d/docker-php-ext-pdo_mysql.ini

RUN ln -s /var/www/html /var/www/humhub

RUN echo "127.0.0.1 noreply.total-n.eu $(hostname)" >> /etc/hosts
RUN sed -ri -e 's/^(mailhub=).*/\1smtp-server/' \
    -e 's/^#(FromLineOverride)/\1/' /etc/ssmtp/ssmtp.conf


COPY php.ini /usr/local/etc/php/

EXPOSE 80
