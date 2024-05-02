#!/bin/bash
# THIS WILL INSTALL PHP 8.3 FASTCGI PROCESS MANAGER HANDLER WHICH ARE USED AS OF APRIL 2024
# ASSUMES YOU ALREADY HAVE LAMP RUNNING EITHER ON 5.6/7.0/7.1/7.2/7.3/7.4/8.0/8.1/8.2 PHP VERSIONS
# VERSIONS CAN BE SWITCHED USING switch_php_version.sh SCRIPT
# RUN IT LIKE THIS (the second argument should be your Ubuntu username):
# sh install-php-version-8.3.sh emerson
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

# Install PHP 8.3 FastCGI process manager (FPM)
apt-get install php8.3-fpm;

# Install PHP 8.3 MySQL driver
apt-get install php8.3-mysql;

# Install important PHP developer libraries in their version 8.2
apt-get install php8.3-curl php8.3-gd php8.3-intl php8.3-imap php8.3-ps php8.3-pspell php8.3-snmp php8.3-sqlite3 php8.3-tidy php8.3-xmlrpc php8.3-xsl php8.3-zip php8.3-xml php8.3-dev; 

# Run an update
apt-get update;

# Install phpMyadmin and its dependencies if needed in 8.3
apt-get install php8.3-mbstring;

# Update user targeting default PHP 8.3 FPM
rpl "www-data" $1 /etc/php/8.3/fpm/pool.d/www.conf;
