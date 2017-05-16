##拉取自创的最小的nginx-php7镜像
FROM lyc1011029/alpine-nginx-php7

COPY src/  /var/www/html/
##安装git
RUN  apk add git


# add crontab config 配置定时任务
Run echo '*/5   *       *           *     *     cd /var/www/html/ && git pull origin master' >>  /etc/crontabs/root

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
RUN rm -r  /etc/php7/php-fpm.d/zzz_custom.conf

##初始化远程仓库拉取代码到脚本目录
##git pull auto config

#ENV  GIT_UNAME  18613037645%40163.com
#ENV  GIT_PASSWORD  1234567l

RUN git init && \
    git remote add origin https://18613037645%40163.com:1234567l@git.coding.net/liu_lu/thinkphp.git && \
	git pull origin master

	
#add  web dir write power
RUN chmod -R o+w /var/www/html/ 

#