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
sudo apt-get install -y ubuntu-restricted-extras

"hash git" 2> /dev/null
 if [ $? -ne 0 ]; then
       echo 'Installing git...'
       apt-get install -y git
fi

"hash curl" 2> /dev/null
if [ $? -ne 0 ]; then
       echo 'Installing curl...'
       apt-get install -y curl
fi

"hash go" 2> /dev/null
if [ $? -ne 0 ]; then
  echo 'Installing Go...'
  wget https://storage.googleapis.com/golang/go1.8.1.linux-386.tar.gz
  echo 'export PATH="$PATH:/usr/local/go/bin"' >> ~/.profile
  tar -C /usr/local -xzf go1.8.1.linux-386.tar.gz
  rm go1.8.1.linux-386.tar.gz
  mkdir -p $HOME/go/src 
  chmod -R 777 $HOME/go/src
fi

echo 'Installing vim...'
cd ~/Downloads
wget https://raw.githubusercontent.com/xlucas/go-vim-install/master/install.sh
chmod +x install.sh
./install.sh -vim
./install.sh -work $HOME/go/src
apt-get install -y vim

exit 0
