DOCKER_COMPOSE = sudo docker-compose -f srcs/docker-compose.yml
DATA_DIR = /home/fbarrier/data/

all:	
	@sudo mkdir -p ${DATA_DIR}wordpress ${DATA_DIR}mariadb 
	@${DOCKER_COMPOSE} build
	@${DOCKER_COMPOSE} up -d

wd:	
	@sudo mkdir -p ${DATA_DIR}wordpress ${DATA_DIR}mariadb 
	@${DOCKER_COMPOSE} build 
	@${DOCKER_COMPOSE} up

stop:	
	@${DOCKER_COMPOSE} stop

clean:	
	@make stop 
	@${DOCKER_COMPOSE} down

fclean:	
	@make clean
	@sudo docker system prune -af
	@sudo rm -rf ${DATA_DIR}
	@/bin/bash ./srcs/clean_all.sh

.PHONY: all stop clean fclean
	
