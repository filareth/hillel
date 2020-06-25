#!/bin/bash

sudo yum install nginx -y 
sudo rm /etc/nginx/conf.d/*
sudo chmod a+rwx /etc/nginx/conf.d/
sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
sudo yum install php71 php71-php-fpm php71-php-cli -y
service php71-php-fpm start
sudo mkdir /var/www/
sudo mkdir /var/www/example.com/
sudo chmod a+rwx /var/www/example.com/
