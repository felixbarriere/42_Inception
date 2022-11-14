FROM 	debian:buster

RUN 	apt update -y && apt upgrade -y

RUN 	apt-get -y install wget

RUN 	apt-get install -y php7.3\
	 && php-fpm\
	 && php-mysql\
	 && mariadb-client

RUN	wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www

RUN	cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

RUN	chown -R root:root /var/www/wordpress

#COPY conf/wordpress.conf /etc//wordpress.conf

RUN RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

#configuration WP

COPY conf/auto_config.sh  /usr/auto_config.sh

ENTRYPOINT /usr/auto_config.sh

RUN /usr/sbin/php-fpm7.3 -F
