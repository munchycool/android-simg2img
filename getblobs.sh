#!/bin/bash

set -e

URL=$1
DIR=$(pwd)
ZIP=$(basename ${URL})
IMAGE=$(echo ${ZIP} | awk -F-factory '{print $1}')
FOLDER=${DIR}/${IMAGE}
FOLDER_EXTRACTED=${FOLDER}/${IMAGE}_extracted
export FOLDER_BLOBS=${FOLDER}_blobs
mkdir -p ${FOLDER_BLOBS}
wget ${URL}
unzip ${ZIP}
cd ${FOLDER}
mkdir -p ${FOLDER_EXTRACTED}
unzip image-${IMAGE}.zip -d ${FOLDER_EXTRACTED}
cd ${FOLDER_EXTRACTED}
simg2img system.img system.raw
simg2img vendor.img vendor.raw
mkdir -p system_work
mkdir -p vendor_work
su -c 'mount -o loop system.raw system_work;
mount -o loop vendor.raw vendor_work;
cp -R system_work/* ${FOLDER_BLOBS};
cp --remove-destination -R vendor_work/* ${FOLDER_BLOBS}/vendor;
umount system_work;
umount vendor_work;
chown -R ${USER}:${USER} ${FOLDER_BLOBS}'
rm -f ${ZIP}
rm -rf ${FOLDER}

