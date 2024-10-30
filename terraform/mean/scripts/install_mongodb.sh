curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt update -y
sudo systemctl stop ufw
sudo apt install mongodb-org -y
sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 10.0.0.16/g' /etc/mongod.conf
sudo systemctl start mongod