#!/bin/bash -x

# manually steps:
# 1. edit /etc/hostname file make host like hadoop0  hadoop1 hadoop2
# 2. copy datanodes public keys to namenode (datanodes have access to namenode)
# 3. copy namenode authorized key to all slave nodes (namenode has access to all datanodes
# and datanodes have access to itself.)

sudo apt-get update

function install {
    package_name=$1
    sudo apt-get install $package_name
}

# install and config git
install git
scp ~/hadoopSetup/ubuntu/.gitconfig ~/.

# install openssh-server
install openssh-server

# install and config vim
install vim
scp ~/hadoopSetup/ubuntu/.vimrc ~/.

# install htop
install htop

# setup bash
scp ~/hadoopSetup/ubuntu/.bashrc ~/.
source ~/.bashrc

# create key file if not exist
if [ -f ~/.ssh/id_rsa ];
then
    echo "key file exists"
else
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
fi

# install java jdk
install openjdk-7-jdk
cd /usr/lib/jvm
sudo ln -s java-7-openjdk-amd64 jdk

# add hadoop user
sudo addgroup hadoop
sudo adduser --ingroup hadoop hduser
sudo adduser hduser sudo
# sudo adduser hduser admin

# user doesn't need to enter password after the sudo command, this commands may need to do it manually
sudo echo "hduser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# copy key pair to hduser, so we can ssh to hduser without password
sudo  cp -r ~/.ssh /home/hduser
sudo chown -R  hduser:hadoop /home/hduser/.ssh
