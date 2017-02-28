#!/bin/bash
# Program:
#	This program create three files,which named by user's input
# History:
# 2005/08/23 ahcj Frist release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# 1 让使用者输入文件名称，并取得 fileuser 这个变量
echo -e "I will use 'touch' command to create 3 fiels"
read -p "Please input your filename: " fileuser

# 2 为了避免使用者随意按 enter，利用 变量功能分析档名是否有配置
filename=${fileuser:-"filename"}

#3 利用 date 命令来取得所需档名
date1=$(date --date="2 days ago" +%Y%m%d)
date2=$(date --date="1 days ago" +%Y%m%d)
date3=$(date +%Y%m%d)

file1=${filename}${date1}
file2=${filename}${date2}
file3=${filename}${date3}

# 4 创建档名
touch "$file1"
touch "$file2"
touch "$file3"

