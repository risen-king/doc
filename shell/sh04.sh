#!/bin/bash
# Program:
#	User inputs 2 integer numbers;Program will cross these two numbers。
# History:
# 2005/08/23 ahcj Frist release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo -e "You should input 2 numbers,I will cross them! \n"
read -p "frist number: " firstnu
read -p "second number: " secnu
total=$(($firstnu*$secnu))
echo -e "\nThe result of $firstnu x $secnu is ==> $total"
