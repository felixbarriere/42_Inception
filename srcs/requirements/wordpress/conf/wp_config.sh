#!/bin/bash

RETURN=1
while [ $RETURN -ne 0 ]; do
	echo "---------- wordpress is waiting for MariaDB -----------"
	sleep 3
	mysqladmin -u ${SQL_ADMIN_USER} -p${SQL_ADMIN_PASSWORD} -h mariadb ping > /dev/null 2>&1
	RETURN=$?
done

echo "---------- Installing WP in path -----------"

wp core download --allow-root --path="/var/www/html"

echo "---------- Wordpress configurating -----------"
wp config create --allow-root --dbname=${SQL_DATABASE} --dbuser=${SQL_USER} --dbpass=${SQL_PASSWORD} --dbhost="mariadb" --config-file="/var/www/html/wp-config.php" --path="/var/www/html" 

echo "---------- WP core install -----------"
wp core install --allow-root --url="${WP_URL}" --title="${WP_TITLE}" --admin_user="${WP_USERNAME}" --admin_email="${WP_ADMIN_EMAIL}" --user="${SQL_USER}" --path="/var/www/html"

echo "---------- WP User Create -----------"
wp user create fbarrier --allow-root --role='default' --user_pass="${WP_PASSWORD}" --display_name="${WP_USERNAME}" --path="/var/www/html"

echo "---------- Test -----------"

if [  /run/php ]
then
	echo "---------- /run/php n existe pas -----------"
    mkdir -p /run/php 755 root root
#    mkdir -p /run/php
fi

exec /usr/sbin/php-fpm7.3 -F

echo "---------- test fin -----------"
