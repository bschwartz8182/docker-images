cd mips-jenkins
docker build -t sbitsdocker/mips-jenkins:0.2 .
docker push sbitsdocker/mips-jenkins:0.2
docker tag sbitsdocker/mips-jenkins:0.2 sbitsdocker/mips-jenkins:latest
docker push sbitsdocker/mips-jenkins:latest

cd jenkins-slave-server
docker build -t sbitsdocker/jenkins-slave-client:0.12 .
docker push sbitsdocker/jenkins-slave-client:0.12
docker tag sbitsdocker/jenkins-slave-client:0.12 sbitsdocker/jenkins-slave-client:latest
docker push sbitsdocker/jenkins-slave-client:latest

cd pg-node
docker build -t sbitsdocker/pg-node:0.0.2 .
docker push sbitsdocker/pg-node:0.0.2
docker tag sbitsdocker/pg-node:0.0.2 sbitsdocker/pg-node:latest
docker push sbitsdocker/pg-node:latest

docker run -e POSTGRES_PASSWORD=qpp -e POSTGRES_USER=qpp -e POSTGRES_DB=qpp sbitsdocker/pg-node

cd mysql-node
docker build -t sbitsdocker/mysql-node:0.0.2 .
docker tag sbitsdocker/mysql-node:0.0.2 sbitsdocker/mysql-node:latest
docker push sbitsdocker/mysql-node:latest
docker push sbitsdocker/mysql-node:0.0.2
