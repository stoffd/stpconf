#! /bin/bash



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




[ $# -ne 1 ] && { echo "please enter config_file as a parameter"; exit; } 


echo "STARTING...";
echo "-------------------------";
echo;

CONFIG_F=`cat $1`

eval $CONFIG_F

#$1 - username
CURRENT_PATH=/home/$CUR_USER/code/gitWorkdir/stpconf;
HOME_DIR=/home/$CUR_USER
echo "current path: "$CURRENT_PATH;
echo "current user: "$CUR_USER;
echo "home dir: "$HOME_DIR;
echo;


echo "needfull packages";
#----------unpacking-----------
#-----this is a packages for wifi and 3G

dpkg -i -R -G -E --force-depends $CURRENT_PATH/thirdParty/must_have/*

echo;

echo "driver adding:"
#----------drivers-----------

$CURRENT_PATH/tales/drv.sh $CURRENT_PATH $HOME_DIR $CUR_USER

echo "network configure";
#----------unpacking-----------

$CURRENT_PATH/tales/network.sh $CURRENT_PATH $HOME_DIR $CUR_USER $NETINTF


#-------------------------------------------
echo;








echo "configuring repositories sources list:"
#----------base-repository-config-----------
	rm -f /etc/apt/sources.list
	ln -s $CURRENT_PATH/config/apt/sources.list.$SOURCES_LIST  /etc/apt/sources.list
	network_checking;
	apt-get update

#--------------------------------------------
echo;

echo "UPGRADING LOCAL PACKAGES...";
sudo apt-get upgrade



echo "removing some shit:"
#------REMOVING--------
	apt-get -y autoremove nano vim.tiny top;
#----------------------

echo "core soft installing:"
#-----CORE SOFT INSTALING--------

#  needfull things
network_checking;
apt-get -y install htop mc vim lynx git htop

network_checking;
apt-get -y install zip unrar-free p7zip-full

#------------------------
echo;

echo "fonts adding...";
#--------------fonts adding---------------
cp -r $CURRENT_PATH/config/fonts/ /usr/share

#------------------------
echo;


echo "vim configure...";


# vi_mode for bash
echo "set -o vi" > $CURRENT_PATH/.bashrc
rm -rf $HOME_DIR/.vim
rm -rf $HOME_DIR/.vimrc


ln -s $CURRENT_PATH/config/vim/vim/ $HOME_DIR/.vim
ln -s $CURRENT_PATH/config/vim/vimrc $HOME_DIR/.vimrc

#------------------------------------------
echo;


if [ -n "$GUI" ]; then 
	echo "GUI='$GUI'"
	if [ "$GUI" = "YES" ]; then
		$CURRENT_PATH/tales/gui.sh $CURRENT_PATH $HOME_DIR $CUR_USER
	fi
fi
echo;


echo "PROGRAMMING...";
#---------COMPILERS--------------------
	network_checking;
	apt-get -y install gcc g++ openjdk-6-jdk vim-gtk ctags 

ln -s $CURRENT_PATH/thirdParty/stocc.sh  /usr/local/bin/stocc

#---lisp---
	network_checking;
	apt-get -y install  gcl
	network_checking;
	apt-get -y install  tcl


#-----------------------------------------
echo;



echo "SOUND...";
#---------COMPILERS--------------------
if [ -n "$SOUND" ]; then 
	echo "SOUND='$SOUND'"
	if [ "$SOUND" = "YES" ]; then
		$CURRENT_PATH/tales/sound.sh
	fi
fi
#-----------------------------------------
echo;


echo "Install complite";

