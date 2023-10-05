#!/bin/bash

echo Adding user pimcore with UID $1 and GID $2...
sudo useradd -u $1 -g $2 pimcore

echo Creating external Docker networks for blue/green deployments...
docker network create database-network
docker network create redis-network
