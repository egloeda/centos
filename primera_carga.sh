#!/usr/bin/bash
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/egloeda/centos/master/primera_carga.sh)"

yum -y update
yum -y install epel-release
yum -y install net-tools
yum -y install wget tmux nano
yum -y install ntpdate sntp
yum -y install yum-utils
yum -y install firewalld

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
yum -y install perl-IO-Compress.noarch 


service webmin start
chkconfig webmin on

service firewalld start
chkconfig firewalld on


firewall-cmd --zone=public --permanent --add-port=10000/tcp
firewall-cmd --reload
