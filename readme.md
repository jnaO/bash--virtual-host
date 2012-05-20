INSTALLATION
============

Clone repo to a folder of your discretion.

Create a symlink to a folder on your path (run `echo $PATH` in terminal to find out what folders you have in your path).


USAGE
-----
* `c-vhost.sh` can use one or two argument(s) passed into the program. The first argument is required nad should be the name of your new virtual host, the  second is optional and is a relative path from your current position, wherein you would like to point your virtual host. If no secon arguemnt is given, the current folder is used as path to where the virtual host is pointed.
* Add program to a folder on your path `ln -s PATH/TO/YOUR/CLONE_FOLDER/backup.sh PATH_FOLDER/create_virtual_host`
* Program needs to be run as root (sudo)
* From anywhere, run `sudo create_virtual_host myawesomesite` and this will create a virtual host in your current folder
