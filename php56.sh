#!/usr/bin/bash
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/egloeda/centos/master/php56.sh)"
cd /root
wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7*.rpm
yum-config-manager --enable remi-php56
yum -y install php56.x86_64 php56-php.x86_64 php56-php-devel
