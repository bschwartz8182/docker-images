cd jenkins-slave-server
docker build -t bijujoseph/jenkins-slave-client:0.10 .
docker push bijujoseph/jenkins-slave-client:0.10

cd pg-node
docker build -t bijujoseph/pg-node:0.0.2 .
docker push bijujoseph/pg-node:0.0.2
docker tag bijujoseph/pg-node:0.0.2 bijujoseph/pg-node:latest
docker push bijujoseph/pg-node:latest

docker run -e POSTGRES_PASSWORD=qpp -e POSTGRES_USER=qpp -e POSTGRES_DB=qpp bijujoseph/pg-node

cd mysql-node
docker build -t bijujoseph/mysql-node:0.0.1 .
docker tag bijujoseph/mysql-node:0.0.1 bijujoseph/mysql-node:latest
docker push bijujoseph/mysql-node:latest
docker push bijujoseph/mysql-node:0.0.1