#!/bin/bash -l
echo "Creating directories ..."
mkdir -vp ~/opt/
mkdir -vp ~/code/go/{src,pkg,bin}

cd ~/opt
gotarball=go1.4.2.linux-amd64.tar.gz
if [[ ! -f $gotarball ]]; then
	echo "Downloading and unpacking golang tarball ..."
	wget https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz
	tar -zxvf $gotarball
else
	echo "Golang tarball already exists, so not downloading"
fi;

echo "Setting things in ~/.bashrc and ~/.bashrc_local ..."
GOROOT=~/opt/go
GOPATH=~/code/go

echo '' >> ~/.bashrc_local
echo '# Golang stuff' >> ~/.bashrc_local
echo 'export GOROOT='$GOROOT >> ~/.bashrc_local
echo 'export GOPATH='$GOPATH >> ~/.bashrc_local
echo 'export PATH='$GOROOT'/bin:$PATH' >> ~/.bashrc_local
echo 'export PATH='$GOPATH'/bin:$PATH' >> ~/.bashrc_local

echo '. .bashrc_local' >> ~/.bashrc

source ~/.bashrc

echo "Installing auto-compleation daemon ..."
go get github.com/nsf/gocode
go install github.com/nsf/gocode

echo "Setting some vim settings ..."
echo 'set shell=/bin/sh " Needed to get at least Go autocompletion to work' >> ~/.vimrc

echo "------------------------------------------------------------------------"
echo "Installation complete (hopefully)!"
echo "Now, open vim, and get Go auto-completion using <C-x><C-o>!"
