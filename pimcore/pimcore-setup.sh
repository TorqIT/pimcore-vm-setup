#!/bin/bash

echo Adding user pimcore...
useradd -u 1500 pimcore

echo Creating external Docker networks for blue/green deployments...
docker network create database-network
docker network create redis-network
