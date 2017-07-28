# CentOS7 安装 nodejs

tags： linux centos nvm nodejs npm

---

## 安装 nvm

### 下载并执行脚本
```sh
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
```

### 设置nvm 国内镜像
```sh
echo "export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node" >> ~/.bashrc

source ~/.bashrc
```

### 安装最新版本 nodejs
```sh
nvm install stable
```

### 卸载指定版本
```sh
nvm uninstall 8
```

### 查看已安装版本
```sh
nvm ls
->       v8.2.1
default -> 8 (-> v8.2.1)
node -> stable (-> v8.2.1) (default)
stable -> 8.2 (-> v8.2.1) (default)
iojs -> N/A (default)
lts/* -> lts/boron (-> N/A)
lts/argon -> v4.8.4 (-> N/A)
lts/boron -> v6.11.1 (-> N/A)

```
### 列出所以远程服务器的版本
```sh
nvm ls-remote
```

### 显示当前的版本
```sh
nvm current
```

### 使用指定版本
```sh
nvm use 8
```


### 设置默认版本
```sh
nvm alias default 8
```

### 取消默认版本
```sh
nvm alias default
```


----------


## 设置 npm
### 安装 cnpm
```sh
npm --registry=https://registry.npm.taobao.org install cnpm -g
```


### 国内镜像

>  cnpm 已经默认将 --registry 和 --disturl 都配置好了,但有可能别的程序会调用 npm，所以最好将 npm 也设置一下。

```sh
npm config set registry https://registry.npm.taobao.org --global
npm config set disturl https://npm.taobao.org/dist --global
```










