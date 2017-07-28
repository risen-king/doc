
### 1  添加运行nginx服务进程的用户

```
[root@localhost ~]# groupadd -r nginx
[root@localhost ~]# useradd -r -g nginx nginx
```

### 2 安装依赖  

```
[root@localhost ~]# yum groupinstall -y "Development tools"

[root@localhost ~]# yum install -y  gcc wget gcc-c++ automake autoconf \
    libtool libxml2-devel libxslt-devel perl-devel \
    perl-ExtUtils-Embed pcre-devel openssl-devel
```

### 3 下载源码

```
[root@localhost ~]# wget http://nginx.org/download/nginx-1.10.2.tar.gz
[root@localhost ~]# tar -xvf nginx-1.10.2.tar.gz  -C /usr/local/src

```

### 4 下载 echo 模块 
```
[root@localhost ~]# cd /usr/local/src/
[root@localhost ~]# git clone https://github.com/openresty/echo-nginx-module.git
[root@localhost src]# ll
总用量 0
drwxr-xr-x. 6 root root 186 7月  28 23:31 echo-nginx-module
drwxr-xr-x. 8 1001 1001 158 10月 18 2016 nginx-1.10.2

```


### 5 编译安装
```
[root@localhost src]# cd /usr/local/src/nginx-1.10.2/
[root@localhost nginx-1.10.2]# ./configure \
--prefix=/usr/local/nginx \
--sbin-path=/usr/local/nginx/sbin/nginx \
--conf-path=/usr/local/nginx/conf/nginx.conf \
--error-log-path=/usr/local/nginx/log/error.log \
--http-log-path=/usr/local/nginx/log/access.log \
--pid-path=/usr/local/nginx/run/nginx.pid \
--lock-path=/usr/local/nginx/run/nginx.lock \
--http-client-body-temp-path=/usr/local/nginx/tmp/client \
--http-proxy-temp-path=/usr/local/nginx/tmp/proxy \
--http-fastcgi-temp-path=/usr/local/nginx/tmp/fcgi \
--http-uwsgi-temp-path=/usr/local/nginx/tmp/uwsgi \
--http-scgi-temp-path=/usr/local/nginx/tmp/scgi \
--user=nginx \
--group=nginx \
--with-pcre \
--with-http_v2_module \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_stub_status_module \
--with-http_auth_request_module \
--with-mail \
--with-mail_ssl_module \
--with-file-aio \
--with-http_v2_module \
--with-threads \
--with-stream \
--with-stream_ssl_module \
--add-module=/usr/local/src/echo-nginx-module
[root@localhost nginx-1.10.2]# make && make install
[root@localhost nginx-1.10.2]# mkdir -pv /usr/local/nginx/tmp/client
[root@localhost nginx-1.10.2]# ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx

```

### 6 启动 nginx 

```

[root@localhost nginx-1.10.2]# nginx
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] still could not bind()

```

### 7  浏览器访问可看到默认欢迎页面

```

Welcome to nginx!

If you see this page, the nginx web server is successfully installed and working. Further configuration is required.

For online documentation and support please refer to nginx.org.
Commercial support is available at nginx.com.

Thank you for using nginx.

```
 







