#! /bin/sh
disk=$1;
echo "Монтирую диск $1"
if [ $1 = "1" ]; then
	sudo mount -o loop -t iso9660 /home/stoffd/images/debian/debian-7.1.0-i386-DVD-1.iso /media/cdrom
elif [ $1 = "2" ]; then
	sudo mount -o loop -t iso9660 /home/stoffd/images/debian/debian-7.1.0-i386-DVD-2.iso /media/cdrom
elif [ $1 = "3" ]; then
	sudo mount -o loop -t iso9660 /home/stoffd/images/debian/debian-7.1.0-i386-DVD-3.iso /media/cdrom
else
	"Неправильно введен номер диска...Введите 1,2 или 3"
fi
