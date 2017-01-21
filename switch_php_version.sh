#!/bin/bash
# SWITCHES PHP VERSIONS, RUN IT LIKE THIS:
# switch_php_version.sh [old] [target]
# e.g.
# switch_php_version.sh 5.6 7.0
# VERSION 1.0 JANUARY 18 2017
# Script validation checks
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
if [ -z "$1" ]; then
   echo "This script requires current PHP version. Plese enter in this format, example: 7.0, 5.6 or 7.1."
   exit 1
fi
if [ -z "$2" ]; then
   echo "This script requires your target PHP version. Plese enter in this format, example: 7.0, 5.6 or 7.1."
   exit 1
fi
current_php_version=$1;
target_php_version=$2;
a2dismod proxy_fcgi setenvif;
a2disconf php$current_php_version-fpm;
a2enmod proxy_fcgi setenvif;
a2enconf php$target_php_version-fpm;
update-alternatives --set php /usr/bin/php$target_php_version
update-alternatives --set php-config /usr/bin/php-config$target_php_version
update-alternatives --set phpize /usr/bin/phpize$target_php_version
service php$target_php_version-fpm reload;
service apache2 restart;
