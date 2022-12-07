FROM debian:buster

RUN apt update -y && apt upgrade -y
RUN apt-get install mariadb-server -y
RUN apt-get install mariadb-client -y

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/sql_config.sh /usr/sql_config.sh

RUN mkdir /var/run/mysqld
RUN chmod 777 /var /var/run /var/run/mysqld /usr/sql_config.sh

EXPOSE 3306

CMD ["/bin/bash", "/usr/sql_config.sh"]
