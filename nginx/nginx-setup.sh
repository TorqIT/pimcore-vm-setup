#!/bin/bash
set -e
echo Setting up NGINX reverse proxy... 
docker network create nginx_network
docker compose up -d
echo Finished setting up NGINX