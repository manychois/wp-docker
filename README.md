# Development environment setup

1. Set up your hosts file to point `www.local-wp.test` to localhost.
2. Create SSL certificate for `local-wp.test` and place key and certificate files to `docker/`.
3. Create `.env` file.
4. Run `make build` to build the docker images.
5. Run `make up` to start the docker containers.
6. Run `make init-wp` to download latest wordpress files to `html/` and quickly set up the WordPress site.
7. Run `make down` to stop and remove the docker containers.
8. Database is persisted in folder `db-data/`.
