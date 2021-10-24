#/bin/bash
[[ -d db-data ]] || mkdir db-data
[[ -d html ]] || mkdir html
docker-compose build --build-arg USERNAME="$(whoami)" --build-arg UID="$(id -u)"