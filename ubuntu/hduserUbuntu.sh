#!/bin/bash -x

# This script will set up general ubuntu enviroment for hduser.

sudo apt-get update

function install {
    package_name=$1
    sudo apt-get install $package_name
}

# install openssh-server
install openssh-server

# install and config vim
install vim
scp ~/hadoopSetup/ubuntu/.vimrc ~/.

# install and config git
install git
scp ~/hadoopSetup/ubuntu/.gitconfig ~/.

# install htop
install htop

# setup bash
scp ~/hadoopSetup/ubuntu/.bashrc ~/.
source ~/.bashrc
