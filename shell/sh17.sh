#!/bin/bash
# Program:
#	Use ping command to check the network's PC state
# History:
# 2005/08/23 ahcj Frist release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

network="192.168.1"
for sitenu in $(seq 1 100)
do 
	ping -c 1 -w 1 ${newwork}.${sitenu} &> /dev/null && result=0 || result=1
	
	if [ "$result" == 0 ];then
		echo "Server ${network}.${sitenu} is UP."
	else
		echo "Server ${network}.${sitenu} is DOWN."
	fi
done
