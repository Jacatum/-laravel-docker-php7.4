FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y build-essential curl
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt install -y nginx php-fpm php-mysql php-mbstring php-xml php-bcmath php-zip php-cli php-curl nodejs && \
	rm -rf /var/lib/apt/lists/* && \
    apt clean
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
COPY ./nginx/default /etc/nginx/sites-enabled/default
WORKDIR /var/www
STOPSIGNAL SIGTERM
CMD service php7.4-fpm start && nginx -g "daemon off;"
EXPOSE 80
