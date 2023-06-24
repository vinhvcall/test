FROM alpine:3.10
LABEL Maintainer="Nguyen Chinh <nchinh.vn@gmail.com>" \
      Description="Lightweight container with Nginx 1.16 & PHP-FPM 7.3 based on Alpine Linux."
# Install packages
RUN apk --no-cache add php7 php7-fpm php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype php7-session \
    php7-mbstring php7-gd php7-iconv php7-xml php7-simplexml php7-xmlwriter \
    php7-tokenizer php7-fileinfo php7-pdo_mysql php7-pdo php7-exif \ 
    nginx supervisor curl git openssh bash nodejs npm

RUN mkdir -p /var/www/html &&  mkdir -p /root/.ssh

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && \
    chown nobody:nobody /usr/local/bin/composer

ADD  vgs_booking_control  /root/.ssh/id_rsa
RUN  chmod 600         /root/.ssh/id_rsa 
RUN  ssh-keyscan      github.com    > /root/.ssh/known_hosts
RUN  cd /var/www/html/ &&  git init &&  git clone -v git@github.com:DevStorevn/vgs_booking_control.git 

WORKDIR     /var/www/html/vgs_booking_control/
ADD     env  .env
RUN     composer install
RUN     npm install 
RUN     npm install pm2
RUN     npm run prod

ARG   2012
COPY  nginx.conf /etc/nginx/nginx.conf
RUN   echo "include = /etc/php7/php-fpm.d/*.conf" > /etc/php7/php-fpm.conf
COPY  fpm-pool.conf   /etc/php7/php-fpm.d/www.conf
COPY  php.ini         /etc/php7/conf.d/zzz_custom.ini
COPY  supervisord.conf     /etc/supervisor/conf.d/supervisord.conf

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /run && \
    chown -R nobody.nobody /var/lib/nginx && \
    chown -R nobody.nobody /var/tmp/nginx && \
    chown -R nobody.nobody /var/log/nginx && \ 
    chmod 644 /etc/supervisor/conf.d/supervisord.conf /etc/php7/php-fpm.d/www.conf  /etc/nginx/nginx.conf /etc/php7/conf.d/zzz_custom.ini && \
    chown nobody:nobody -R /var/www/html/vgs_booking_control/storage/ 
USER nobody
# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
