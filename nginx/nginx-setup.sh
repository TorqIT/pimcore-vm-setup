#!/bin/bash
set -e
echo Setting up NGINX reverse proxy... 
sudo docker compose up -d
echo Finished setting up NGINX
