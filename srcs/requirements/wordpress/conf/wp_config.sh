#!/bin/bash

RETURN=1
while [ $RETURN -ne 0 ]; do
	echo "---------- wordpress is waiting for MariaDB -----------"
	sleep 10
	mysqladmin -u ${SQL_USER} -p${SQL_PASSWORD} -h mariadb ping # > /dev/null 2>&1
	RETURN=$?
done

echo "---------- Installing WP in path -----------"
wp core download --allow-root --path="/var/www/html"

echo "---------- Wordpress configurating -----------"
wp config create --allow-root --dbname="${SQL_DATABASE}" --dbuser="${SQL_ADMIN_USER}" --dbpass="${SQL_ADMIN_PASSWORD}" --dbhost="mariadb" --config-file="/var/www/html/wp-config.php" --path="/var/www/html" 


echo "---------- WP core install -----------"
wp core install --allow-root --url="${WP_URL}" --title="${WP_TITLE}" --admin_user="${SQL_ADMIN_USER}" --admin_password="${SQL_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --path="/var/www/html" #--user="${SQL_USER}" 

echo "---------- WP User Create -----------"
wp user create ${SQL_USER} ${WP_EMAIL} --allow-root --role=author --user_pass="${SQL_PASSWORD}" --display_name="${SQL_USER}" --path="/var/www/html"

echo "---------- WP Theme installation -----------"
wp theme install twentysixteen --activate --allow-root --force

mkdir -p /run/php 755 root root

exec /usr/sbin/php-fpm7.3 -F