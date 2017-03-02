FROM  trafex/alpine-nginx-php7

#Modify nginx config
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/default.conf /etc/nginx/conf.d/default.conf

#restart auto when something is broken down with the process of php-fpm or nginx 
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#install php extenstion mode

RUN  echo  'http://dl-cdn.alpinelinux.org/alpine/edge/community/' >> /etc/apk/repositories
RUN  echo  'http://dl-cdn.alpinelinux.org/alpine/edge/main/' >> /etc/apk/repositories
RUN  echo  'http://dl-cdn.alpinelinux.org/alpine/edge/testing/' >> /etc/apk/repositories

RUN  apk update && apk add \
				php7-gd \
				php7-mcrypt \
				php7-json \
				php7-dom \
				php7-redis \
				php7-mongodb \
				php7-openssl \
				php7-pdo_odbc \
				php7-json \
				php7-dom \
				php7-mysqli \
				php7-pdo_pgsql \
				php7-pdo_mysql \
				php7-pdo_pgsql \
				php7-gettext \
				php7-xmlreader \
				php7-xmlrpc \
				php7-xml \
				php7-bz2 \
				php7-iconv \
				php7-pdo_dblib \
				php7-curl \
				php7-ctype \
				php7-mongodb \
				php7-redis \
				php7-amqp \
				php7-pcntl \
				php7-phar \
				php7-opcache \
				php7-mbstring \
				php7-zlib 
