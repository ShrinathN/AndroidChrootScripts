#!/bin/sh
#this script is here to install the chroot

# checks If the user is root or not, halts execution of not
if [ "$(whoami)" != "root" ]
then
echo Please run the script as root
exit
fi

busybox mount -o remount,rw /
if [ ! -e /debian ]
then
	mkdir /debian
fi	
busybox mount debian.img /debian
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export LD_PRELOAD=""
busybox chroot /debian /debootstrap/debootstrap --second-stage
mkdir /debian/mnt/sdcard0
mkdir /debian/mnt/sdcard1
echo -e "domain local\nsearch local\n" >> /debian/etc/resolv.conf
echo -e "# DNS Google\nnameserver 8.8.8.8\nnameserver 8.8.4.4\n" >> /debian/etc/resolv.conf
busybox umount /debian
