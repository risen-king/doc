
#安装 Ionic 运行环境 

------

 1. **安装Node.js  npm**

下载 node 最新版,安装好后切换到淘宝镜像源：

    `npm install -g cnpm --registry=http://registry.npm.taobao.org`


 2. **安装Ionic2**


     `cpm install -g ionic`

需要注意的是，如果之前安装过 Ionic 2 的 beta 版本，需要先卸载掉：

    `npm uninstall -g ionic`

安装完成后输入以下命令看一下版本号：

    `ionic -version
    2.1.0`

目前最新版本是2.1.0。如果是 beta 版本的话，请重新安装，确保安装最新版。
 
 **3. 创建项目**

打开 Node 命令行，首先 cd 到项目目录，使用 start 命令来创建一个新App：

    `cd /d/javascript
    ionic start MyIonic2Project tutorial --v2`

> 语法:
> 
>     `ionic start 项目名称 项目模板 版本`
> 
> 项目名称：自定义 项目名称：[ tabs|tutorial|blank]，默认会使用 tabs 模板 版本：--v2
> 参数必须要加，不然会建立 v1.x 版本的项目


如果失败，有可能会出现以下信息：

    `Creating Ionic app in folder E:\Workspaces\Ionic2\MyIonic2Project based on tutorial project
    Downloading: https://github.com/driftyco/ionic2-app-base/archive/master.zip
    [=============================] 100% 0.0s
    Downloading: https://github.com/driftyco/ionic2-starter-tutorial/archive/master.zip
    [=============================] 100% 0.0s
    Installing npm packages...
    Error with start undefined
    Error Initializing app: There was an error with the spawned command: npminstall
    There was an error with the spawned command: npminstall
    Caught exception:
     undefined
    Mind letting us know? https://github.com/driftyco/ionic-cli/issues`


这说明 npm 安装的时候失败了，可以 cd 到项目目录，使用之前设置过的 cnpm 命令：

    `cd MyIonic2Project
    cnpm install`
 
 直到最后输出类似以下信息：
 
    √ All packages installed (477 packages installed from npm registry, used 2m, speed 77.14kB/s, json 549(3.42MB), tarball 3.38MB)

 **4. 在浏览器中运行**
 

    `ionic serve`
输出类似下面的内容：

    `ionic serve
    ionic-app-base@ ionic:serve D:\javascript\ionicFirst
    ionic-app-scripts serve
    
    keywords if/then/else require v5 option
    [17:06:30]  ionic-app-scripts 0.0.47
    [17:06:31]  watch started ...
    [17:06:31]  build dev started ...
    [17:06:31]  clean started ...
    [17:06:31]  clean finished in 1 ms
    [17:06:31]  copy started ...
    [17:06:31]  transpile started ...
    [17:06:35]  transpile finished in 4.49 s
    [17:06:35]  webpack started ...
    [17:06:36]  copy finished in 4.84 s
    [17:06:51]  webpack finished in 15.22 s
    [17:06:51]  sass started ...
    [17:06:53]  sass finished in 2.01 s
    [17:06:53]  build dev finished in 21.92 s
    [17:06:53]  watch ready in 22.08 s
    [17:06:53]  dev server running: http://localhost:8100/`

接着浏览器会打开一个地址为 http://localhost:8100 的窗口，端口号根据当前PC的实际情况可能会有变化，如果8100被占用了会使用8101等。

 5. **安装Cordova**

    `cnpm install -g cordova`

看一下版本号：

    `cordova -version
    6.4.0`



