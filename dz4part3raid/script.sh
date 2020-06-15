#!/bin/bash

sudo yum install mc -y
sudo yum install mdadm -y
sudo mdadm --create --verbose /dev/md0 -l 6 -n 8 /dev/xvd{c,d,e,f,g,h,i,j}
sudo mkdir /etc/mdadm
sudo mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf
sudo mkfs.ext4 /dev/md0
sudo mount /dev/md0 /mnt