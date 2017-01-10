在Docker中使用Zabbix 进行监控
========================

## Container

容器提供了以下* Zabbix服务*，请参阅[ Zabbix文件]（http://www.zabbix.com/）附加信息。

*  *Zabbix Server* 端口号10051.
*  *Zabbix Java Gateway* 端口号 10052.
*  *Zabbix Web UI* 端口号 80 (例子 `http://$container_ip/zabbix` )
*  *Zabbix Agent*.
*  MySQL实例支持 *Zabbix*, 用户名密码都是 `zabbix`.
*  Monit管理在这里 (http://$container_ip:2812, user 'myuser' and password 'mypassword').


## 如何使用

你可以执行以下命令运行Zabbix服务.

```
docker run -d -P --name zabbix  berngp/docker-zabbix
```


上面的命令要求在*docker*跑*berngp/docker-zabbix*镜像的时候开放所有** Zabbix **指定所有本地端口去运行实例。
运行 `docker ps -f name=zabbix` 检查端口映射到容器的'80'端口, *Zabbix Web UI*.

打开 `http://<docker实例的ip地址>:<docker指定的端口默认是80>/zabbix`

一个将端口` 80 `映射到` 49184 `端口的例子。

```
$ docker ps -f name=zabbix
CONTAINER ID        IMAGE                         COMMAND                CREATED             STATUS              PORTS                                                                                                NAMES
970eb1571545        berngp/docker-zabbix:latest   "/bin/bash /start.sh   18 hours ago        Up 2 hours          0.0.0.0:49181->10051/tcp, 0.0.0.0:49182->10052/tcp, 0.0.0.0:49183->2812/tcp, 0.0.0.0:49184->80/tcp   zabbix
```

如果你想在Docker主机绑定容器特定的端口，你可以执行以下命令：

```
docker run -d \
           -p 10051:10051 \
           -p 10052:10052 \
           -p 80:80       \
           -p 2812:2812   \
           --name zabbix  \
           berngp/docker-zabbix
```

上面的命令会* Zabbix服务*通过* 10051 *端口启动，而Web界面则通过* 80 *端口运行名字是` Zabbix `的实例。
要有耐心的花一两分钟配置MySQL实例启动服务。你可以使用`docker logs -f $contaienr_id`记录日志。

以上都做完了*Zabbix Web UI* 就已经运行了 你可以通过`http://$container_ip/zabbix`访问. 用户名是 `admin`密码是 `zabbix`.


### Apparmor 细节 (仅仅在Debian和Ubuntu)

如果你想容器使用Monit控制和监视各个进程, 你需要配置Docker的默认Apparmor配置文件. 目前，唯一的办法就是添加`trace`能力和运行的容器通过AppArmor，使用下面的标识`RUN` 
command:

```
--cap-add SYS_PTRACE  --security-opt apparmor:unconfined
```

如果添加*vast*号日志信息写入你得你的系统日志，并每10秒跟踪一次进程！


## 挖掘Docker Zabbix 容器

如果你想查看部署运行容器的内容, 你可以通过如下命令 _bash shell_ through _docker's exec_ .
执行以下命令.

```
docker exec -i -t zabbix /bin/bash
```

## 问题和错误.

你可以随时提出任何问题 [here](https://git.oschina.net/yyljlyy/docker-zabbix/issues).


# 开发者

我建议你通过发行版建立Docker, 如果你使用的是 Mac OSX 我建议你利用 [boot2docker](http://boot2docker.io/), 你也可以使用*Vagrantfile* 创建一个_Docker_环境.

## 用Vagrantfile文件设置你得Docker环境

运行其中包含的 _Vagrantfile_ 文件你需要安装[VirtualBox](https://www.virtualbox.org/) 和 [Vagrant](http://www.vagrantup.com/) . 实际中我使用了_VirtualBox_ 4.3.6 和_Vagrant_ 1.4.1.使用_Vagrantfile_ 构建一个最小化的_Ubuntu 64_ 操作系统_VirtualBox Guest Additions_ along with _Docker_ and its dependencies. 第一次你需要执行`vagrant up` 完成安装和构建, 然后你执行 `vagrant reload`去完成vagrant的重启.在完成这一切以后你只需要执行 `vagrant ssh`去ssh连接你得机器并且用`which docker`命令找到 _Docker_ 所在位置 

*Be aware* that the _Vagrantfile_ depends on the version of _VirtualBox_ and may run into problems if you don't have the latest versions.

## 创建Docker Zabbix 仓库.

Within an environment that is already running _docker_, checkout the *docker-zabbix* code to a known directory. If you are using the _Vagrantfile_, as mentioned above, it will be available by default in the `/docker/docker-zabbix` directory. From there you can execute a build and run the container.

e.g.

```
# 进入容器构建代码目录.
cd /docker/docker-zabbix
# 构建容器.
docker build -t berngp/docker-zabbix .
#启动他!
docker run -i -t -P --name=zabbix berngp/docker-zabbix
```

### 资源来自:

* [CosmicQ](https://github.com/CosmicQ)
* [JensErat](https://github.com/JensErat)
* [mvanholsteijn](https://github.com/mvanholsteijn)
* [Nekroze](https://github.com/Nekroze)


祝你玩的愉快!
========================


## Container

The container provides the following *Zabbix Services*, please refer to the [Zabbix documentation](http://www.zabbix.com/) for additional info.

* A *Zabbix Server* at port 10051.
* A *Zabbix Java Gateway* at port 10052.
* A *Zabbix Web UI* at port 80 (e.g. `http://$container_ip/zabbix` )
* A *Zabbix Agent*.
* A MySQL instance supporting *Zabbix*, user is `zabbix` and password is `zabbix`.
* A Monit deamon managing the processes (http://$container_ip:2812, user 'myuser' and password 'mypassword').


## Usage

You can run Zabbix as a service executing the following command.

```
docker run -d -P --name zabbix  berngp/docker-zabbix
```

The command above is requesting *docker* to run the *berngp/docker-zabbix* image in the background, publishing all ports to the host interface assigning the name of **zabbix** to the running instance.
Run `docker ps -f name=zabbix` to review which port was mapped to the container's port '80', the *Zabbix Web UI*.

Open `http://<ip of the host running the docker deamon>:<host port mapped to the container's port 80>/zabbix`

In the example bellow the container's port `80` is mapped to `49184`.

```
$ docker ps -f name=zabbix
CONTAINER ID        IMAGE                         COMMAND                CREATED             STATUS              PORTS                                                                                                NAMES
970eb1571545        berngp/docker-zabbix:latest   "/bin/bash /start.sh   18 hours ago        Up 2 hours          0.0.0.0:49181->10051/tcp, 0.0.0.0:49182->10052/tcp, 0.0.0.0:49183->2812/tcp, 0.0.0.0:49184->80/tcp   zabbix
```

If you want to bind the container's port with specific ports from the host running the docker daemon you can execute the following:

```
docker run -d \
           -p 10051:10051 \
           -p 10052:10052 \
           -p 80:80       \
           -p 2812:2812   \
           --name zabbix  \
           berngp/docker-zabbix
```

The above command will expose the *Zabbix Server* through port *10051* and the *Web UI* through port *80* on the host instance, among others and associate it with the name `zabbix`.
Be patient, it takes a minute or two to configure the MySQL instance and start the proper services. You can tail the logs using `docker logs -f $contaienr_id`.

After the container is ready the *Zabbix Web UI* should be available at `http://$container_ip/zabbix`. User is `admin` and password is `zabbix`.


### Apparmor Specifics (Debian and Ubuntu)

The container uses Monit for controlling and observing the individual processes, which requires capabilities denied by Docker's default Apparmor profile. Currently, the only workaround is to add the `trace` capability and running the container without being fenced by Apparmor, using following flags in the `RUN` command:

```
--cap-add SYS_PTRACE  --security-opt apparmor:unconfined
```

Not doing so will result in a *vast* number of log messages polluting your syslog, as Monit tries to trace the processes all 10 seconds!


## Exploring the Docker Zabbix Container

Sometimes you might just want to review how things are deployed inside a running container, you can do this by executing a _bash shell_ through _docker's exec_ command.
Execute the command bellow to do it.

```
docker exec -i -t zabbix /bin/bash
```

## Issues and Bugs.

Feel free to report any problems [here](https://github.com/berngp/docker-zabbix/issues).


# Developers

I suggest you install docker through your distribution, if using Mac OSX I suggest you leverage [boot2docker](http://boot2docker.io/), as an option the project has a *Vagrantfile* that you can use to create a virtual instance with _Docker_.

## Setting your Docker environment with the Vagrantfile

To run the included _Vagrantfile_ you will need [VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/) installed. Currently I am testing it against _VirtualBox_ 4.3.6 and _Vagrant_ 1.4.1. The _Vagrantfile_ uses a minimal _Ubuntu Precise 64_ box and installs the _VirtualBox Guest Additions_ along with _Docker_ and its dependencies. The first time you execute a `vagrant up` it will go through an installation and build process, after its done you will have to execute a `vagrant reload`. After that you should be able to do a `vagrant ssh` and find that _Docker_ is available using a `which docker` command.

*Be aware* that the _Vagrantfile_ depends on the version of _VirtualBox_ and may run into problems if you don't have the latest versions.

## Building the Docker Zabbix Repository.

Within an environment that is already running _docker_, checkout the *docker-zabbix* code to a known directory. If you are using the _Vagrantfile_, as mentioned above, it will be available by default in the `/docker/docker-zabbix` directory. From there you can execute a build and run the container.

e.g.

```
# CD into the docker container code.
cd /docker/docker-zabbix
# Build the contaienr code.
docker build -t berngp/docker-zabbix .
# Run it!
docker run -i -t -P --name=zabbix berngp/docker-zabbix
```

## Contributing.

Appreciate any contribution regardless of the size. If your contribution is associated with any reported [issue](https://github.com/berngp/docker-zabbix/issues) please add the details in the comments of the PR (Pull Request).

### Contributions from:

* [CosmicQ](https://github.com/CosmicQ)
* [JensErat](https://github.com/JensErat)
* [mvanholsteijn](https://github.com/mvanholsteijn)
* [Nekroze](https://github.com/Nekroze)


Thank you and happy metrics gathering!