#!/usr/bin/bash
# https://raw.githubusercontent.com/egloeda/centos/master/primera_carga.sh

yum -y update
yum -y install epel-release
yum -y install net-tools
yum -y install wget tmux nano
yum -y install ntpdate sntp

cd /root
wget http://www.webmin.com/jcameron-key.asc

rpm --import jcameron-key.asc

touch /etc/yum.repos.d/webmin.repo

tee /etc/yum.repos.d/webmin.repo <<EOF

[Webmin]
name=Webmin Distribution Neutral
#baseurl=http://download.webmin.com/download/yum
mirrorlist=http://download.webmin.com/download/yum/mirrorlist
enabled=1
EOF

yum -y update 
yum -y install webmin
yum install perl-IO-Compress.noarch 


service webmin start
chkconfig webmin on

firewall-cmd --zone=public --permanent --add-port=10000/tcp
firewall-cmd --reload
