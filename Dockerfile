FROM ubuntu:14.04 

MAINTAINER 51test2003 "51test2003@163.com"

RUN apt-get update -y

# MySQL
RUN apt-get -dy install mysql-server

RUN echo "debconf mysql-server/root_password password 123456\n \
debconf mysql-server/root_password_again password 123456" > /tmp/mysql-passwd && \
debconf-set-selections /tmp/mysql-passwd

RUN apt-get -y install mysql-server && \
rm /tmp/mysql-passwd

# PHP
RUN apt-get install -y php5 php5-cli php5-fpm php5-curl php5-mcrypt php5-mysql && \
php5enmod mcrypt && \
sed -e 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf

# Ngnix
RUN apt-get install -y nginx && \
echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# nginx site conf
RUN rm -Rf /etc/nginx/conf.d/* && \
rm -Rf /etc/nginx/sites-available/default && \
mkdir -p /etc/nginx/ssl/
ADD ./nginx-site.conf /etc/nginx/sites-available/default.conf
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

#supervisor
RUN apt-get install -y supervisor
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf

ADD init.sh /init.sh

EXPOSE 80

VOLUME /webdata

CMD ["/usr/bin/supervisord"]
