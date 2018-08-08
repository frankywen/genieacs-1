#!/bin/sh

APP_NAME="gzb-acs"
APP_HOME="/home/ippbx/http/$APP_NAME"

UPDATEPKT="GZB_ACS"
CURRENTDIR=$(pwd)
nowt=$(date +%Y%m%d%H%M%S)
HASCONFIG_FILE=false
TMP_DIR=${CURRENTDIR}/${UPDATEPKT}tmp

[ -f /etc/sysconfig/gzb/functions/functions ] && . /etc/sysconfig/gzb/functions/functions
[ -f /etc/sysconfig/gzb/$APP_NAME ] && . /etc/sysconfig/gzb/$APP_NAME


# common function
function echo_error(){
    echo -e "\033[40m\033[31m $1 \033[0m"
}

function echo_info(){
    echo -e "\033[40m\033[36m $1 \033[0m"
}

function echo_success(){
    echo -e "\033[40m\033[32m $1 \033[0m"
}

function echo_waring(){
    echo -e "\033[40m\033[33m $1 \033[0m"
}

function echo_tips(){
    echo -e "\033[40m\033[34m $1 \033[0m"
}


#update package
function update_package(){
    
    if [ -f ${UPDATEPKT}.tar.gz ]; then
        echo_info " found the update package ${UPDATEPKT}.tar.gz "
        if [ ! -d ${APP_HOME} ]; then
            mkdir -p ${APP_HOME}
            echo_info " create ${APP_HOME} dir "
        fi
        tar -xzmf ${UPDATEPKT}.tar.gz -C ${APP_HOME}
        echo_info " decompressing ${UPDATEPKT}.tar.gz to ${APP_HOME} dir "

        if [ ! -d ${APP_HOME}/log ]; then
            mkdir -p ${APP_HOME}/log
        fi
    else
        echo_error " can not found the update package ${UPDATEPKT}.tar.gz "
        exit 1
    fi
   
    chmod -R 755 ${APP_HOME}
}

function delete_updatefile(){
    rm -r -f ${UPDATEPKT}.tar.gz
    rm -r -f update.sh
    rm -r -f README.md
    echo_info " delete upgrade packages and other temporary files "
}

function do_start_service(){
  echo_info " start service "
  ln -sf $APP_HOME/bin/$APP_NAME /etc/init.d
	chkconfig --add $APP_NAME
  service $APP_NAME restart
}

update_package
delete_updatefile
do_start_service
