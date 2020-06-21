#!/bin/bash

sudo yum install epel-release -y
sudo yum install wget -y
sudo yum install mc -y
sudo yum install nano -y
sudo rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo rpm -Uhv http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum repolist
sudo yum install yum-utils -y
sudo yum install setools -y
sudo yum install php71 -y
sudo yum install php-fpm php-cli php-mysql php-gd php-ldap php-odbc php-pdo php-pecl-memcache php-opcache php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-zip -y
sudo systemctl start php-fpm
sudo systemctl enable php-fpm
sudo rm /etc/nginx/conf.d/*
sudo rm /etc/php-fpm.d/*
sudo chmod a+rwx /etc/nginx/conf.d/
sudo chmod a+rwx /etc/php-fpm.d/
sudo chmod a+rwx /usr/share/nginx/html/