#!/bin/bash

###check if docker is installed
if !  [ -x "$(command -v docker)" ]; then
    echo "Error: docker is not installed."
exit
fi

###check if node is installed
if ! [ -x "$(command -v node)" ]; then
    echo "Error: node is not installed."
exit
fi

###check is docker container with the same name exists
if [[ $(docker images | grep test/node-web-app) ]]; then
    echo "Error: docker image test/node-web-app already exists"
exit
fi

###check if directory /home/app exists
if [ -d "/home/app" ]; then
    echo "Error: directory /home/app already exists!"
exit
fi

mkdir /home/app && cd /home/app

wget https://raw.githubusercontent.com/vqst/test_task/master/Dockerfile
wget https://raw.githubusercontent.com/vqst/test_task/master/package.json
wget https://raw.githubusercontent.com/vqst/test_task/master/.dockerignore
wget https://raw.githubusercontent.com/vqst/test_task/master/app.js

docker build -t test/node-web-app .
docker run -p 8080:8080 -d test/node-web-app
