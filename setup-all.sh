#!/bin/bash

cd docker
. ./docker-setup.sh
cd ..

cd nginx
. ./nginx-setup.sh
cd ..

# TODO self hosted runner?

echo Done!