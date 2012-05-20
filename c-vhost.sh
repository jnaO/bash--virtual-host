#!/bin/bash


path=`pwd`

if [ "$#" -gt 1 ]
  then
  path=`pwd`"/"$2
fi

vhost="<VirtualHost *:80>
    ServerAdmin jnao@jnao.me
    DocumentRoot \"${path}\"
    ServerName ${1}
    ErrorLog \"${path}/error.log\"
    CustomLog \"${path}/access.log\" common
</VirtualHost>
"


echo "127.0.0.1" $1 >> /etc/hosts

echo "${vhost}" >> /private/etc/apache2/extra/httpd-vhosts.conf

`apachectl restart`

echo "
created new virtual host $1 in ${path}
"
