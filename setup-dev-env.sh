#!/bin/bash

user=$(id -u)
version=1.8

if [ $user -ne 0 ]; then 
echo "must be root to run this" 
exit 1
fi

apt-get update
apt-get install -y git
apt-get install curl

wget https://storage.googleapis.com/golang/go1.8.1.linux-386.tar.gz
echo 'export PATH="$PATH:/usr/local/go/bin"' >> ~/.profile
tar -C /usr/local -xzf go1.8.1.linux-386.tar.gz
rm go1.8.1.linux-386.tar.gz
mkdir -p $HOME/go/src 
chmod -R 777 $HOME/go/src

cd ~/Downloads
wget https://raw.githubusercontent.com/xlucas/go-vim-install/master/install.sh
chmod +x install.sh
./install.sh -vim
./install.sh -work $HOME/go/src

exit 0
