#!/bin/bash

echo Creating external Docker networks for blue/green deployments...
docker network create database-network
docker network create redis-network
