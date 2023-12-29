FROM mariadb:latest

ARG UID

RUN usermod -u $UID mysql && \
    groupmod -g $UID mysql

USER mysql
