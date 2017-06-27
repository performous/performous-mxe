#!/bin/sh
echo "Welcome to creating a windows release for performous";
echo "installing git in case it hasn't been done yet";
sudo apt-get install git-core
git clone -b master https://github.com/mxe/mxe.git
cp settings.mk ./mxe/settings.mk
mkdir -p ./mxe/plugins/performous
cp performous.mk performous-1-fixes.patch ./mxe/plugins/performous
cd mxe
make performous
cd ..
cp mxe/usr/i686-w64-mingw32.shared/Performous* ./
echo "release has been build please view folder ./mxe/usr/i686-w64-mingw32.shared"
echo "mxe has been build please run the make-performous script"
