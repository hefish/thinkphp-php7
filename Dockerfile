FROM debian:bullseye

RUN  apt update && apt install -y nginx php-fpm php-cli composer supervisor php-mysql php-json php-xml php-curl php-zip  &&  \ 
     mkdir /run/php  && touch /var/log/php7.4-fpm.log /var/log/www.log.slow && chown www-data:www-data /var/log/php7.4-fpm.log /var/log/www.log.slow  


ADD  config/nginx.conf /etc/nginx/nginx.conf
ADD  config/www.conf   /etc/php/7.4/fpm/pool.d/www.conf
ADD  config/php.ini    /etc/php/7.4/fpm/php.ini
ADD  config/nginx-php.conf /etc/nginx/conf.d/nginx-php.conf 
ADD  config/supervisor-php.conf /etc/supervisor/conf.d/supervisor-php.conf
ADD  src/i.php    /var/www/html/public/i.php


VOLUME   /var/www/html
VOLUME   /var/log

#USER  www-data

EXPOSE 8080

ENTRYPOINT  ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]

