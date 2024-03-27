#!/bin/bash
sudo apt update -y &&
sudo apt install -y nginx
echo "Hello World" > /var/www/html/index.html
sudo usermod -a -G www-data ubuntu
sudo chown -R ubuntu:ubuntu /var/www/html/