#!/bin/bash

WORKDIR=$PWD
TAILBENCHDIR=${WORKDIR}/tailbench


cd ~
cd ${TAILBENCHDIR}
echo "JDK_PATH=/usr/lib/jvm/java-8-openjdk-amd64" > ./Makefile.config


echo -e "\033[92mBuilding harness\033[0m"
cd ./harness
./build.sh
cd ..

echo -e "\033[92mBuilding img-dnn\033[0m"
cd ./img-dnn
./build.sh
cd ..

echo -e "\033[92mBuilding masstree\033[0m"
cd ./masstree
./build.sh
cd ..

echo -e "\033[92mBuilding moses\033[0m"
cd ./moses
./build.sh
cd ..

echo -e "\033[92mBuilding shore\033[0m"
cd ./shore
./build.sh
cd ..

echo -e "\033[92mBuilding silo\033[0m"
cd ./silo

cd ./masstree
sudo ./configure

cd ..
bash ./build.sh
cd ..


echo -e "\033[92mConfiguring Xapian\033[0m"
cd ~
cp -r ${TAILBENCHDIR}/xapian ./xapian
cd ./xapian

cd xapian-core-1.2.13
sudo ./configure
sed -i 's/CXX = g++/CXX = g++ -std=c++03/g' Makefile
sudo make -j$(nproc) && sudo make install
cd ..	

echo -e "\033[92mBuilding xapian\033[0m"

cd ${TAILBENCHDIR}/xapian
sudo ldconfig
bash ./build.sh
cd ..

cd ~
echo "\033[0;32mConfiguring Sphinx\033[0m\n"
cp -r ${TAILBENCHDIR}/sphinx ./sphinx
cd sphinx/

cd ./sphinxbase-5prealpha/
sudo ./autogen.sh && sudo ./configure && sudo make -j$(nproc) && sudo make install

cd ..
cd ./pocketsphinx-5prealpha/
sudo apt-get install automake
sudo ln -sf /usr/bin/aclocal /usr/bin/aclocal-1.13
sudo ./configure && sudo make -j$(nproc) && sudo make install

echo -e "\033[92mBuilding sphinx\033[0m"
cd ${TAILBENCHDIR}/sphinx
bash ./build.sh
cd ..
