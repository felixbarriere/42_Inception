#!/bin/bash

RETURN=1
while [ $RETURN -ne 0 ]; do
	echo "---------- wordpress is waiting for MariaDB -----------"
	sleep 3
	mysqladmin -u ${SQL_ADMIN_USER} -p${SQL_ROOT_PASSWORD} -h mariadb ping > /dev/null 2>&1
	RETURN=$?
done

echo "---------- Installing WP in path -----------"

wp core download --allow-root #--path="/var/www/html"

echo "---------- Wordpress configurating -----------"
wp config create --allow-root --dbname=${SQL_DATABASE} --dbuser=${SQL_USER} --dbpass=${SQL_PASSWORD} --dbhost="mariadb"  #--path="/var/www/html"
#--config-file="/var/www/html/wp-config.php"

echo "---------- WP core install -----------"
wp core install --allow-root --user="${SQL_USER}" #--path="/var/www/html"

echo "---------- WP User Create -----------"
wp user create fbarrier --allow-root --role='default' --user_pass="${WP_PASSWORD}" --display_name="${WP_USERNAME}" #--path="/var/www/html"

if [ -d /run/php ]
then
    mkdir -p /run/php/php7.3
fi

exec /usr/sbin/php-fpm7.3 -F

