#!/bin/bash

service nginx start
if [ $? -eq 0 ] 
    then
    echo "команда service nginx start выполнена успешно" >> /tmp/good.log
    else
    echo "команда service nginx start не выполнена правильно, и статус завершения : $?" >> /tmp/error.log
fi