#!/bin/sh
#this script will help you enter into the Debian chroot

# checks If the user is root or not, halts execution of not
if [ "$(whoami)" != "root" ]
then
echo Please run the script as root
exit
fi

# mounts the root as RW
busybox mount -o remount,rw /

# checks if /debian exists, if not, it creates it
if [ ! -e /debian ]; then
	mkdir /debian
fi

# mounts the img file in /debian
busybox mount /sdcard/debian.img /debian

# all the shit i need to access the hardware
busybox mount -o bind /dev /debian/dev
busybox mount -t proc proc /debian/proc
busybox mount -t tmpfs tmpfs /debian/tmp
busybox mount -t sysfs sys /debian/sys
busybox mount -o bind /sdcard /debian/mnt/sdcard0
busybox mount -o bind /storage/2138-1704 /debian/mnt/sdcard1

# trivial variable setup
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export LD_PRELOAD=""
export TERM="xterm"
export DISPLAY=:0
export HOME=/home

# the main part

busybox chroot /debian /bin/bash -l

# for unmounting 
busybox umount /debian/dev
busybox umount /debian/proc
busybox umount /debian/tmp
busybox umount /debian/sys
busybox umount /debian/mnt/sdcard0
busybox umount /debian/mnt/sdcard1
busybox umount /debian
