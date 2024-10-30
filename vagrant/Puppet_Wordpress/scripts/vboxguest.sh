#! /bin/bash

sudo yum update -y
sudo yum install wget -y
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo yum -y install puppet-agent
sudo systemctl start puppet
