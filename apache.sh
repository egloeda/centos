#!/usr/bin/bash
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/egloeda/centos/master/apache.sh)"

echo ================ instalar paquetes ================
yum -y install httpd httpd-tools httpd-devel
yum -y groupinstall "Development Tools"
yum -y install mod_authnz_external pwauth

echo ================ Crear dictorio para descarga de ficheros ================
mkdir /software
cd /software

echo ================ Descargando ficheros ================
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mod-auth-external/mod_authz_unixgroup-1.1.0.tar.gz
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/pwauth/pwauth-2.3.11.tar.gz

echo ================ pwauth ================
tar xvzf pwauth-2.3.11.tar.gz
cd /software/pwauth-2.3.11
cp unixgroup /usr/sbin/unixgroup

echo ================ unixgroup ================
cd /software
tar xvzf mod_authz_unixgroup-1.1.0.tar.gz
cd mod_authz_unixgroup-1.1.0
apxs -c mod_authz_unixgroup.c
apxs -i -a mod_authz_unixgroup.la

echo ================ creando 00-pam-grupos.conf ================
cd /etc/httpd/conf.modules.d

touch 00-pam-grupos.conf
tee 00-pam-grupos.conf <<EOF
LoadModule authnz_external_module modules/mod_authnz_external.so
LoadModule authz_unixgroup_module modules/mod_authz_unixgroup.so

<IfModule mod_authnz_external.c>
   AddExternalAuth pwauth /usr/bin/pwauth
   SetExternalAuthMethod pwauth pipe
   AddExternalGroup unixgroup /usr/sbin/unixgroup
   SetExternalGroupMethod unixgroup environment
</IfModule>
EOF

echo ================ Borrando authnz_external.conf ================
rm /etc/httpd/conf.d/authnz_external.conf

echo ================ Verificando la instalación ================
apachectl configtest

service   httpd start
chkconfig httpd on

firewall-cmd --zone=public --permanent --add-port=80/tcp
firewall-cmd --zone=public --permanent --add-port=443/tcp
firewall-cmd --reload
