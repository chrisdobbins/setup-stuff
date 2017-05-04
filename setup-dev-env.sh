#!/bin/bash

user=$(id -u)
version=1.8

if [ $user -ne 0 ]; then 
echo "must be root to run this" 
exit 1
fi

sudo add-apt-repository universe && sudo add-apt-repository multiverse
sudo apt-get update

# will allow restricted/proprietary media formats to be played...and a bunch of other stuff
sudo apt-get install ubuntu-restricted-extras

if [ -z "which git" ]; then
  apt-get install -y git
fi

if [ -z "which curl" ]; then
  apt-get install -y curl
fi

if [ -z "echo $GOPATH" ]; then
  wget https://storage.googleapis.com/golang/go1.8.1.linux-386.tar.gz
  echo 'export PATH="$PATH:/usr/local/go/bin"' >> ~/.profile
  tar -C /usr/local -xzf go1.8.1.linux-386.tar.gz
  rm go1.8.1.linux-386.tar.gz
  mkdir -p $HOME/go/src 
  chmod -R 777 $HOME/go/src
fi

cd ~/Downloads
wget https://raw.githubusercontent.com/xlucas/go-vim-install/master/install.sh
chmod +x install.sh
./install.sh -vim
./install.sh -work $HOME/go/src
apt-get install -y vim

exit 0
