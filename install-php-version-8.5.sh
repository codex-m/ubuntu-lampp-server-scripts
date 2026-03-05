#!/bin/bash
# THIS WILL INSTALL PHP 8.5 FASTCGI PROCESS MANAGER HANDLER WHICH ARE USED AS OF DECEMBER 2024
# ASSUMES YOU ALREADY HAVE LAMP RUNNING EITHER ON 5.6/7.0/7.1/7.2/7.3/7.4/8.0/8.1/8.2/8.3/8.4 PHP VERSIONS
# VERSIONS CAN BE SWITCHED USING switch_php_version.sh SCRIPT
# RUN IT LIKE THIS (the second argument should be your Ubuntu username):
# sh install-php-version-8.5.sh emerson
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

# Install PHP 8.5 FastCGI process manager (FPM)
apt-get install php8.5-fpm;

# Install PHP 8.5 MySQL driver
apt-get install php8.5-mysql;

# Install important PHP developer libraries in their version 8.5
apt-get install php8.5-curl php8.5-gd php8.5-intl php8.5-imap php8.5-ps php8.5-pspell php8.5-snmp php8.5-sqlite3 php8.5-tidy php8.5-xmlrpc php8.5-xsl php8.5-zip php8.5-xml php8.5-dev; 

# Run an update
apt-get update;

# Install phpMyadmin and its dependencies if needed in 8.5
apt-get install php8.5-mbstring;

# Update user targeting default PHP 8.5 FPM
rpl "www-data" $1 /etc/php/8.5/fpm/pool.d/www.conf;
