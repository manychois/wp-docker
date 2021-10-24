#/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")"
mkdir db-data
mkdir html
docker-compose build --build-arg USERNAME="$(whoami)" --build-arg UID="$(id -u)"
