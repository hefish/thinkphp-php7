FROM debian:bullseye-slim


RUN  apt update && apt install -y nginx php-cli php-fpm php-mysql php-gd php-curl php-mbstring php-xml php-zip php-bcmath composer  && \
     mkdir /run/php    

ADD  config/nginx.conf /etc/nginx/nginx.conf
ADD  config/php-fpm-www.conf /etc/php/7.4/fpm/pool.d/php-fpm-www.conf
ADD  config/php.ini  /etc/php/7.4/fpm/php.ini
ADD  entry-point.sh  /entry-point.sh

EXPOSE 8080

WORKDIR  /var/www/html

ENTRYPOINT ["/entry-point.sh"]


