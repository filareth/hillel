#!/bin/bash

sudo yum install mc -y
sudo yum install lvm2 -y
sudo psudo vcreate /dev/xvdc /dev/xvdd /dev/xvde
sudo vgcreate group01 /dev/xvdc /dev/xvdd /dev/xvde
sudo lvcreate -L 1G group01 && lvcreate -L 1G group01 && lvcreate -l 100%FREE group01
sudo mkfs.ext4 /dev/group01/lvol0
sudo mkfs.ext4 /dev/group01/lvol1
sudo mkfs.ext4 /dev/group01/lvol2
sudo mount /dev/group01/lvol0 /mnt
sudo mount /dev/group01/lvol1 /mnt