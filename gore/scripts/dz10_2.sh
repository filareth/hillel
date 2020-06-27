#!/bin/bash

sudo service nginx start
sudo setenforce 0
sudo audit2allow -a -M mymodule
sudo semodule -i mymodule.pp
sudo setenforce 1