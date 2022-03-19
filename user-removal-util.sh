#!/bin/bash
#User removal utility

#check if user runs as sudo
if [ `id -u` -ne 0 ]; then
      echo "This script can be executed only as root, Exiting.."
      exit 1
   fi

apt install zip -y > /dev/null 2>&1

echo "Enter the name of the system account you want to delete: "
read AccountName

user_exists=$(getent passwd $AccountName)

if [ -z "$user_exists" ] 
then
	echo "Error! User not found."
else
	echo "Found user $AccountName"
	mkdir /root/archive > /dev/null 2>&1
    zip /home/"$AccountName".zip /home/"$AccountName"
	mv /home/"$AccountName".zip /root/archive
	userdel -rf "$AccountName" 
fi

