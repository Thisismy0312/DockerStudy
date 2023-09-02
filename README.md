# Docker Study

## 在Docker运行Ubuntu

* 拉取Ubuntu镜像
```bash
docker pull ubuntu
```

Docker Ubuntu网址: https://hub.docker.com/_/ubuntu?tab=tags&page=1

* 查看拉取是否成功
```bash
docker images
```

* 运行容器
```bash
docker run --name 新建的容器的名字 -ti -v /AAA:/BBB -d -p 3316:22 ubuntu(这个是镜像的名字)
```

* 宿主机根目录中的AAA文件夹就映射到了容器中去了，两者之间能够共享
* –name 指定生成的容器的名称
* -i: 以交互模式运行容器，保证容器中STDIN是开启的。通常与 -t 同时使用；
* -t: 为容器重新分配一个伪tty终端，通常与 -i 同时使用；
* -d: 后台运行容器，并返回容器ID；
* -p:可以指定要映射的IP和端口，但是在一个指定端口上只可以绑定一个容器。支持的格式有 hostPort:containerPort、ip:hostPort:containerPort、 ip::containerPort。
* ubuntu 则是镜像名称，镜像ID也可以的。

docker ps -a 查看所有的容器，包含启动和挂起的容器

## 注意事项
* 这是一个极度精简的系统，连最基本的wget命令都没有；所以先要apt-get update升级系统和安装apt-get install wget命令

* **正确退出系统**方式：先按，ctrl+p；再按，ctrl+q。绝对不能使用exit或者ctrl+d来退出，这样整个系统就退出了。具体到MAC电脑应该使用control代替ctrl键


* 退出后 再进入ubuntu
    1. 首先用docker ps -a 查找到该CONTAINER ID对应编号（比如：0a3309a3b29e）
    2. 进入该系统，使用命令：docker attach 0a3309a3b29e

## 安装SSH

### 进入容器
```bash
docker exec -t -i 新建容器的名字 /bin/bash
```

### 执行更新操作
```bash
apt-get update
```

### 安装ssh-client、ssh-server
```bash
apt-get install openssh-client
apt-get install openssh-server
```
* 等待，输入Y就可以完成完成安装操作

### 安装完成之后，就可以启动服务
```bash
/etc/init.d/ssh start
```

### 查看是否启动成功
```bash
ps -e|grep ssh
```

### 编辑sshd_config文件
* 需要先安装vim编辑器 
  ```bash
  apt-get install vim
  ```
* 编辑etc/ssh/sshd_config文件，添加一行 PermitRootLogin yes ，使用Esc + ：输入WQ保存修改，退出文件编辑界面

### 重启SSH服务
```bash
service ssh restart
```

### 设置SSH的密码
```bash
passwd root
```
要输入两遍

### 查看容器的IP地址
```bash
docker commit [容器ID/容器名] [REPOSITORY:TAG]
```

## 打包镜像

### 查看当前镜像
```bash
docker images
```

### 打包镜像
```bash
docker save golang:latest > golang.tar
```

### 载入镜像
```bash
docker load -i golang.tar
```