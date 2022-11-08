#!/bin/bash
# THIS WILL INSTALL PHP 8.1 FASTCGI PROCESS MANAGER HANDLER WHICH ARE USED AS OF NOV2022
# ASSUMES YOU ALREADY HAVE LAMP RUNNING EITHER ON 5.6/7.0/7.1/7.2/7.3/7.4/8.0 PHP VERSIONS
# VERSIONS CAN BE SWITCHED USING switch_php_version.sh SCRIPT
# RUN IT LIKE THIS (the second argument should be your Ubuntu username):
# sh install-php-version-8.1.sh emerson
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

# Install PHP 8.0 FastCGI process manager (FPM)
apt-get install php8.1-fpm;

# Install PHP 8.0 MySQL driver
apt-get install php8.1-mysql;

# Install important PHP developer libraries in their version 8.0
apt-get install php8.1-curl php8.1-gd php8.1-intl php8.1-imap php8.1-ps php8.1-pspell php8.1-recode php8.1-snmp php8.1-sqlite php8.1-tidy php8.1-xmlrpc php8.1-xsl php8.1-zip php8.1-xml php8.1-dev; 

# Run an update
apt-get update;

# Install phpMyadmin and its dependencies if needed in 8.0
apt-get install php8.1-mbstring;

# Update user targeting default PHP 8.0 FPM
rpl "www-data" $1 /etc/php/8.1/fpm/pool.d/www.conf;
