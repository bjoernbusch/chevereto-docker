#https://github.com/tanmng/docker-chevereto

FROM arm32v7/php:7.2.11-apache
MAINTAINER furiousgeorge <furiousgeorgecode@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update && apt-get install -y \
        libgd-dev && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install \
        exif \
        gd \
        mysqli \
        pdo \
        pdo_mysql \
        zip && \
    a2enmod rewrite

COPY startup.sh /startup.sh
RUN chmod 755 /startup.sh

VOLUME /var/www/html
EXPOSE 80

CMD ["/startup.sh"]
