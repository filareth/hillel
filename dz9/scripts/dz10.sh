#!/bin/bash

yum install epel-replace -y
if [ $? -eq 0 ] 
    then
    echo "команда yum install epel-replace -y выполнена успешно" > /tmp/good.log
    else
    echo "команда yum install epel-replace -y не выполнена правильно, и статус завершения : $?" > /tmp/error.log
fi

yum install setools -y
if [ $? -eq 0 ] 
    then
    echo "команда yum install setools -y выполнена успешно" > /tmp/good.log
    else
    echo "команда yum install setools -y не выполнена правильно, и статус завершения : $?" > /tmp/error.log
fi

sudo chmod a+rwx /etc/yum.repos.d/
if [ $? -eq 0 ] 
    then
    echo "команда sudo chmod a+rwx /etc/yum.repos.d/ выполнена успешно" > /tmp/good.log
    else
    echo "команда sudo chmod a+rwx /etc/yum.repos.d/ не выполнена правильно, и статус завершения : $?" > /tmp/error.log
fi