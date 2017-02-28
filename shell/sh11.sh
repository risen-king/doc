#!/bin/bash
# Program:
#	This program shows "Hello World!" in your screen.
# History:
# 2005/08/23 ahcj Frist release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "This program will try to calculate :"
echo "How many days before your demobilization date..."
read -p "Please input your demobilization date(YYYYMMDD ex>20090410): " date2

date_d=$(echo $date2 | grep '[0-9]\{8\}')
if [ "$date_d" == "" ];then
	echo "You input the wrong date format..."
	exit 1
fi


declare -i date_dem=`date --date="$date2" +%s`		#退伍日期秒数
declare -i date_now=`date +%s`				#现在日期秒数
declare -i date_total_s=$(($date_dem - $date_now))	#剩余秒数统计
declare -i date_d=$(($date_total_s/3600/24))		#转为日数

if [ "$date_total_s" -lt "0" ];then
	echo "You had been demobilization before: " $((-1*$date_d)) " ago"
else
	declare -i date_h=$(( $(($date_total_s -$date_d*3600*24))/3600 ))
	echo "You will demobilize after $date_d days and $date_h hours."
fi
