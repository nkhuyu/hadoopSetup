#!/bin/bash -x

# edit /etc/hostname file
# mkhost like hadoop0  hadoop1 hadoop2


cd ~
sudo apt-get update

function install {
    package_name=$1
    sudo apt-get install $package_name
}

# install java
install openjdk-7-jdk

