#!/bin/bash

user=$(id -u)
version=1.8

if [ $user -ne 0 ]; then 
echo "must be root to run this" 
exit 1
fi

apt-get update
apt-get install -y git

curl https://storage.googleapis.com/golang/go1.8.1.linux-386.tar.gz
echo 'export PATH="$PATH:/usr/local/go/bin"' >> /etc/profile
tar -C /usr/local -xzf go1.8.1.linux-386.tar.gz
rm go1.8.1.linux-386.tar.gz

exit 0

