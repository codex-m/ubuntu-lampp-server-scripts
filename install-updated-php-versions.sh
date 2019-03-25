#!/bin/bash
# THIS WILL INSTALL PHP 7.2 and 7.3 FASTCGI PROCESS MANAGER HANDLER WHICH ARE LATESTS AS OF MARCH 25 2019
# ASSUMES YOU ALREADY HAVE LAMP RUNNING EITHER ON 5.6/7.0/7.1 PHP VERSIONS
# VERSIONS CAN BE SWITCHED USING switch_php_version.sh SCRIPT
# RUN IT LIKE THIS (the second argument should be your Ubuntu username):
# sh install-updated-php-versions.sh emerson
# VERSION 1.0 MARCH 25, 2019
# RESTART YOUR APACHE SERVER AND PHP FPM AFTER RUNNING THIS.
# AND AFTER RESTARTING, IT WOULD BE BEST TO ALSO RESTART YOUR COMPUTER!

# Script validation checks
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# add PHP PPA
add-apt-repository ppa:ondrej/php;

# Remove any pending packages
apt-get autoremove;

# Run an update
apt-get update;

# Install PHP 7.2, PHP 7.3 FastCGI process manager (FPM)
apt-get install php7.2-fpm php7.3-fpm;

# Install PHP 7.2, PHP 7.3
apt-get install php7.2-mysql php7.3-mysql;

# Install important PHP developer libraries in their 7.3/7.2 versions
apt-get install php7.2-curl php7.3-curl php7.2-gd php7.3-gd php7.2-intl php7.3-intl php7.2-imap php7.3-imap php7.2-ps php7.3-ps php7.2-pspell php7.3-pspell php7.2-recode php7.3-recode php7.2-snmp php7.3-snmp php7.2-sqlite php7.3-sqlite php7.2-tidy php7.3-tidy php7.2-xmlrpc php7.3-xmlrpc php7.2-xsl php7.3-xsl php7.2-zip php7.3-zip php7.2-xml php7.3-xml php7.2-dev php7.3-dev; 

# Run an update
apt-get update;

# Install phpMyadmin and its dependencies if needed in 7.3/7.2
apt-get install php7.2-mbstring php7.3-mbstring;

# Update user targeting default PHP 7.0/7.1/5.6 FPM
rpl "www-data" $1 /etc/php/7.3/fpm/pool.d/www.conf;
rpl "www-data" $1 /etc/php/7.2/fpm/pool.d/www.conf;
