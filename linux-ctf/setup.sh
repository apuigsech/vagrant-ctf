#!/usr/bin/env bash

BASE_PATH=$(pwd)

sudo apt-get update
#sudo apt-get upgrade -y

source conf/setup.conf
source lib/utils.sh

for tool in `cat conf/tools.conf`; do
	echo "INSTALL... ${tool}"
	
	conf=${BASE_PATH}/tools/${tool}/conf
	install=${BASE_PATH}/tools/${tool}/install

	if [ -f $conf ]; then
		set -x ; source $conf > /dev/null ; set +x
	fi

	if [ -f $install ]; then
		set -x ; source $install >/dev/null ; set +x
	fi
done
