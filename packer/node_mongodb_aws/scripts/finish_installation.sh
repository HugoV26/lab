#! /bin/bash
sudo mv /home/ubuntu/*.json /var/www/unirapp
sudo mv /home/ubuntu/*.js /var/www/unirapp
sudo mv /home/ubuntu/*.service /etc/systemd/system/
sudo mv /home/ubuntu/default /etc/nginx/sites-available/
sudo systemctl enable unirapp
sudo systemctl start unirapp
sudo systemctl enable nginx
sudo systemctl restart nginx
sudo systemctl stop ufw