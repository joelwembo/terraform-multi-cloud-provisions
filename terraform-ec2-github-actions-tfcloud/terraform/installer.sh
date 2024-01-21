#!/bin/bash

# Docker installation
# sudo apt install apt-transport-https ca-certificates curl software-properties-common --assume-yes
# sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable'
# apt-cache policy docker-ce
# sudo apt install docker-ce --assume-yes
# sudo chmod 777 /var/run/docker.sock
# # sudo systemctl status docker
# echo 'Docker successfully installer'

# # nginx installation for testing purpose
# docker run --name mynginx1 -p 80:80 -d nginx

echo "nginx server running in your domain.com at port 80"
