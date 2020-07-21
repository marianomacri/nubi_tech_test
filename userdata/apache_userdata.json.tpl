#!/bin/bash
sudo yum update -y
sudo yum upgrade -y
sudo yum install httpd -y
sudo service httpd start