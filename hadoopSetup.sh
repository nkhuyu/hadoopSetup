#!/bin/bash -x

cd ~
sudo apt-get update

function install {
    package_name=$1
    sudo apt-get install $package_name
}

# install java
install openjdk-7-jdk

