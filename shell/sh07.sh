#!/bin/bash
# Program:
#	This program shows the script name,parameters...
# History:
# 2005/08/23 ahcj Frist release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "The script name is	==> $0"
echo "Total parameter number is ==> $#"
[ "$#" -lt 2 ] && echo "The number of parameter is less than 2. Stop here." && exit 0
echo "Your whole parameter 	==>'$@'"
echo "The 1st parameter 	==> $1"
echo "The 2nd parameter 	==> $2"
