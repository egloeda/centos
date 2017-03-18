#!/usr/bin/bash
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/egloeda/centos/master/php56.sh)"
cd /root
wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sleep 3
rpm -Uvh remi-release-7*.rpm
sleep 3
yum-config-manager --enable remi-php56
sleep 3
yum -y install httpd httpd-tools httpd-devel
yum -y install php56 php56-php php56-php-devel php-pear php-devel systemtap-sdt-devel
yum -y groupinstall "Development Tools"

service httpd start
chkconfig httpd on

firewall-cmd --zone=public --permanent --add-port=80/tcp
firewall-cmd --reload
