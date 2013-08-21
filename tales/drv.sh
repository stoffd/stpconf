#! /bin/bash

#old_conf
# properitary wireless drivers 
	#tar xvf ./drivers/firmware/Broadcom_Firmware.tar.gz -C /lib/firmware/

echo "entering into driver tale"

CURRENT_PATH=$1;
HOME_DIR=$2;
CUR_USER=$3;


dpkg -i -R -G -E --force-depends $CURRENT_PATH/thirdParty/firmware/*
