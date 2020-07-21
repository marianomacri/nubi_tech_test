#!/bin/bash
sudo yum update -y
sudo yum upgrade -y
sudo yum install epel-release -y
sudo amazon-linux-extras install epel
sudo yum update -y
sudo yum install nginx -y
sudo service nginx start