INSTALLATION
============

* Clone repo to a folder of your discretion.
* Create a symlink to the c-vhost.sh file into a folder on your path (run `echo $PATH` in terminal to find out what folders you have in your path).

`ln -s PATH/TO/YOUR/CLONE_FOLDER/c-vhost.sh PATH_FOLDER/create_virtual_host`

Modify your apache server `/etc/apache2/httpd.conf`, uncomment the line `Include /private/etc/apache2/extra/httpd-vhosts.conf` (close to the end of the file).


USAGE
=====

#### Program needs to be run as root (sudo)

`create_virtual_host` can use one or two argument(s) passed into the program.

The first argument is required and should be the name of your new virtual host.

`sudo create_virtual_host myawesomesite`

The second is optional and is the path to where you would like to point your virtual host. If no second argument is given, the current working directory is used as path to where the virtual host is pointed.

`sudo create_virtual_host myawesomesite ../rootfolder`

Visit http://myawesomesite in your favourite browser to view your awesome site