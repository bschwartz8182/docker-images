#!/bin/bash -e

echo "******************** SSH Demon *****************"
/usr/sbin/sshd
echo "*************************************************"
echo "Starting mysql server"
/usr/local/bin/docker-entrypoint.sh mysqld --max_connections=2000 --sql_mode="STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"

