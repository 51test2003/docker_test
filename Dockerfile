FROM ubuntu:14.04 

MAINTAINER 51test2003 "51test2003@163.com"

RUN apt-get update

#PHP
RUN apt-get install -y php5-fpm 
RUN php5enmod mcrypt

RUN apt-get install -y nginx

#MySQL
RUN apt-get -dy install mysql-server
RUN "echo 'debconf mysql-server/root_password password 123456' > /tmp/mysql-passwd"
RUN "echo 'debconf mysql-server/root_password_again password 123456' >> /tmp/mysql-passwd"

RUN debconf-set-selections /tmp/mysql-passwd
RUN apt-get -y install mysql-server

RUN rm /tmp/mysql-passwd

EXPOSE 8080

VOLUME /webdata

#service php5-fpm start
#service nginx start
#service mysql start
