#! /bin/bash
#Install Node.js
sudo apt-get update -y && sudo apt-get upgrade -y
cd ~
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt-get install -y nodejs
sudo apt-get install nginx -y
sudo mkdir -p /var/www/unirapp