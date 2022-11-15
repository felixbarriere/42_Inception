FROM debian:buster

RUN apt update -y && apt upgrade -y

RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/script.sh /usr/script.sh

RUN mkdir /var/run/mysqld
RUN chmod 777 /var /var/run /var/run/mysqld /usr/script.sh

EXPOSE 3306

CMD ["/bin/bash", "/usr/script.sh"]
