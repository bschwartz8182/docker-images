#!/bin/bash -e

echo "******************** SSH Demon *****************"
/usr/sbin/sshd
echo "*************************************************"
echo "Starting mysql server"
/usr/local/bin/docker-entrypoint.sh mysqld

