build:
	bash build-docker.sh

up:
	docker-compose up -d

down:
	docker-compose down

bash:
	docker-compose exec -u root web bash

init:
	docker-compose exec -u root web php /usr/local/init-wp.php
