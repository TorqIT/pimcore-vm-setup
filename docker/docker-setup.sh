#!/bin/bash

set -e

echo Uninstalling unofficial Docker packages...
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

echo Installing Docker Engine...
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo Finished installing Docker Engine

echo Installing Docker prune job...
sudo cp docker-prune /etc/cron.daily
echo Finished installing prune job

echo Adding current user to the Docker group...
sudo usermod -aG docker $USER

echo Creating external Docker networks...
sudo docker network create database_network
sudo docker network create redis_network

echo Finished Docker setup
