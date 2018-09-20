#!/bin/bash

apt-get update 
apt-get install apache2 -y 
echo " Curso DevSecOps na 4linux" > /var/www/html/index.html
