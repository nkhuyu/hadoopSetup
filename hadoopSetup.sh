#!/bin/bash -x

# edit /etc/hostname file
# mkhost like hadoop0  hadoop1 hadoop2

sudo apt-get update

function install {
    package_name=$1
    sudo apt-get install $package_name
}

# install java jdk
install openjdk-7-jdk
cd /usr/lib/jvm
sudo ln -s java-7-openjdk-amd64 jdk

# install openssh-server
install openssh-server

# add hadoop user
sudo addgroup hadoop
sudo adduser --ingroup hadoop hduser
sudo adduser hduser sudo
#sudo adduser hduser admin

# user doesn't need to enter password after the sudo command
sudo echo "hduser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
