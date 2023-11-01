#!/bin/bash
echo Adding user github...
sudo useradd -m -d /home/github github
sudo usermod -aG docker github
echo Successfully added user github
