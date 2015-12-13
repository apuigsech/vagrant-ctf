#!/usr/bin/env bash

BASE_PATH=$(pwd)

set -e
set -o pipefail
set -x

sudo apt-get update > /dev/null
#sudo apt-get upgrade -y > /dev/null

source conf/setup.conf
source lib/utils.sh

for tool in `cat conf/tools.conf | egrep -v ^#`; do
	echo -e "\e[1mInstalling... ${tool}\e[0m"
	
	conf=${BASE_PATH}/tools/${tool}/conf
	install=${BASE_PATH}/tools/${tool}/install

	if [ -f $conf ]; then
		source $conf > /dev/null
	fi

	if [ -f $install ]; then
		source $install >/dev/null
	fi
done
