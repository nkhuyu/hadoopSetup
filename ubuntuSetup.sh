#!/bin/bash -x

function install {
    package_name=$1
    sudo apt-get install $package_name
}

# install openssh-server
install openssh-server

# install vim
install vim

# install git
install git

# install htop
install htop

# install java
