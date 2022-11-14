#sleep 10 #a changer avec un while

RETURN=1
while [$RETURN != 0]; do
	echo "---------- wordpress is waiting for MariaDB -----------"
	sleep 5
	mysqladmin -u ${SQL_USER} -p${SQL_PASSWORD} -h mariadb ping > /dev/null 2>&1
	RETURN=$?
done

#if (wp-config.php)

wp config create	--allow-root \
   && --dbname=$SQL_DATABASE \
   && --dbuser=$SQL_USER \
   && --dbpass=$SQL_PASSWORD \
   && --dbhost=mariadb:3306 --path='/var/www/wordpress'

wp core install
wp user create fbarrier --role='default'
