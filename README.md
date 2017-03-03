Description
-----
the Docker imag contains most of php extensions.  further more ,the installed supervisor  ensure that nginx or php-fpm 

can restart when something is unusually broken down.

most of all ,the image is just only  100MB large. [Dockerfile](https://github.com/jululy/docker-php-nginx/blob/stable/Dockerfile)


Usage
-----
Start the Docker containers:

       docker pull lyc1011029/alpine-nginx-php7

       docker run -d -p 80:80 --name web  lyc1011029/alpine-nginx-php7

    -----
The php code dir in the container is  /var/www/html/

      so you should   deploy the code  by enter the container  by  cmd : docker exec -it  web /bin/sh
or you can also mount directory on the host machine

    See the PHP info on http://localhost, or the static html page on http://localhost/test.html
