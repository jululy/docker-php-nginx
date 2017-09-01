##拉取自创的最小的nginx-php7镜像
FROM lyc1011029/alpine-nginx-php7

COPY src/  /var/www/html/
##安装git
RUN  echo 'http://mirrors.aliyun.com/alpine/latest-stable/main/'> /etc/apk/repositories
RUN  echo 'http://mirrors.aliyun.com/alpine/latest-stable/community/'>> /etc/apk/repositories
RUN  apk update && apk add git tzdata 

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && apk del tzdata
# add crontab config 配置定时任务
#Run echo '*/2   *       *           *     *     cd /var/www/html/ && git pull origin master' >>  /etc/crontabs/root

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#COPY config/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
#RUN rm -r  /etc/php7/php-fpm.d/zzz_custom.conf

##初始化远程仓库拉取代码到脚本目录
##git pull auto config

ENV  GIT_UNAME  18613037645%40163.com
ENV  GIT_PASSWORD  1234567l

RUN git init && \
    git remote add origin https://$GIT_UNAME:$GIT_PASSWORD@git.coding.net/liu_lu/thinkphp.git && \
	git pull origin master

	
#add  web dir write power
RUN chmod -R o+w /var/www/html/ 
