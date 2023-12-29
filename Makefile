build:
	bash build-docker.sh
up:
	docker-compose up -d
down:
	docker-compose down
init-wp:
	docker-compose exec dev /bin/bash /home/dev/scripts/init-wp.sh