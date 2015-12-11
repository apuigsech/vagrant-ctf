#!/bin/bash

sudo apt-get install -y --no-install-recommends wget tar unzip git subversion python-pip python-dev > /dev/null

function install-packages {
	packages=$@
	sudo apt-get install -y --no-install-recommends $packages > /dev/null
}

function install-pip {
	pip=$@
	sudo pip install $@ > /dev/null
}

function download-git {
	git_url=$1
	git_name=$(basename $1 | cut -d . -f1)
	sudo git clone --depth 1 $1 ${SRC_LOCAL_PATH}/${git_name} > /dev/null
	P=${SRC_LOCAL_PATH}/${git_name}
}

function download-svn {
	git_url=$1
	git_name=$(basename $1 | cut -d . -f1)
	sudo svn co $1 ${SRC_LOCAL_PATH}/${git_name} > /dev/null
	P=${SRC_LOCAL_PATH}/${git_name}
}

function download-url {
	url=$1
	name=$(basename $1)
	ext=$(basename $1 | cut -d . -f2-)
	sudo wget $1 -O ${SRC_LOCAL_PATH}/${name} -o /dev/null > /dev/null
	case $ext in
		"tar")
			sudo tar xf ${SRC_LOCAL_PATH}/${name} -C ${SRC_LOCAL_PATH} > /dev/null
			;;
		"tgz")
			sudo tar xzf ${SRC_LOCAL_PATH}/${name} -C ${SRC_LOCAL_PATH} > /dev/null
			;;
		"tar.gz")
			sudo tar xzf ${SRC_LOCAL_PATH}/${name} -C ${SRC_LOCAL_PATH} > /dev/null
			;;
		"zip")
			sudo unzip ${SRC_LOCAL_PATH}/${name} > /dev/null
			;;
	esac
	P=${SRC_LOCAL_PATH}/${name}
}

