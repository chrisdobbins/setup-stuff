#!/bin/bash

user=$(id -u)

if [ $user -ne 0 ]; then 
echo "must be root to run this" 
exit 1
fi

add-apt-repository universe && add-apt-repository multiverse && add-apt-repository main
apt-get update

# will allow restricted/proprietary media formats to be played...and a bunch of other stuff
# sudo apt-get install -y ubuntu-restricted-extras

hash git 2> /dev/null
 if [ $? -ne 0 ]; then
       echo 'Installing git...'
       apt-get install -y git
fi

hash curl 2> /dev/null
if [ $? -ne 0 ]; then
       echo 'Installing curl...'
       apt-get install -y curl
fi

hash go 2> /dev/null
if [ $? -ne 0 ]; then
  echo 'Installing Go...'
# os arch is 32-bit  
  if [ -z $(uname -m | grep 64) ]; then
    wget https://storage.googleapis.com/golang/go1.8.3.linux-386.tar.gz
    echo 'export PATH="$PATH:/usr/local/go/bin"' >> $HOME/.profile
    tar -C /usr/local -xzf go1.8.3.linux-386.tar.gz
    rm go1.8.3.linux-386.tar.gz
  else
# os arch is 64-bit
    wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
    echo 'export PATH="$PATH:/usr/local/go/bin"' >> $HOME/.profile
    tar -C /usr/local -xzf go1.8.3.linux-amd64.tar.gz
    rm go1.8.3.linux-amd64.tar.gz
  fi
  mkdir -p $HOME/go/src 
  chmod -R 777 $HOME/go/src
fi

hash nvm 2> /dev/null
if [ $? -ne 0 ]; then
  echo 'Installing nvm...'
  export NVM_DIR="$HOME/.nvm" && (
    git clone https://github.com/creationix/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
  ) && . "$NVM_DIR/nvm.sh"
fi

hash vim 2> /dev/null
if [ $? -ne 0 ]; then
  echo 'Installing vim...'
  cd ~/Downloads
  wget https://raw.githubusercontent.com/xlucas/go-vim-install/master/install.sh
  chmod +x install.sh
  ./install.sh -vim
  ./install.sh -work $HOME/go/src
  rm install.sh
  apt-get install -y vim
fi

# just assuming VS Code isn't installed...
if [ -z $(uname -m | grep 64) ]; then
  echo 'Installing Visual Studio Code...'
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
  sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  apt-get update && apt install code
fi

echo 'All done!'

exit 0
