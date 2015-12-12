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
	cd ${SRC_LOCAL_PATH} ; extract ${name} > /dev/null ; cd -
	P=${SRC_LOCAL_PATH}/${name}
}

function make-install {
	opts=$@
	sudo ./configure --prexix=${LOCAL_PATH} ${opts} >/dev/null
	sudo make > /dev/null
	sudo make instal > /dev/null
}

function extract()
{
     if [ -f $1 ] ; then
         case $1 in
            *.tar.bz2)   
                sudo tar xvjf $1
                ;;
            *.tar.gz)    
                sudo tar xvzf $1     
                ;;
            *.bz2)       
                sudo bunzip2 $1      
                ;;
            *.rar)
                sudo unrar x $1      
                ;;
            *.gz)
                sudo gunzip $1       
                ;;
            *.tar)
                sudo tar xvf $1      
                ;;
            *.tbz2)
                sudo tar xvjf $1     
                ;;
            *.tgz)
                sudo tar xvzf $1     
                ;;
            *.zip)
                sudo unzip $1        
                ;;
            *.Z)
                sudo uncompress $1   
                ;;
            *.7z)
                sudo 7z x $1         
                ;;
            *)  
                echo "'$1' cannot be extracted via extract" 
                ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}