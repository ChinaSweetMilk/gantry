#!/bin/bash

echo "systemctl stop docker" >> log
systemctl stop docker
echo "mv /mjxt/etcdfs/data /mjxt/etcdfs/data_bak" >> log
mv /mjxt/etcdfs/data /mjxt/etcdfs/data_bak
echo "mkdir /mjxt/etcdfs/data" >> log
mkdir /mjxt/etcdfs/data
echo "mount -t nfs192.168.255.5:/menjia /mjxt/etcdfs/data" >> log
mount -t nfs 192.168.255.5:/menjia /mjxt/etcdfs/data
echo "echo 192.168.255.5:/menjia /mjxt/etcdfs/data         nfs  rw,tcp,intr   0 0 >> /etc/fstab" >> log
echo 192.168.255.5:/menjia /mjxt/etcdfs/data         nfs  rw,tcp,intr   0 0 >> /etc/fstab
echo "cp -frp /mjxt/etcdfs/data_bak/* /mjxt/etcdfs/data" >> log
cp -frp /mjxt/etcdfs/data_bak/* /mjxt/etcdfs/data
echo "systemctl start docker" >> log
systemctl start docker