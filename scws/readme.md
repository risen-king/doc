
### 1 安装scws
```
[root@www Downloads]# wget http://www.xunsearch.com/scws/down/scws-1.2.3.tar.bz2
[root@www Downloads]# tar -xvj  -f scws-1.2.2.tar.bz2  -C /usr/local/src
[root@www Downloads]# cd /usr/local/src/scws-1.2.3/ 
[root@www scws-1.2.3]# ./configure --prefix=/usr/local/scws/ 
[root@www scws-1.2.3]# make clean && make && make install 
```

### 2 安装scws php扩展
```
[root@www scws-1.2.3]# cd ./phpext/
[root@www scws-1.2.3]# phpize 
[root@www scws-1.2.3]# ./configure --with-php-config=/usr/bin/php-config  
[root@www scws-1.2.3]# make clean && make && make install 
```

### 3 安装scws词库,让php-fpm或者php-cgi的运行用户，拥有dict.utf8.xdb的所有权限
```
[root@www Downloads]# wget http://www.xunsearch.com/scws/down/scws-dict-chs-utf8.tar.bz2
[root@www Downloads]# wget http://www.xunsearch.com/scws/down/scws-dict-chs-gbk.tar.bz2
[root@www Downloads]# tar -xvj -f scws-dict-chs-utf8.tar.bz2 -C /usr/local/scws/etc/
[root@www Downloads]# tar -xvj -f scws-dict-chs-gbk.tar.bz2  -C /usr/local/scws/etc/ 
[root@www Downloads]# ps aux | grep php-fpm
root     19524  0.0  0.0 103252   832 pts/4    S+   00:15   0:00 grep php-fpm    
[root@www Downloads]# chown root:root /usr/local/scws/etc/dict.utf8.xdb
[root@www Downloads]# chown root:root /usr/local/scws/etc/dict.gbk.xdb
```

### 4 配置php.ini

```
[root@www Downloads]# vim /etc/php.ini 
;
; 注意请检查 php.ini 中的 extension_dir 的设定值是否正确, 否则请将 extension_dir 设为空，
; 再把 extension = scws.so 指定绝对路径。
;
[scws]  
extension = scws.so  
scws.default.charset = utf-8  
scws.default.fpath = /usr/local/scws/etc  
# 执行 php -m 就能看到 scws 了或者在 phpinfo() 中看看关于 scws 的部分,就算安装完成了
[root@www Downloads]#  /etc/init.d/php-fpm restart 
[root@www Downloads]#  php -m
```

### 5  测试

```
[root@www www]#  vim test1.php
<?php
 $b_time = microtime(true);  
 $key = "游览车事故频发，台湾怎么了?";  
 
 $so = scws_new();  
 $so->set_charset('utf-8');  
 //默认词库  
 $so->add_dict(ini_get('scws.default.fpath') . '/dict.utf8.xdb');  
 //自定义词库  
 // $so->add_dict('./dd.txt',SCWS_XDICT_TXT);  
 
 //默认规则  
 $so->set_rule(ini_get('scws.default.fpath') . '/rules.utf8.ini');  
  
 //设定分词返回结果时是否去除一些特殊的标点符号  
 $so->set_ignore(true);  
  
 //设定分词返回结果时是否复式分割，如“中国人”返回“中国＋人＋中国人”三个词。  
 // 按位异或的 1 | 2 | 4 | 8 分别表示: 短词 | 二元 | 主要单字 | 所有单字  
 //1,2,4,8 分别对应常量 SCWS_MULTI_SHORT SCWS_MULTI_DUALITY SCWS_MULTI_ZMAIN SCWS_MULTI_ZALL  
 $so->set_multi(false);  
  
 //设定是否将闲散文字自动以二字分词法聚合  
 $so->set_duality(false);  
  
 //设定搜索词  
 $so->send_text($key);  
 $words_array = $so->get_result(); 
 $so->close();  
 
 //组合成字符串
 $words = "";  
 foreach($words_array as $v){  
     $words = $words.'|('.$v['word'].')';  
 }  
 #$words = '('.$key.')'.$words;  
 $words = trim($words,'|');  
 
 //时间统计
 $e_time = microtime(true);  
 $time = $e_time - $b_time;  
 
 print_r($words_array); 
 
 echo '时间: '.$time ."\n";
 echo '输入：'.$key  ."\n";  
 echo '分词：'.$words."\n";
```

### 6 在线API

也可以使用在线API实现中文分词,API地址：http://www.xunsearch.com/scws/api.php，详细说明也在地址中。

> 参考

[SCWS 中文分词](www.xunsearch.com/scws/docs.php#phpscws)

[SCWS 样例1](https://github.com/xingchuan/scripts/blob/master/scws/test1.php)

[SCWS 样例2](https://github.com/xingchuan/scripts/blob/master/scws/scws.php)

[SCWS 样例3](https://github.com/xingchuan/scripts/blob/master/scws/scws_test.php)

