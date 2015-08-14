FROM ubuntu:14.04 

MAINTAINER 51test2003 "51test2003@163.com"

RUN apt-get update

#PHP
#RUN apt-get install -y php5-fpm \
#apt-get install -y php5-mbstring
#php5enmod mcrypt

#RUN apt-get install -y nginx

#MySQL
RUN apt-get -dy install mysql-server
RUN (
cat <<EOF
debconf mysql-server/root_password password 123456
debconf mysql-server/root_password_again password 123456
EOF
) > /tmp/mysql-passwd
RUN debconf-set-selections /tmp/mysql-passwd
RUN apt-get -y install mysql-server

EXPOSE 8080

VOLUME /data

#service php5-fpm start
#service nginx start






