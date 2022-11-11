#!/bin/bash
sudo docker swarm init --advertise-addr=10.10.10.100
sudo docker swarm join-token worker | grep docker > /vagrant/worker.sh

#Adidionando no script worker após o comando do JOIN os comandos de instalação e mount do compartilhamento do master
echo 'sudo apt update && sudo apt-get install -y nfs-common' >> /vagrant/worker.sh
echo 'docker volume create data' >> /vagrant/worker.sh
echo 'sudo mount 10.10.10.100:/var/lib/docker/volumes/data/_data /var/lib/docker/volumes/data/_data' >> /vagrant/worker.sh

#Criando volume de arquivo
docker volume create data

#Instalando sistema de compartilhamento
sudo apt-get update && sudo apt-get install -y nfs-server
sudo echo "/var/lib/docker/volumes/data/_data *(rw,sync,subtree_check)" >> /etc/exports
sudo exportfs -ar
sudo echo "Minha APLICAÇÃO" > /var/lib/docker/volumes/data/_data/index.html
