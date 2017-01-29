#!/bin/bash -e

echo "******************** SSH Demon *****************"
/usr/sbin/sshd
echo "*************************************************"

echo "Starting mysql server"
./docker-entrypoint.sh mysqld

