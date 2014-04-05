#!/bin/bash -x

function install {
    package_name=$1
    sudo apt-get install $package_name
}

# install openssh-server
install openssh-server

# install and config vim
install vim
cp ubuntu/.vimrc ~/.
source .vimrc

# install and config git
install git
cp ubuntu/.gitcong ~/.
source .gitconfig

# install htop
install htop

# setup bash
cp ubuntu/.bashrc ~/.
source .bashrc

# install java

