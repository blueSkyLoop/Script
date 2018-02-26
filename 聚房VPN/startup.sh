#! /bin/sh
DIR=`dirname $0`
echo $DIR;
cd $DIR
sudo openvpn --config ./client.ovpn --dev tap
