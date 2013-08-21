#! /bin/bash


#-------
echo "entering GUI tale"

CURRENT_PATH=$1;
HOME_DIR=$2;
CUR_USER=$3;


network_checking(){

	while [ 1 ]; do

		echo "checking network";
		PING_RESULT=`ping -c 3 ya.ru`;
		echo "$PING_RESULT" | grep "0% packet loss" > /dev/null; 
		[ $? -eq 0 ] && {  break; }
		echo "please configure your network";
		sleep 1;

	done;

	echo "netowrk configure was succsessful";
	echo;

}

#--------for dropbox



rm -rf /usr/share/themes/*
rm -rf /usr/share/icons/*

ln -s $CURRENT_PATH/config/themes/usr/share/themes/ /usr/share/themes

ln -s $CURRENT_PATH/config/icons/usr/share/icons/ /usr/share/icons

echo "dropbox install..."

network_checking;
apt-get -y install python-gtk2
dpkg -i -R -G -E --force-depends $CURRENT_PATH/thirdParty/other/*
echo 



echo "themes themes..."

network_checking;
apt-get -y install lxappearance



echo



#----------------------------



#installing graphical desktop environment

	network_checking;
	apt-get -y install xorg awesome awesome-extra feh xcompmgr # transset

	network_checking;
	apt-get -y install gtk2-engines-murrine gtk-theme-switch 
#installing terminal



rm -rf $HOME_DIR/.config/awesome
rm -rf /usr/share/awesome/themes/stoffd 

ln -s $CURRENT_PATH/config/awesome/awesome $HOME_DIR/.config/awesome
ln -s $CURRENT_PATH/config/awesome/awesome/themes/stoffd /usr/share/awesome/themes/stoffd

exit;

#----loginManager--------
	network_checking;
	sudo apt-get install slim

	rm -f /usr/slim.conf
	rm -rf /etc/slim.conf
	ln -s $CURRENT_PATH/config/slim/slim.conf  /etc/slim.conf

	rm -rf /usr/share/slim/
	mkdir /usr/share/slim/
	ln -s $CURRENT_PATH/config/slim/themes/ /usr/share/slim/themes


network_checking;
apt-get -y install lxterminal pcmanfm synaptic iceweasel xarchiver
network_checking;
apt-get -y install gitg gpicview evince galculator pidgin

mkdir $HOME_DIR/screenshots/



#--------other install

#----virtualBox from third-party install
#sudo apt-get install linux-headers-3.2.0-4-686-pae
#wget -P /tmp/ http://dlc.sun.com.edgesuite.net/virtualbox/4.2.12/virtualbox-4.2_4.2.12-84980~Debian~wheezy_i386.de
#virtualbox-4.2_4.2.12-84980~Debian~wheezy_i386.deb
#sudo /etc/init.d/vboxdrv setup
