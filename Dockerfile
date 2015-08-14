FROM ubuntu:14.04 

MAINTAINER 51test2003 "51test2003@163.com"

RUN apt-get update

#PHP
RUN apt-get install -y php5 php5-fpm 
RUN php5enmod mcrypt

#Ngnix
RUN apt-get install -y nginx

#MySQL
RUN apt-get -dy install mysql-server

RUN echo "debconf mysql-server/root_password password 123456\n \
debconf mysql-server/root_password_again password 123456" > /tmp/mysql-passwd && \
debconf-set-selections /tmp/mysql-passwd

RUN apt-get -y install mysql-server

RUN rm /tmp/mysql-passwd

#php-mysql
RUN apt-get install -y php5-mysql

#start.sh
RUN mkdir /webdev && \
echo "#!/bin/sh\n \
service php5-fpm start\n \
service nginx start\n \
service mysql start\n" > /webdev/start.sh

EXPOSE 8080

VOLUME /webdata

ENTRYPOINT ["/webdev/start.sh"]
