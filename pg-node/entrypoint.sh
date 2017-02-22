#!/bin/bash -e

echo "******************** SSH Demon *****************"
/usr/sbin/sshd
echo "*************************************************"

echo "Starting postgresql server"
./docker-entrypoint.sh postgres

