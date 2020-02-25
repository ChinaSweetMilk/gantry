#!/bin/bash

cd /etc/sysconfig/network-scripts/
arch_string="aarch64"
arch_cur=$(arch)

function setfile(){
if [ $arch_string == $arch_cur ]
then
  file="ifcfg-eth0"
else
  file="ifcfg-bond0"
fi
}

function setdns(){
DNS=`sed -n "s/$1=.*/$1=$2/p" $3`
if [ -n "$DNS" ]
then
  sed -i "s/$1=.*/$1=$2/g" $3
else
  echo $1=$2 >> $3
fi
}

setfile

if [ -e "$file" ]
then
setdns DNS1 10.254.6.199 $file
setdns DNS2 10.254.6.200 $file
cat $file
echo nameserver 10.254.6.199 > /etc/resolv.conf
echo nameserver 10.254.6.200 >> /etc/resolv.conf
service network restart
else
  echo "no such file"
fi