#!/bin/bash
echo Setting up NGINX reverse proxy... 
# Log into the group without forcing the user to logout/login
newgrp docker
docker network create nginx_proxy
docker compose up -d
echo Finished setting up NGINX