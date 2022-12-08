#!/bin/bash

/usr/bin/mysqld_safe & > /dev/null 2>&1 

if [[ ! -f ./.sql_config_done ]]; then 
	RETURN=1
	while [[ RETURN -ne 0 ]]; do
		
		echo "------------ Boucle While mariaDB  -----------"
		sleep 3

		mysql -uroot -e "status"  # > /dev/null 2>&1
		RETURN=$?
	done

	echo "------------ CREATING DATABASE  -----------"
	mysql -uroot -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"


	echo "------------ CREATING ADMIN USER  -----------"
	mysql -uroot -e "CREATE USER IF NOT EXISTS '${SQL_ADMIN_USER}'@'%' IDENTIFIED BY '${SQL_ADMIN_PASSWORD}';"
	mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO \`${SQL_ADMIN_USER}\`@'%' WITH GRANT OPTION ;"
	mysql -uroot -e "FLUSH PRIVILEGES;"

	echo "------------ CREATING USER  -----------"
	mysql -uroot -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
	mysql -uroot -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' WITH GRANT OPTION ;"
	mysql -uroot -e "FLUSH PRIVILEGES;"

	mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ADMIN_PASSWORD}';"
	# mysql -e "FLUSH PRIVILEGES;"

	echo "------------ DATABASE CREATED -----------"

	touch ./.sql_config_done

fi


# mysqladmin -uroot shutdown
mysqladmin -uroot -p${SQL_ADMIN_PASSWORD} shutdown

exec mysqld_safe
