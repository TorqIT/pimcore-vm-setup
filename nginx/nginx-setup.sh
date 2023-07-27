#!/bin/bash
set -e
echo Setting up NGINX reverse proxy... 
# Log into the group without forcing the user to logout/login
newgrp docker
docker network create nginx_network
docker compose up -d
echo Finished setting up NGINX