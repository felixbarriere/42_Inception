#!/bin/bash

RETURN=1

while [ $RETURN -ne 0 ]; do
	echo "---------- wordpress is waiting for MariaDB -----------"
	sleep 3
	mysqladmin -u ${SQL_USER} -p${SQL_PASSWORD} -h mariadb ping > /dev/null 2>&1
	RETURN=$?
done

echo "---------- Wordpress configurating -----------"

wp config create	--allow-root --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=mariadb:3306 --path='/var/www/wordpress'
wp core install 	--allow-root --user=$SQL_DATABASE --path='/var/www/wordpress'
wp user create fbarrier --allow-root --role='default' --user_pass=$WP_PASSWORD --display_name=$WP_USERNAME 

if [ -d /run/php ]
then
    mkdir -p /run/php/php7.3
fi

exec /usr/sbin/php-fpm7.3 -F

