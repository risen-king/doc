#!/bin/bash
# Program:
#	Use function to repeat information
# History:
# 2005/08/23 ahcj Frist release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


function printit(){
	echo -n "Your choice is "	#加上 -n 可以不断行继续在同一行显示
}

echo "This program will print your selection !"
# read -p "Input your choice: " choice
# case $choice in

case $1 in
	"one")
		printit; echo $1 | tr 'a-z' 'A-Z' # 将参数大小写转换
		;;
	"two")
		printit; echo $1 | tr 'a-z' 'A-Z' # 将参数大小写转换
		;;
	"three")
		
		printit; echo $1 | tr 'a-z' 'A-Z' # 将参数大小写转换
		;;
	*)
		echo "Usage $0 {one|two|three}"
		;;
esac
