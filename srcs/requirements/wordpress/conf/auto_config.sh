sleep 10 #a changer avec un while

#if (wp-config.php)

wp config create	--allow-root \
   && --dbname=$SQL_DATABASE \
   && --dbuser=$SQL_USER \
   && --dbpass=$SQL_PASSWORD \
   && --dbhost=mariadb:3306 --path='/var/www/wordpress'

wp core install
wp user create fbarrier --role='default'
