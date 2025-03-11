#!/bin/bash

set -eu

WORKSPACE=$1
CHECK_DIR=$2

TARGET=`date +\%Y\%m\%d`
if [ "${CHECK_DIR}" == "bin" ]; then
    echo "Checking /usr/bin"
    /usr/bin/clamscan --stdout --remove --detect-pua -i -l ${WORKSPACE}/${TARGET}_scan-usr-bin.log -r /usr/bin
    echo -e "\n\n"
    echo "Checking /usr/local/bin"
    /usr/bin/clamscan --stdout --remove --detect-pua -i -l ${WORKSPACE}/${TARGET}_scan-usr-local-bin.log -r /usr/local/bin
elif [ "${CHECK_DIR}" == "opt" ]; then
    echo "Checking /opt"
    /usr/bin/clamscan --stdout --remove --detect-pua -i -l ${WORKSPACE}/${TARGET}_scan-opt.log -r /opt
elif [ "${CHECK_DIR}" == "lib" ]; then
    echo "Checking /usr/lib"
    /usr/bin/clamscan --stdout --remove --detect-pua -i -l ${WORKSPACE}/${TARGET}_scan-usr-lib.log -r /usr/lib
    echo -e "\n\n"
    echo "Checking /var/lib"
    /usr/bin/clamscan --stdout --remove --detect-pua -i -l ${WORKSPACE}/${TARGET}_scan-var-lib.log -r /var/lib
elif [ "${CHECK_DIR}" == "log" ]; then
    echo "Checking /var/log"
    /usr/bin/clamscan --stdout --remove --detect-pua -i -l ${WORKSPACE}/${TARGET}_scan-var-log.log -r /var/log
fi
