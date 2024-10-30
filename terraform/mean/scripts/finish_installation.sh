#! /bin/bash
sudo mv /tmp/*.json /var/www/unirapp
sudo mv /tmp/*.js /var/www/unirapp
sudo mv /tmp/*.service /etc/systemd/system/
sudo mv /tmp/default /etc/nginx/sites-available/
cd /var/www/unirapp/ && sudo npm install
sudo systemctl daemon-reload
sudo systemctl enable unirapp
sudo systemctl start unirapp
sudo systemctl enable nginx
sudo systemctl restart nginx
sudo systemctl stop ufw