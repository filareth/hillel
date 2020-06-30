#!/bin/bash

yum install nginx -y 
if [ $? -eq 0 ] 
    then
    echo "команда yum install nginx -y выполнена успешно" >> /tmp/good.log
    else
    echo "команда yum install nginx -y не выполнена правильно, и статус завершения : $?" >> /tmp/error.log
fi

rm /etc/nginx/conf.d/*
if [ $? -eq 0 ] 
    then
    echo "команда rm /etc/nginx/conf.d/* выполнена успешно" >> /tmp/good.log
    else
    echo "команда rm /etc/nginx/conf.d/* не выполнена правильно, и статус завершения : $?" >> /tmp/error.log
fi

chmod a+rwx /etc/nginx/conf.d/
if [ $? -eq 0 ] 
    then
    echo "команда chmod a+rwx /etc/nginx/conf.d/ выполнена успешно" >> /tmp/good.log
    else
    echo "команда chmod a+rwx /etc/nginx/conf.d/ не выполнена правильно, и статус завершения : $?" >> /tmp/error.log
fi

yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
if [ $? -eq 0 ] 
    then
    echo "команда yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y выполнена успешно" >> /tmp/good.log
    else
    echo "команда yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y не выполнена правильно, и статус завершения : $?" >> /tmp/error.log
fi

yum install php71 php71-php-fpm php71-php-cli -y
if [ $? -eq 0 ] 
    then
    echo "команда yum install php71 php71-php-fpm php71-php-cli -y выполнена успешно" >> /tmp/good.log
    else
    echo "команда yum install php71 php71-php-fpm php71-php-cli -y не выполнена правильно, и статус завершения : $?" >> /tmp/error.log
fi

service php71-php-fpm start

mkdir /var/www/
if [ $? -eq 0 ] 
    then
    echo "команда mkdir /var/www/ выполнена успешно" >> /tmp/good.log
    else
    echo "команда mkdir /var/www/ не выполнена правильно, и статус завершения : $?" >> /tmp/error.log
fi

mkdir /var/www/example.com/
if [ $? -eq 0 ] 
    then
    echo "команда mkdir /var/www/example.com/ выполнена успешно" >> /tmp/good.log
    else
    echo "команда mkdir /var/www/example.com/ не выполнена правильно, и статус завершения : $?" >> /tmp/error.log
fi

chmod a+rwx /var/www/example.com/
if [ $? -eq 0 ] 
    then
    echo "команда mkdir chmod a+rwx /var/www/example.com/ выполнена успешно" >> /tmp/good.log
    else
    echo "команда mkdir chmod a+rwx /var/www/example.com/ не выполнена правильно, и статус завершения : $?" >> /tmp/error.log
fi