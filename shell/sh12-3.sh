#!/bin/bash
# Program:
#	Use function to repeat information
# History:
# 2005/08/23 ahcj Frist release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


function printit(){
	echo  "Your choice is $1"	#加上 -n 可以不断行继续在同一行显示
}

echo "This program will print your selection !"
# read -p "Input your choice: " choice
# case $choice in

case $1 in
	"one")
		printit 1 #请注意，printit 命令后面还有参数
		;;
	"two")
		printit 2
		;;
	"three")
		printit 3
		;;
	*)
		echo "Usage $0 {one|two|three}"
		;;
esac
