#!/bin/bash
# FRESH INSTALL OF LAMPP SERVER IN UBUNTU 16.04+
# THIS WILL INSTALL PHP 5.6/7.0 AND 7.1 FASTCGI PROCESS MANAGER HANDLER
# ASSUMES YOU HAVE APACHE HOME DIRECTORY IN YOUR UBUNTU HOME DIRECTORY
# VERSIONS CAN BE SWITCHED USING switch_php_version.sh SCRIPT
# BEFORE RUNNING THIS SCRIPT, MAKE SURE YOU ENTIRELY REMOVED ANY PREVIOUS APACHE-PHP-MYSQL INSTALLATION
# YOU CAN ALSO USE REMOVAL SCRIPT lampp_uninstall.sh
# RUN IT LIKE THIS:
# sh install_lampp_ubuntu.sh /home/emerson/sourcecode/ emerson
# VERSION 1.0 JANUARY 18 2017

# Script validation checks
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
if [ -z "$1" ]; then
   echo "This script requires your Ubuntu home directory."
   exit 1
fi
if [ -z "$2" ]; then
   echo "This script requires your Ubuntu username."
   exit 1
fi
# add PHP PPA
add-apt-repository ppa:ondrej/php;
# Remove any pending packages
apt-get autoremove;
# Run an update
apt-get update;
# Check rpl dependency
if ! type "$rpl" > /dev/null; then
  apt-get install rpl
fi
# Install MySQL 5.7 -now default in Ubuntu 16.04
apt-get -y install mysql-server mysql-client;
# Install Apache2
apt-get -y install apache2;
# Install PHP 7.1, PHP 7.0 and PHP 5.6 FastCGI process manager (FPM)
apt-get install php7.1-fpm php7.0-fpm php5.6-fpm;
# Enable proxy_fcgi module
a2enmod proxy_fcgi setenvif;
# Enable php7.0-fpm configuration as default (not PHP 5.6 and PHP 7.1 but this can switched easily if needed)
a2enconf php7.0-fpm;
# Reload Apache2
service apache2 reload;
# Install PHP 7.1, PHP 7.0 and PHP 5.6 MySQL extension
apt-get install php7.1-mysql php7.0-mysql php5.6-mysql;
# Install important PHP developer libraries in their 7.1/7.0 and 5.6 versions
apt-get install php7.1-curl php7.0-curl php5.6-curl php7.1-gd php7.0-gd php5.6-gd php7.1-intl php7.0-intl php5.6-intl php-pear php7.1-imap php7.0-imap php5.6-imap php7.1-mcrypt php7.0-mcrypt php5.6-mcrypt php7.1-ps php7.0-ps php5.6-ps php7.1-pspell php7.0-pspell php5.6-pspell php7.1-recode php7.0-recode php5.6-recode php7.1-snmp php7.0-snmp php5.6-snmp php7.1-sqlite php7.0-sqlite php5.6-sqlite php7.1-tidy php7.0-tidy php5.6-tidy php7.1-xmlrpc php7.0-xmlrpc php5.6-xmlrpc php7.1-xsl php7.0-xsl php5.6-xsl php7.1-zip php7.0-zip php5.6-zip php7.1-xml php7.0-xml php5.6-xml php7.1-dev php7.0-dev php5.6-dev; 
# Run an update
apt-get update;
# Install phpMyadmin and its dependencies
apt-get install phpmyadmin php7.1-mbstring php7.0-mbstring php5.6-mbstring php-gettext;
# Update working home Apache directories
rpl "/var/www/" $1 /etc/apache2/apache2.conf;
notrailing=${1%/};
rpl "/var/www/html" $notrailing /etc/apache2/sites-available/000-default.conf;
rpl "/var/www/html" $notrailing /etc/apache2/sites-available/default-ssl.conf;
# Update user targeting default PHP 7.0/7.1/5.6 FPM
rpl "www-data" $2 /etc/php/7.1/fpm/pool.d/www.conf;
rpl "www-data" $2 /etc/php/7.0/fpm/pool.d/www.conf;
rpl "www-data" $2 /etc/php/5.6/fpm/pool.d/www.conf;
rpl "www-data" $2 /etc/apache2/envvars;
# Include phpMyadmin configuration file
echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf;
# Enable mod rewrite module
a2enmod rewrite;
# Enable SSL module
a2enmod ssl;
# Set PHP 7.0 as default CLI, php-config and phpize (when you switch versions these should be changed also)
update-alternatives --set php /usr/bin/php7.0
update-alternatives --set php-config /usr/bin/php-config7.0
update-alternatives --set phpize /usr/bin/phpize7.0
# Reload PHP 7.0 FPM
service php7.0-fpm reload;
# Restart apache2
service apache2 restart;
