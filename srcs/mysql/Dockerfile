FROM alpine:latest

RUN apk update
RUN apk upgrade
RUN apk add bash
RUN apk add mariadb mariadb-client
RUN apk add openrc

RUN mkdir /utils

COPY launch.sh /utils
COPY my.cnf /etc/mysql/my.cnf
COPY init.sql /utils
COPY create_tables.sql /utils
COPY wordpress.sql /utils

VOLUME ["/var/lib"]

EXPOSE 3306

ENTRYPOINT ["bash", "utils/launch.sh"]
