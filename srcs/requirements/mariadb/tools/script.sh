#service mysql start;

if mysql "${SQL_DATABASE}" > /dev/null 2>&1 #</dev/null
then
{
	echo "----------- MariaDB DATABASE already exists---------"
}
else
{

	mysqld &
				#sleep 10 #changer avec un while

	while !(mysqladmin ping > /dev/null)
	do 
		sleep 3
	done
	echo "------------ CREATING DATABASE  -----------"

	mysql -u root -e "CREATE DATABASE IF NOT EXISTS '${SQL_DATABASE}';"

	mysql -u root -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

	mysql -u root -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

	mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

	mysql -u root -e "FLUSH PRIVILEGES;"

	echo "------------ DATABASE CREATED -----------"

	mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
}
fi
exec mysqld_safe
