#!/bin/bash
set -e
set -x

PROJECT_ROOT="$(dirname $(dirname $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)))"

echo "PROJECT ROOT: ${PROJECT_ROOT}"
cd "${PROJECT_ROOT}"



sudo rm -f /etc/apt/sources.list.d/nfq.list

sudo apt-get update

# for all
sudo apt-get install -y git-core gcc g++ make autoconf autoconf-archive \
  automake libtool pkg-config libglib2.0-dev libglibmm-2.4-dev libzip-dev \
  libusb-1.0-0-dev libftdi1-dev check python-numpy \
  python-dev python-gi-dev python-setuptools swig default-jdk \
  python3-dev sdcc \
  g++ make cmake libtool pkg-config \
  libglib2.0-dev libboost-test-dev libboost-serialization-dev \
  libboost-filesystem-dev libboost-system-dev libqt5svg5-dev qtbase5-dev \
  libhidapi-dev


if [ ! -d dependencies ]; then
	mkdir -f dependencies
	cd dependencies

	git clone git://sigrok.org/libserialport
	cd libserialport
	./autogen.sh
	./configure
	make
	sudo make install
	cd ..


	git clone git://sigrok.org/libsigrok
	cd libsigrok
	./autogen.sh
	./configure
	make
	sudo make install
	cd ..


	git clone git://sigrok.org/sigrok-cli
	cd sigrok-cli
	./autogen.sh
	./configure
	make
	sudo make install
	cd ..

else
	cd dependencies

	cd libserialport
	sudo make install
	cd ..


	cd libsigrok
	sudo make install
	cd ..


	cd sigrok-cli
	sudo make install
	cd ..

fi

#git clone git://sigrok.org/sigrok-util
#cd sigrok-util/cross-compile/linux
#time ./sigrok-cross-linux
#sudo ldconfig /home/project/sr/lib/



sudo ldconfig /usr/local/lib


cowsay -f sheep "My job is done here."

