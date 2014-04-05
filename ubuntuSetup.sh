#!/bin/bash -x

# This script will set up general ubuntu enviroment.

sudo apt-get update

function install {
    package_name=$1
    sudo apt-get install $package_name
}

# install openssh-server
install openssh-server

# install and config vim
install vim
scp ./ubuntu/.vimrc ~/.

# install and config git
install git
scp ./ubuntu/.gitconfig ~/.

# install htop
install htop

# setup bash
scp ./ubuntu/.bashrc ~/.
source ~/.bashrc

# create key file if not exist
if [ -f ~/.ssh/id_rsa ];
then
    echo "key file exists"
else
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
fi
