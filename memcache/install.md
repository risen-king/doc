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


## 3 安装  php-memcache API 
```

[root@www www]# yum --enablerepo=remi install php-memcache

# 编写 phpinfo 文件
[root@www www]# vim phpinfo.php
<?php 
phpinfo();

# 开启 php 服务器后访问 localhost:8080/phpinfo.php 确认 php-memcache 扩展开启
[root@www www]# php -S localhost:8080 -t /var/www &

```

## 4 测试

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

### 5 分布式部署
#### 5.1 开启三个服务

```
[root@www memcache]# /usr/local/memcache/bin/memcached -d -p 11213 -u root -m 10 -c 1024 -t 8 -P /var/run/memcache.pid
[root@www memcache]# /usr/local/memcache/bin/memcached -d -p 11214 -u root -m 10 -c 1024 -t 8 -P /var/run/memcache.pid
[root@www memcache]# /usr/local/memcache/bin/memcached -d -p 11215 -u root -m 10 -c 1024 -t 8 -P /var/run/memcache.pid

```
#### 5.2 编写测试文件 distributed.php

```
[root@www memcache]# vim distributed.php
<?php
$mem = new Memcache;
$mem->addServer('localhost',11213);
$mem->addServer('localhost',11214);
$mem->addServer('localhost',11215);

$memStats = $mem->getExtendedStats();
print_r($memStats);

```

```
[root@www memcache]# php distributed.php
Array
(
    [localhost:11213] => Array
        (
            [pid] => 17817
            [uptime] => 606
            [time] => 1488275226
            [version] => 1.4.35
            [libevent] => 1.4.13-stable
            [pointer_size] => 64
            [rusage_user] => 0.366944
            [rusage_system] => 1.707740
            [curr_connections] => 18
            [total_connections] => 20
            [connection_structures] => 19
            [reserved_fds] => 40
            [cmd_get] => 0
            [cmd_set] => 0
            [cmd_flush] => 0
            [cmd_touch] => 0
            [get_hits] => 0
            [get_misses] => 0
            [get_expired] => 0
            [get_flushed] => 0
            [delete_misses] => 0
            [delete_hits] => 0
            [incr_misses] => 0
            [incr_hits] => 0
            [decr_misses] => 0
            [decr_hits] => 0
            [cas_misses] => 0
            [cas_hits] => 0
            [cas_badval] => 0
            [touch_hits] => 0
            [touch_misses] => 0
            [auth_cmds] => 0
            [auth_errors] => 0
            [bytes_read] => 14
            [bytes_written] => 1310
            [limit_maxbytes] => 10485760
            [accepting_conns] => 1
            [listen_disabled_num] => 0
            [time_in_listen_disabled_us] => 0
            [threads] => 8
            [conn_yields] => 0
            [hash_power_level] => 16
            [hash_bytes] => 524288
            [hash_is_expanding] => 0
            [malloc_fails] => 0
            [log_worker_dropped] => 0
            [log_worker_written] => 0
            [log_watcher_skipped] => 0
            [log_watcher_sent] => 0
            [bytes] => 0
            [curr_items] => 0
            [total_items] => 0
            [expired_unfetched] => 0
            [evicted_unfetched] => 0
            [evictions] => 0
            [reclaimed] => 0
            [crawler_reclaimed] => 0
            [crawler_items_checked] => 0
            [lrutail_reflocked] => 0
        )

    [localhost:11214] => Array
        (
            [pid] => 17829
            [uptime] => 600
            [time] => 1488275227
            [version] => 1.4.35
            [libevent] => 1.4.13-stable
            [pointer_size] => 64
            [rusage_user] => 0.326950
            [rusage_system] => 1.753733
            [curr_connections] => 18
            [total_connections] => 20
            [connection_structures] => 19
            [reserved_fds] => 40
            [cmd_get] => 0
            [cmd_set] => 0
            [cmd_flush] => 0
            [cmd_touch] => 0
            [get_hits] => 0
            [get_misses] => 0
            [get_expired] => 0
            [get_flushed] => 0
            [delete_misses] => 0
            [delete_hits] => 0
            [incr_misses] => 0
            [incr_hits] => 0
            [decr_misses] => 0
            [decr_hits] => 0
            [cas_misses] => 0
            [cas_hits] => 0
            [cas_badval] => 0
            [touch_hits] => 0
            [touch_misses] => 0
            [auth_cmds] => 0
            [auth_errors] => 0
            [bytes_read] => 14
            [bytes_written] => 1310
            [limit_maxbytes] => 10485760
            [accepting_conns] => 1
            [listen_disabled_num] => 0
            [time_in_listen_disabled_us] => 0
            [threads] => 8
            [conn_yields] => 0
            [hash_power_level] => 16
            [hash_bytes] => 524288
            [hash_is_expanding] => 0
            [malloc_fails] => 0
            [log_worker_dropped] => 0
            [log_worker_written] => 0
            [log_watcher_skipped] => 0
            [log_watcher_sent] => 0
            [bytes] => 0
            [curr_items] => 0
            [total_items] => 0
            [expired_unfetched] => 0
            [evicted_unfetched] => 0
            [evictions] => 0
            [reclaimed] => 0
            [crawler_reclaimed] => 0
            [crawler_items_checked] => 0
            [lrutail_reflocked] => 0
        )

    [localhost:11215] => Array
        (
            [pid] => 17842
            [uptime] => 593
            [time] => 1488275226
            [version] => 1.4.35
            [libevent] => 1.4.13-stable
            [pointer_size] => 64
            [rusage_user] => 0.380942
            [rusage_system] => 1.737735
            [curr_connections] => 18
            [total_connections] => 20
            [connection_structures] => 19
            [reserved_fds] => 40
            [cmd_get] => 0
            [cmd_set] => 0
            [cmd_flush] => 0
            [cmd_touch] => 0
            [get_hits] => 0
            [get_misses] => 0
            [get_expired] => 0
            [get_flushed] => 0
            [delete_misses] => 0
            [delete_hits] => 0
            [incr_misses] => 0
            [incr_hits] => 0
            [decr_misses] => 0
            [decr_hits] => 0
            [cas_misses] => 0
            [cas_hits] => 0
            [cas_badval] => 0
            [touch_hits] => 0
            [touch_misses] => 0
            [auth_cmds] => 0
            [auth_errors] => 0
            [bytes_read] => 14
            [bytes_written] => 1310
            [limit_maxbytes] => 10485760
            [accepting_conns] => 1
            [listen_disabled_num] => 0
            [time_in_listen_disabled_us] => 0
            [threads] => 8
            [conn_yields] => 0
            [hash_power_level] => 16
            [hash_bytes] => 524288
            [hash_is_expanding] => 0
            [malloc_fails] => 0
            [log_worker_dropped] => 0
            [log_worker_written] => 0
            [log_watcher_skipped] => 0
            [log_watcher_sent] => 0
            [bytes] => 0
            [curr_items] => 0
            [total_items] => 0
            [expired_unfetched] => 0
            [evicted_unfetched] => 0
            [evictions] => 0
            [reclaimed] => 0
            [crawler_reclaimed] => 0
            [crawler_items_checked] => 0
            [lrutail_reflocked] => 0
        )

)

```

### 6 分布式系统的良性运行
> 在Memcache的实际使用中，遇到的最严重的问题，就是在增减服务器的时候，会导致大范围的缓存丢失，从而可能会引导数据库的性能瓶颈。

> 对于php 来说有两个不同版本的客户端，memcache是pecl扩展库版本，memcached是libmemcached版本。建议使用 memcached

> Memcache 
```

#修改php.ini添加： 
[Memcache] 
Memcache.allow_failover = 1 
Memcache.hash_strategy =consistent 
Memcache.hash_function =crc32 

#ini_set方法： 
Ini_set(‘memcache.hash_strategy',' consistent '); 
Ini_set(‘memcache.hash_function','crc32');
```


> Memcached 

```
$mem = new memcached(); 
$mem->addServers(array(array('127.0.0.1',11300,100),array('127.0.0.1',11301,0)));  

$mem->setOption(Memcached::OPT_DISTRIBUTION, Memcached::DISTRIBUTION_CONSISTENT);  
$mem->setOption(Memcached::OPT_HASH, Memcached::HASH_CRC);  

for ($i=0;$i<10;$i++){  
    $key = "item_$i";  
    $arr = $mem->getServerByKey($key);  
    echo ($key.":\t".$arr['port']."\n");  
} 

print_r($mem->getServerList());  
```
