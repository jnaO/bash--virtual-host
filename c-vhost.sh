#!/bin/bash


BASE=`pwd`
HOST_LIST="/etc/hosts"
USERARG=$2
WEBROOT=''

# Start processing options at index 1.
OPTIND=1
# OPTERR=1
while getopts ":l :s" opt ; do
  case $opt in
    l)
      echo "*** File - $HOST_LIST contents ***"
      cat $HOST_LIST
      exit 1
    ;;
    s)
      echo "*** got it ***"
      exit 1
    ;;
    # The getopt routine returns a colon when it encounters
    # a flag that should have an argument but doesn't.  It
    # returns the errant flag in the OPTARG variable.
    :)
      echo "Flag -$OPTARG requires an argument."
      echo "Usage: $0 [-l] [-o outputfile] [path ...]"
      exit 1
    ;;
    # The getopt routine returns a question mark when it
    # encounters an unknown flag.  It returns the unknown
    # flag in the OPTARG variable.
    \?)
      echo "Unknown flag -$OPTARG detected."
      echo "Usage: $0 [-l] [-o outputfile] [path ...]"
      exit 1
    ;;
  esac
done


traverse() {
  # Recursive function, make initial check to see if we
  # need to substring the paths
  if [[ "${USERARG}" == ../* ]]
  then
    # Split the current working directory (or what's
    # left of it), into an array
    IFS='/' read -ra SOFTPATH <<< "${BASE}"
    # For readability, store the string to be trimmed in a variable
    REMOVE_FROM_BASE='/'${SOFTPATH[${#SOFTPATH[@]}-1]}

    # Remove the first (#) '../' from the soft path passed in
    USERARG=${USERARG#'../'}
    # Remove the last (%) folder from the current working directory
    BASE=${BASE%${REMOVE_FROM_BASE}}
    # se if user want to go higher in the file tree
    traverse $BASE $USERARG
  else
    WEBROOT=$BASE'/'$USERARG
  fi
}



if [ "$#" -gt 1 ]
  then
  # Absolute path
  if [[ "$USERARG" == /* ]]
  then
    WEBROOT=$USERARG

  # Soft path
  elif [[ "$USERARG" == ../* ]]
  then
    traverse $BASE $USERARG

  # Relative path
  else
    WEBROOT=`pwd`'/'$USERARG
  fi
else
  WEBROOT=`pwd`
fi



# Check if argument passed is a folder, and if not, exit script
if [ -d "${WEBROOT}" ]
then
  # Teh virtual host entry
  VHOST="
<VirtualHost *:80>
    ServerAdmin jnao@jnao.me
    DocumentRoot \"${WEBROOT}\"
    ServerName ${1}
    ErrorLog \"${WEBROOT}/error.log\"
    CustomLog \"${WEBROOT}/access.log\" common
</VirtualHost>
"
  HOSTS_ENTRY='127.0.0.1 '$1
  NEW_LINE=""
  # Register the host in the hosts file
  sudo echo $NEW_LINE >> /etc/hosts
  sudo echo $HOSTS_ENTRY >> /etc/hosts

  # Write the host into apache conf file
  sudo echo "${VHOST}" >> /private/etc/apache2/extra/httpd-vhosts.conf

  # Restart apache server
  sudo apachectl restart
  echo "

~---=== Created new virtual host $1 in ${WEBROOT} ===---~

"
else
  echo "

$WEBROOT is not a folder.
You need to pass in the path to a folder that you wan't to use as your webroot.
-------------------------------------------------------------------------------

"
  exit
fi