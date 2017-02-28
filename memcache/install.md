
## 1 安装 memcache 
```
# 安装 libevent-devel 依赖 和 php-memcache API 
[root@www www]# yum --enablerepo=remi install libevent-devel

# 下载最新版本
[root@www www]# wget -P ~/Downloads/ http://memcached.org/latest

# 编译安装
[root@www www]# tar -zxv -f ~/Downloads/memcached-1.4.35.tar.gz  -C /usr/local/src
[root@www www]# /usr/local/src/memcached-1.4.35/configure --prefix=/usr/local/memcache
[root@www www]# make clean && make && make install

```
## 2 启动 和关闭 memcached

```
#开启服务
[root@www memcached-1.4.35]# /usr/local/memcache/bin/memcached -d -m 10 -u root -p 11211 -c 256 -P /var/run/memcached.pid

#结束服务
[root@www memcached-1.4.35]# kill $(cat /var/run/memcached.php)

```


```
# 安装  php-memcache API 
[root@www www]# yum --enablerepo=remi install php-memcache

# 编写 phpinfo 文件
[root@www www]# vim phpinfo.php
<?php 
phpinfo();

# 开启 php 服务器后访问 localhost:8080/phpinfo.php 确认 php-memcache 扩展开启
[root@www www]# php -S localhost:8080 -t /var/www &

```
>  
> 参数
> 
> -d 选项是启动一个守护进程，
> 
> -m是分配给Memcache使用的内存数量，单位是MB，我这里是10MB，
> 
> -u是运行Memcache的用户，我这里是root，
> 
> -l是监听的服务器IP地址，如果有多个地址的话，我这里指定了服务器的IP地址192.168.0.200，
> 
> -p是设置Memcache监听的端口，我这里设置了12000，最好是1024以上的端口，
> 
> -c选项是最大运行的并发连接数，默认是1024，我这里设置了256，按照你服务器的负载量来设定，
> 
> -P是设置保存Memcache的pid文件，我这里是保存在 /tmp/memcached.pid
>  


## 3 测试

```
[root@www www]# vim memcache.php
<?php
// 连接
$mem = new Memcache;
$mem->connect("127.0.0.1",11211);

// 保存数据
$mem->set('key1','This is first value',0,60);
$val = $mem->get('key1');
echo "Get key1 value: ".$val."\n\n";

// 替换数据
$mem->replace('key1','This is replcae value',0,60);
$val = $mem->get('key1');
echo "Get key1 value: ".$val ."\n\n";


// 保存数组
$arr = array('aa','bb','cc');
$mem->set('key2',$arr,0,60);
$val2 = $mem->get('key2');
echo "Get key2 value: ";
print_r($val2);
echo "\n\n";

echo "********* 华丽的分割线 *******************";
echo "\n\n";

// 删除数据
$mem->delete('key1');
$val = $mem->get('key1');
echo "Get key1 value: " .$val ."\n\n";

// 清除所有数据
$mem->flush();
$val2 = $mem->get('key2');
echo "Get key2 value : ";
print_r($val2);
echo "\n\n\n";

// 关闭连接
$mem->close();

```

```
[root@www www]# php memcache.php 
Get key1 value: This is first value

Get key1 value: This is replcae value

Get key2 value: Array
(
    [0] => aa
    [1] => bb
    [2] => cc
)


********* 华丽的分割线 *******************

Get key1 value: 

Get key2 value : 

```









