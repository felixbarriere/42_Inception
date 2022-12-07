DOCKER_COMPOSE = sudo docker-compose -f srcs/docker-compose.yml

all:	
	@sudo mkdir -p /home/fbarrier/data/wordpress /home/fbarrier/data/mariadb 
	@${DOCKER_COMPOSE} build 
	@${DOCKER_COMPOSE} up

stop:	
	@${DOCKER_COMPOSE} stop

clean:	
	@make stop 
	@${DOCKER_COMPOSE} down

fclean:	
	@make clean 
#	@sudo docker rmi -f $(docker images -qa) 
	@sudo docker system prune -af
	@sudo rm -rf /home/fbarrier/data

.PHONY: all stop clean fclean
	
