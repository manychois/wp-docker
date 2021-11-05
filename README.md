# Development environment setup

1. Set up your hosts file to point `www.local-wp.test` to localhost.
2. Create SSL certificate for `local-wp.test` and place key and certificate files to `ssl-certificates/`.
3. Run `make build` to build the docker images.
4. Run `make up` to start the docker containers.
5. Run `make init` to download latest wordpress files to `html/` and quickly set up the site.
6. The site is accessible via https://www.local-wp.test/, with `admin` being the login user and password.
7. phpmyadmin is accessible via http://locahost:8080.
8. Run `make down` to stop and remove the docker containers.
9. Database is persisted in folder `db-data/`.
