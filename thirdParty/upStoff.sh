#! /bin/bash

[ $# -eq 1 ] || { echo "please enter profile."; exit 0; }

echo "please wait..."
killall pppd;
pppd call $1;
sleep 15;
echo "start!";

while [ 1 ]; do

	PING_RESULT=`ping -c 3 ya.ru`;
	echo "$PING_RESULT" | grep "transmitted" > /dev/null; 
	if [ $? -eq 0 ]; then
		continue;
	else
		date
		echo "NO PING!!!";

		killall pppd;
		sleep 3; 

		echo "trying to reconnect...";
		pppd call $1;
		sleep 15;
		echo "start!";
	fi;

	sleep 5;

done;
