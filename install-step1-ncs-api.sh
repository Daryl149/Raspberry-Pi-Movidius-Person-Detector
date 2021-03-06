#!/usr/bin/env bash
export SCRIPT_DIR=`pwd`
echo "Starting installation (NCS API)"

echo ">> Installing apt-get dependencies"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y libusb-1.0-0-dev libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev

echo ">> Enlarging swapfile"
sudo cp $SCRIPT_DIR/dphys-swapfile-enlarged /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile restart

echo ">> Workspace creation"
mkdir -p ~/workspace
cd ~/workspace
wget https://ncs-forum-uploads.s3.amazonaws.com/ncsdk/ncsdk-01_12_00_01-full/ncsdk-1.12.00.01.tar.gz
tar xvf ncsdk-1.12.00.01.tar.gz
ln -s ncsdk-1.12.00.01 ncsdk

cd ~/workspace/ncsdk/api/src
make && sudo make install

cd ~/workspace
git clone https://github.com/movidius/ncappzoo

cd ncappzoo/apps/hello_ncs_py
python3 hello_ncs.py

echo "Done installing (NCS API)"
