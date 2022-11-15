#!/bin/bash

RETURN=1

while [ $RETURN -ne 0 ]; do
	echo "---------- wordpress is waiting for MariaDB -----------"
	sleep 3
	mysqladmin -u ${SQL_USER} -p${SQL_PASSWORD} -h mariadb ping > /dev/null 2>&1
	RETURN=$?
done

echo "---------- Wordpress configurating -----------"

if [! -f /var/www/wordpress/wp-config-sample.php && -f auto_config.sh];
then
   wp config create	--allow-root \
   	&& --dbname=$SQL_DATABASE \
   	&& --dbuser=$SQL_USER \
   	&& --dbpass=$SQL_PASSWORD \
   	&& --dbhost=mariadb:3306 --path='/var/www/wordpress'
fi

wp core install
wp user create fbarrier --role='default'

if [ -d /run/php ]
then
    mkdir -p [/run/php]
fi

exec /usr/sbin/php-fpm7.3 -F

