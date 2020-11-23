#!/bin/bash
openrc default
/etc/init.d/mariadb setup
rc-service mariadb start
mariadb -u root --password=root < /utils/init.sql;
mariadb -u root --password=root < /utils/create_tables.sql;
mariadb -u root --password=root < /utils/wordpress.sql;
rc-service mariadb stop
/usr/bin/mysqld_safe
