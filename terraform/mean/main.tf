terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

#Deploy MongoDB instance
resource "aws_instance" "mongodb" {
  ami                    = var.mongo_ami
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = var.mongo_sg
  subnet_id              = var.mongo_subnet
  private_ip             = var.mongo_priv_ip
  tags = {
    Name = "MongoDB_Server"
  }

  provisioner "file" {
    source      = "./scripts/install_mongodb.sh"
    destination = "/tmp/install_mongodb.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/hvega.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = ["chmod +x /tmp/install_mongodb.sh", "/tmp/install_mongodb.sh"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/hvega.pem")
      host        = self.public_ip
    }
  }
}

# Deploy Ubuntu AMI
resource "aws_instance" "app_server" {
  ami                         = var.app_ami
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  private_ip                  = var.app_priv_ip
  subnet_id                   = var.app_subnet
  vpc_security_group_ids      = var.app_sg
  associate_public_ip_address = true
  tags = {
    Name = "Web_Server"
  }

  # Provision content for index.js
  provisioner "file" {
    content     = <<-EOT
    const http = require('http');
    const { MongoClient } = require('mongodb');

    const hostname = '0.0.0.0';
    const port = 8080;

    const connectionString = 'mongodb://${aws_instance.mongodb.private_ip}:27017';

    const server = http.createServer((req, res) => {
    MongoClient.connect(connectionString, { useNewUrlParser: true, useUnifiedTopology: true })
        .then(() => {
        res.statusCode = 200;
        res.setHeader('Content-Type', 'text/plain');
        res.end('Hi! Im Hugo Vega and the connection string is valid!\n');
        })
        .catch(error => {
        res.statusCode = 500;
        res.setHeader('Content-Type', 'text/plain');
        res.end('Connection string is invalid: ' + error.message + '\n');
        });
    });

    server.listen(port, hostname, () => {
    console.log("Server running at http://" + hostname + ":" + port);
    });
    EOT
    destination = "/tmp/index.js"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/hvega.pem")
      host        = self.public_ip
    }
  }
  # Provision for nodejs installation
  provisioner "file" {
    source      = "./scripts/nodejs.sh"
    destination = "/tmp/nodejs.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/hvega.pem")
      host        = self.public_ip
    }
  }
  # Provision for package.json file  
  provisioner "file" {
    source      = "./templates/package.json"
    destination = "/tmp/package.json"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/hvega.pem")
      host        = self.public_ip
    }
  }
  # Provision for sites-available nginx directory
  provisioner "file" {
    source      = "./templates/default"
    destination = "/tmp/default"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/hvega.pem")
      host        = self.public_ip
    }
  }
  # Provision for daemon service
  provisioner "file" {
    source      = "./templates/unirapp.service"
    destination = "/tmp/unirapp.service"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/hvega.pem")
      host        = self.public_ip
    }
  }

  # Provision for finals requirements
  provisioner "file" {
    source      = "./scripts/finish_installation.sh"
    destination = "/tmp/finish_installation.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/hvega.pem")
      host        = self.public_ip
    }
  }

  # Provision for exec nodej.sh
  provisioner "remote-exec" {
    inline = ["chmod +x /tmp/nodejs.sh", "/tmp/nodejs.sh"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/hvega.pem")
      host        = self.public_ip
    }
  }

  # Provision for finish_installation.sh
  provisioner "remote-exec" {
    inline = ["chmod +x /tmp/finish_installation.sh", "/tmp/finish_installation.sh"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/hvega.pem")
      host        = self.public_ip
    }
  }
}