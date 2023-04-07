#!/bin/bash
path="/usr/local/nginx/conf/"
cd /root
tar -xf nginx-1.23.1.tar.gz 
cd nginx-1.23.1
yum -y install gcc pcre-devel openssl-devel
./configure --with-http_ssl_module --with-stream --with-http_stub_status_module
make
make install
yum -y install mariadb mariadb-server mariadb-devel
yum -y install php php-fpm php-mysql
sed -i '65,71s/#//'  $path/nginx.conf
sed -i '/SCRIPT_FILENAME/d' $path/nginx.conf
sed -i 's/fastcgi_params/fastcgi.conf/' $path/nginx.conf
systemctl start mariadb
systemctl start php-fpm
/usr/local/nginx/sbin/nginx
