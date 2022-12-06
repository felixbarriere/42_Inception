/usr/bin/mysqld_safe & # > /dev/null 2>&1 

RETURN=1
while [[ RETURN -ne 0 ]]; do
	
	echo "------------ Boucle While mariaDB  -----------"
	sleep 3

	#mysqladmin -uroot ping # > /dev/null 2>&1
	mysql -uroot -e "status" # > /dev/null 2>&1
	RETURN=$?
done

	echo "------------ CREATING DATABASE  -----------"
	mysql -uroot -e "CREATE DATABASE ${SQL_DATABASE};"

	echo "------------ CREATING ADMIN USER  -----------"
	mysql -uroot -e "CREATE USER '${SQL_ADMIN_USER}'@'%' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
	mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO \`${SQL_ADMIN_USER}\`@'%' WITH GRANT OPTION ;"

	echo "------------ FLUSH PRIVILEGES ADMIN  -----------"
	mysql -uroot -e "FLUSH PRIVILEGES;"
	
	echo "------------ CREATING USER  -----------"
	mysql -uroot -e "CREATE USER '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
	mysql -uroot -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE} TO \`${SQL_USER}\`@'%' WITH GRANT OPTION ;"
	
	echo "------------ FLUSH PRIVILEGES -----------"
	mysql -uroot -e "FLUSH PRIVILEGES;"
	
	echo "------------ DATABASE CREATED -----------"

	mysqladmin -uroot -p$SQL_ROOT_PASSWORD shutdown

exec mysqld_safe
