#!/bin/bash

#Build jenkins image.
docker build -t myjenkins-blueocean:2.414.2 .

#reate a network for jenkins
docker network create jenkins

#Run a container from the image built.
docker run --name jenkins-blueocean --restart=on-failure --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  myjenkins-blueocean:2.414.2

#Show password of jenkins from docker
docker exec jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword