### 1 下载 phpMyAdmin 解压到  /usr/local/nginx/html 目录下,修改文件属性
```
[root@localhost nginx]# chown -R nginx:nginx  /usr/local/nginx/html/phpMyAdmin
[root@localhost nginx]# ll -d /usr/local/nginx/html/phpMyAdmin
drwxrwxrwx. 12 nginx nginx 4096 8月   9 14:34 /usr/local/nginx/html/phpMyAdmin
```
 
### 2 新建配置文件 /usr/local/nginx/conf/conf.d/php-my-admin.conf

``` 
server {
        listen       80;
        server_name  php-my-admin.localhost;
 
 
        #access_log  logs/host.access.log  main;
 
        root   /usr/local/nginx/html/phpMyAdmin;
        
        location / {
            index  index.html index.htm index.php;
        }

       # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
       location ~ \.php$ {
	     fastcgi_pass   127.0.0.1:9000;
	     fastcgi_index  index.php;
	     
	     include        fastcgi.conf;
	 }
}
```
### 3 修改文件属性
```
[root@localhost conf.d]# ll /usr/local/nginx/conf/conf.d/php-my-admin.conf 
-rw-r--r--. 1 nginx nginx 485 8月   9 14:38 /usr/local/nginx/conf/conf.d/php-my-admin.conf
```

### 4 修改 /usr/local/nginx/conf/nginx.conf,末尾加上
```
include /usr/local/nginx/conf/conf.d/*.conf;
```
### 5 重载配置文件
```
[root@localhost conf.d]# nginx -s reload
[root@localhost conf.d]# service php-fpm reload
```
### 6 在 /etc/hosts 文件中加一行
```
127.0.0.1 php-my-admin.localhost
```

 
### 7 如果 /usr/local/nginx/error.log 提示没有权限,可能需要关闭 seLinux
```
#查看

[root@localhost conf.d]# getenforce
Disabled
[root@localhost conf.d]# /usr/sbin/sestatus -v
SELinux status:                 disabled
 

#临时关闭

#设置SELinux 成为permissive模式
#setenforce 1 设置SELinux 成为enforcing模式
[root@localhost conf.d]# setenforce 0

#永久关闭

[root@localhost conf.d]# vim /etc/selinux/config
#将SELINUX=enforcing改为SELINUX=disabled
#设置后需要重启才能生效
#SELINUX=enforcing
SELINUX=disabled
```
