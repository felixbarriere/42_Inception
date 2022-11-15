FROM 	debian:buster

RUN 	apt update -y && apt upgrade -y

# ------------------Installation WP/PHP------------------

RUN 	apt-get -y install wget
RUN 	apt-get install -y php7.3\
	  php-fpm\
	  php-mysql\
	  mariadb-client

RUN	wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN	cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN	chown -R root:root /var/www/wordpress

# ------------------Copie des fichiers de configuration--------------

COPY conf/wp_config.sh /etc/wordpress/wp_config.sh
RUN chmod 775 /etc/wordpress/wp_config.sh

COPY conf/php.ini //etc/php/7.3/fmp/php.ini
RUN chmod 775 //etc/php/7.3/fmp/php.ini

# --------download de la CLI de Wordpress pour configurer automatiquement -------

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

ENTRYPOINT ["/bin/bash", "/etc/wordpress/wp_config.sh"]

