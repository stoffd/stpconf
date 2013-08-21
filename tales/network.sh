#! /bin/bash

echo "entering driver tale"

CURRENT_PATH=$1;
HOME_DIR=$2;
CUR_USER=$3;
NETINTF=$4

echo "3G links..."

rm -rf /etc/ppp/chatscripts
rm -rf /etc/ppp/options-mobile
rm -rf /etc/ppp/peers

ln -s $CURRENT_PATH/config/ppp/chatscripts/  	/etc/ppp/chatscripts
ln -s $CURRENT_PATH/config/ppp/options-mobile  	/etc/ppp/options-mobile
ln -s $CURRENT_PATH/config/ppp/peers/  			/etc/ppp/peers



if [ -n "$NETINTF" ]; then 
	echo "network pattern inserting";
	echo "NETINTF='$NETINTF'"
	cp -r $CURRENT_PATH/config/network/len22/*  /
fi

echo;
