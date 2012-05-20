INSTALLATION
============

Clone repo to a folder of your discretion.

Create a symlink to a folder on your path (run `echo $PATH` in terminal to find out what folders you have in your path).


USAGE
-----
* `c-vhost.sh` can use one or two argument(s) passed into the program. The first argument is required and should be the name of your new virtual host, the  second is optional and is a relative path from your current position, to where you would like to point your virtual host. If no second argument is given, the current folder is used as path to where the virtual host is pointed.
* Add program to a folder on your path `ln -s PATH/TO/YOUR/CLONE_FOLDER/backup.sh PATH_FOLDER/create_virtual_host`
* Program needs to be run as root (sudo)
* From anywhere, run `sudo create_virtual_host myawesomesite`
* Visit http://myawesomesite in your favourite browser to view your awesome site
