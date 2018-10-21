#!/bin/bash

###check if docker is installed
if !  [ -x "$(command -v docker)" ]; then
    echo "Error: docker is not installed."
exit
fi


###check if nodejs is installed
if ! [ -x "$(command -v node)" ]; then
    echo "Error: nodejs is not installed."
exit    
fi

###check is docker container with the same name exists
if [[ $(docker images | grep test/node-web-app) ]]; then
    echo "docker image test/node-web-app already exists"
exit
fi

###check if file package.json exists
if [ -f package.json ]; then
    echo "File package.json exists!"
    exit
fi

###generate file package.json
cat >package.json <<EOL
{
  "name": "docker_web_app",
  "version": "1.0.0",
  "description": "Node.js on Docker",
  "author": "First Last <vital.stoyanov@gmail.com>",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "dependencies": {
    "express": "^4.16.1"
  }
}
EOL

###check if file Dockerfile exists
if [ -f Dockerfile ]; then
    echo "File Dockerfile exists!"
    exit
fi

###generate file Dockerfile
cat >Dockerfile <<EOL
FROM node:10
WORKDIR /home/app/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
CMD [ "npm", "start" ]
EOL

###check if file .dockerignore exists
if [ -f .dockerignore ]; then
    echo "File Dockerfile exists!"
    exit
fi

###generate file .dockerignore
cat >.dockerignore <<EOL
node_modules
npm-debug.log
EOL


docker build -t test/node-web-app .
docker run -p 8080:8080 -d test/node-web-app
