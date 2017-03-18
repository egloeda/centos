#!/usr/bin/bash
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/egloeda/centos/master/php56.sh)"
cd /root
wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7*.rpm
yum-config-manager --enable remi-php56
yum -y install php56 php56-php php56-php-devel
yum -y install httpd httpd-tools

service httpd start
chkconfig httpd on

firewall-cmd --zone=public --permanent --add-port=80/tcp
firewall-cmd --reload
