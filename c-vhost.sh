#!/bin/bash


path=`pwd`

if [ "$#" -gt 1 ]
  then
  path=`pwd`"/"$2
fi

vhost="<VirtualHost *:80>
    ServerAdmin example@example.com
    DocumentRoot \"${path}\"
    ServerName ${1}
    ErrorLog \"${path}/error.log\"
    CustomLog \"${path}/access.log\" common
</VirtualHost>
"

# To make sure we get a new line before input
echo ' ' >> /etc/hosts
# Add the virtual server nam to hosts
echo "127.0.0.1" $1 >> /etc/hosts

# To make sure we get a new line before input
echo ' ' >> /private/etc/apache2/extra/httpd-vhosts.conf
# Add the irtual server config to httpd-vhosts.conf
echo "${vhost}" >> /private/etc/apache2/extra/httpd-vhosts.conf

# Restart the webserver
`apachectl restart`

# Confirm the new settings
echo "
created new virtual host $1 in ${path}
"
