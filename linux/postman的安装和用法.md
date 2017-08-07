## 安装 postman
### 1 下载 postman 离线包 
https://pan.baidu.com/s/1mh6Rqvm
提取密码：w8gj

### 2  解压缩,并修改文件名 _metadata 为 metadata
```
mkdir postman;
mv Postman_v4.1.3.zip  postman/
unzip Postman_v4.1.3.zip
mv _metadata  metadata
```

### 3  在地址栏打开 chrome::/extensions，勾选开发这模式， 单击 加载已解压的扩展程序，选择插件的解压目录，就可以安装了。

<img src="https://raw.githubusercontent.com/risen-king/doc/master/img/postman-install.png" width="600px" />



##  发送 GET 请求

### 1 在地址栏里输入请求url： http://localhost:8080/users

### 2 选择 GET 方式，

### 3 点击 send 发送

<img src="https://raw.githubusercontent.com/risen-king/doc/master/img/postman-get.png" width="600px" />


##  发送 POST 请求

### 1 选择 POST 方式

### 2 选择 body

### 3 上传类型选择 x-www-form-urlencoded 

### 4 输入
```
  username： jim
  password: 123456
  email: jim@sina.com
```
  
### 5 点击 send 发送

<img src="https://raw.githubusercontent.com/risen-king/doc/master/img/postman-post.png" width="600px" />



## 上传文件

### 1 选择post方式

### 2 选择body

### 3 上传类型选择 form-data， key的类型 改为 file

### 4 输入key：file  ，value：选择文件

### 5 点击 send 发送

<img src="https://raw.githubusercontent.com/risen-king/doc/master/img/postman-file.png" width="600px" />
