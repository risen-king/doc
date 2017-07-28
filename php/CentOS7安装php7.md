# CentOS7 安装 php7

标签（空格分隔）： linux centos php yum

---

### 卸载已安装软件
```sh
yum remove php*
```

### 安装 php php-fpm  及其他组件
```sh
yum --enablerepo=remi-php71 install   php php-fpm php-mysql   \ 
php-mbstring  php-xml php-mcrypt  php-gd php-ldap php-pear    \
php-xmlrpc php-curl  php-sockets php-memcache
```

### 查找 php 安装 目录
```sh
[root@localhost ~]# rpm -qa | grep php
php-gd-7.1.7-1.el7.remi.x86_64
php-pecl-memcache-3.0.9-0.7.20161124gitdf7735e.el7.remi.7.1.x86_64
php-common-7.1.7-1.el7.remi.x86_64
php-pear-1.10.5-2.el7.remi.noarch
php-pdo-7.1.7-1.el7.remi.x86_64
php-mysqlnd-7.1.7-1.el7.remi.x86_64
php-xml-7.1.7-1.el7.remi.x86_64
php-mcrypt-7.1.7-1.el7.remi.x86_64
php-fpm-7.1.7-1.el7.remi.x86_64
php-xmlrpc-7.1.7-1.el7.remi.x86_64
php-process-7.1.7-1.el7.remi.x86_64
php-7.1.7-1.el7.remi.x86_64
php-json-7.1.7-1.el7.remi.x86_64
php-ldap-7.1.7-1.el7.remi.x86_64
php-mbstring-7.1.7-1.el7.remi.x86_64
php-cli-7.1.7-1.el7.remi.x86_64

# 查找 php 相关文件
[root@localhost ~]# rpm -ql php-7.1.7-1.el7.remi.x86_64
/etc/httpd/conf.d/php.conf
/etc/httpd/conf.modules.d/15-php.conf
/usr/lib64/httpd/modules/libphp7-zts.so
/usr/lib64/httpd/modules/libphp7.so
/usr/share/httpd/icons/php.gif
/var/lib/php/opcache
/var/lib/php/session
/var/lib/php/wsdlcache

[root@localhost ~]# which php
/bin/php



# 查找 php-fpm 相关文件
[root@localhost ~]# rpm -ql php-fpm-7.1.7-1.el7.remi.x86_64
/etc/logrotate.d/php-fpm
/etc/php-fpm.conf
/etc/php-fpm.d
/etc/php-fpm.d/www.conf
/etc/sysconfig/php-fpm
/etc/systemd/system/php-fpm.service.d
/run/php-fpm
/usr/lib/systemd/system/php-fpm.service
/usr/lib/tmpfiles.d/php-fpm.conf
/usr/sbin/php-fpm
/usr/share/doc/php-fpm-7.1.7
/usr/share/doc/php-fpm-7.1.7/php-fpm.conf.default
/usr/share/doc/php-fpm-7.1.7/www.conf.default
/usr/share/fpm
/usr/share/fpm/status.html
/usr/share/licenses/php-fpm-7.1.7
/usr/share/licenses/php-fpm-7.1.7/fpm_LICENSE
/usr/share/man/man8/php-fpm.8.gz
/var/lib/php/opcache
/var/lib/php/session
/var/lib/php/wsdlcache
/var/log/php-fpm

[root@localhost ~]# which php-fpm
/sbin/php-fpm


```

### 启动
```sh
[root@localhost ~]# chkconfig --level 345 php-fpm  on 
[root@localhost ~]# service php-fpm start

[root@localhost ~]# netstat -nlap | grep 9000
tcp        0      0 127.0.0.1:9000          0.0.0.0:*               LISTEN      19182/php-fpm: mast

[root@localhost ~]# ps aux | grep 1918*
root       767  0.0  0.0  19168  1028 ?        Ss   09:14   0:00 /usr/sbin/irqbalance --foreground
root     19182  0.0  0.3 347148 13104 ?        Ss   14:48   0:00 php-fpm: master process (/etc/php-fpm.conf)
apache   19186  0.0  0.1 349232  7456 ?        S    14:48   0:00 php-fpm: pool www
apache   19187  0.0  0.1 349232  7456 ?        S    14:48   0:00 php-fpm: pool www
apache   19188  0.0  0.1 349232  7456 ?        S    14:48   0:00 php-fpm: pool www
apache   19189  0.0  0.1 349232  7456 ?        S    14:48   0:00 php-fpm: pool www
apache   19190  0.0  0.1 349232  7460 ?        S    14:48   0:00 php-fpm: pool www
root     19223  0.0  0.0 211912  3244 pts/1    S    14:49   0:00 su - ahcj
root     19959  0.0  0.0 112668   980 pts/0    R+   14:55   0:00 grep --color=auto 1918*

```

### 使用内置Web Server
```sh
mkdir ~/public_html && cd ~/public_html
php -S localhost:8000

```

