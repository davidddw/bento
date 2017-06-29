#!/usr/bin/env bash
set -x

: ${URL_PATH:="http://192.168.1.200:8090"}
export URL_PATH

ARGS=1
E_BADARGS=65
BUILD_VERSION=v$(date +'%Y%m%d%H%M%S')

if [ $# -ne $ARGS ]  # Correct number of arguments passed to script?
then
    echo "Usage: `basename $0` <template_json>"
    exit $E_BADARGS
fi

PWD=`pwd`
PACKER=/usr/bin/packer
TEMPLATE=$1
VM_NAME=`cat $TEMPLATE | grep '"short_name"' | awk -F "\"" '{print $4}'`
FINAL_NAME=`cat $TEMPLATE | grep '"build_name"' | awk -F "\"" '{print $4}'`
/bin/rm -fr $PWD/packer-build-kvm
mkdir -p $PWD/final_images

$PACKER build $TEMPLATE
/bin/mv $PWD/packer-build-kvm/${VM_NAME} $PWD/final_images/${FINAL_NAME}-${BUILD_VERSION}.qcow2
echo "==> Generate files:"
find ${PWD}/final_images -type f -printf "==> %f\n"

echo "Done"