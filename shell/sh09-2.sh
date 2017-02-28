#!/bin/bash
# Program:
#	Show "Hello" from $1... by using case ... esac
# History:
# 2005/08/23 ahcj Frist release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


case $1 in
	"hello")
		echo "Hello,how are you ?"
		;;
	"")
		echo "You must input parameters,ex> {$0 someword}"
		;;
	*)
	echo "Usage $0 {hello}"
esac
