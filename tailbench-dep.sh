#!/bin/bash

WORKDIR=$PWD
TAILBENCHDIR=${WORKDIR}/tailbench

cd ~
echo -e "\033[92mPerfoming apt updates\033[0m"

sudo apt-get update
sudo apt update

echo -e "\033[92mInstalling Software Properties and adding repositories\033[0m"

sudo apt-get -y install software-properties-common
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt-get update

echo -e "\033[92mInstalling Tailbench Dependencies\033[0m"
sudo apt -y install openjdk-8-jdk
sudo apt-get -y --assume-yes install gcc automake autoconf libtool bison swig build-essential vim python3.7 pkg-config python3-pip zlib1g-dev uuid-dev libboost-all-dev cmake libgtk2.0-dev pkg-config libqt4-dev unzip wget libjasper-dev libpng-dev libjpeg-dev libtiff5-dev libgdk-pixbuf2.0-dev libopenexr-dev libbz2-dev tk-dev tcl-dev g++ git subversion automake libtool zlib1g-dev libicu-dev libboost-all-dev liblzma-dev python-dev graphviz imagemagick make cmake libgoogle-perftools-dev autoconf doxygen libgtop2-dev libncurses-dev ant libnuma-dev libmysqld-dev libaio-dev libjemalloc-dev libdb5.3++-dev libreadline-dev

cd ~
wget https://github.com/opencv/opencv/archive/2.4.13.5.zip -O opencv-2.4.13.5.zip
unzip opencv-2.4.13.5.zip

cd ./opencv-2.4.13.5/
mkdir release
cd release/
cmake -G "Unix Makefiles" -DCMAKE_CXX_COMPILER=/usr/bin/g++ CMAKE_C_COMPILER=/usr/bin/gcc -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DWITH_TBB=ON -DBUILD_NEW_PYTHON_SUPPORT=ON -DWITH_V4L=ON -DINSTALL_C_EXAMPLES=ON -DINSTALL_PYTHON_EXAMPLES=ON -DBUILD_EXAMPLES=ON -DWITH_QT=ON -DWITH_OPENGL=ON -DBUILD_FAT_JAVA_LIB=ON -DINSTALL_TO_MANGLED_PATHS=ON -DINSTALL_CREATE_DISTRIB=ON -DINSTALL_TESTS=ON -DENABLE_FAST_MATH=ON -DWITH_IMAGEIO=ON -DBUILD_SHARED_LIBS=OFF -DWITH_GSTREAMER=ON ..
sudo make all -j
sudo make install

cd ~
pip3 install developer-tools numpy matplotlib pandas scipy