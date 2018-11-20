#!/bin/bash
# help
if [ "$1" = "" ]  || [ "$1" = "--help" ]
then
	echo $0 [filename] [size in MB]
	exit
fi

#checks if debootstrap is installed or not
debootstrap > /dev/null
if [ $? = 127 ] # not installed
then
	echo The package debootstrap is not installed. Please install it.
	exit
fi

#magic
dd if=/dev/zero of="$1" bs=1M count=$2
mkfs.ext3 "$1"
echo Done!!!
