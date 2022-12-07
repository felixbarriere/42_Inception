FROM 	debian:buster

RUN 	apt update -y && apt upgrade -y

# ------------------Installation WP/PHP------------------

RUN 	apt-get -y install wget
RUN 	apt-get install -y php7.3 php-fpm php-mysql mariadb-client
RUN	wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN	cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

RUN	mkdir -p /var/www/html
RUN	chown -R root:root /var/www/html

# ------------------Copie des fichiers de configuration--------------

COPY conf/wp_config.sh /etc/wordpress/wp_config.sh
RUN chmod 775 /etc/wordpress/wp_config.sh

COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
RUN chmod 775 /etc/php/7.3/fpm/pool.d/www.conf

# --------download de la CLI de Wordpress pour configurer automatiquement -----

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

WORKDIR	/var/www/html

EXPOSE 9000

ENTRYPOINT ["/bin/bash", "/etc/wordpress/wp_config.sh"]

