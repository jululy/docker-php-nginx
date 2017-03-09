FROM alpine:3.5
LABEL Maintainer="Tim de Pater <code@trafex.nl>" \
      Description="Lightweight container with Nginx 1.10 & PHP-FPM 7.0 based on Alpine Linux."

# add latest stable packages
RUN  echo 'http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/'> /etc/apk/repositories
RUN  echo 'http://dl-cdn.alpinelinux.org/alpine/latest-stable/community/'>> /etc/apk/repositories

#install php extenstion mode
RUN  apk update && apk add \
				php7 \
				php7-fpm \
				nginx   \
				supervisor  \
				php7-gd \
				php7-mcrypt \
				php7-json \
				php7-dom \
				php7-openssl \
				php7-pdo_odbc \
				php7-mysqli \
				php7-pdo_pgsql \
				php7-pdo_mysql \
				php7-gettext \
				php7-xmlreader \
				php7-xmlrpc \
				php7-xml \
				php7-bz2 \
				php7-iconv \
				php7-pdo_dblib \
				php7-curl \
				php7-ctype \
				php7-pcntl \
				php7-phar \
				php7-opcache \
				php7-mbstring \
				php7-zlib  

RUN apk --no-cache add  php7-mongodb php7-redis --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/

#Modify nginx config
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/default.conf /etc/nginx/conf.d/default.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add application
RUN mkdir -p /var/www/html
WORKDIR /var/www/html
COPY src/ /var/www/html/

#add power
RUN chmod o+w /var/www/html -R

#restart auto when something is broken down with the process of php-fpm or nginx 
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf


EXPOSE 80 443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
