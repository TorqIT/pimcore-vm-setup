#!/bin/bash
echo Setting up nginx reverse proxy... 
docker network create nginx_proxy
docker compose up -d