up:
	bash build-docker.sh
	docker-compose up -d

down:
	docker-compose down

bash:
	docker-compose exec -u root web bash
