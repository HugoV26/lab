#! /bin/bash
#Install Node.js
sudo apt-get update && sudo apt-get upgrade
cd ~
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt-get install -y nodejs
node -v
npm -v
sudo mkdir -p /var/www/unirapp