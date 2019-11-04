#!/usr/bin/bash

echo "installing apindex"
apt-get update
apt-get install cmake python3 -y
git clone --depth=1 https://github.com/jayanta525/apindex.git
cd apindex
cmake . -DCMAKE_INSTALL_PREFIX=/usr
make install
cd ..
rm -rf apindex/
