基于Hbase和redis的Nosql存储系统  使用说明：

    该项目配置了3个hadoop节点和6个redis节点来模拟真分布的集群。hbase启动后，因为是空数据库，所以需要往其中放入一定量的测试数据后才可以做测试。


1. 测试环境：

    宿主机：
    操作系统：ubuntu 16.04
    java    ：jdk1.7
    Docker  ：1.12.6

    Docker虚拟机(不用考虑)：
    操作系统：ubuntu:14.04 (hadoop hbase), debian:jessie (redis)
    java    ：openJDK 1.7
    Hadoop  ：2.6.4
    Hbase   ：1.2.4
    Redis   ：latest

2. 测试环境配置：

    (1) 安装docker
    apt install docker.io (尽量选用版本较高的，高版本才支持network功能)
    sudo docker network create --driver=bridge hadoop
    sudo docker network create --driver=bridge redis
    
    (2) 下载docker镜像
    sudo docker pull xuehanict/hadoop_hbse
    sudo docker pull xuehanict/redis

    (3) 安装ruby和rubygems
    sudo apt install ruby
    sudo gem install redis
    
    下面对hadoop/hbase 以及redis的容器进行配置。
    (4) 运行start-container.sh创建hadoop和habase的container
    (5) 进入hadoop虚拟机进行配置
        cd 
        ./start_service.sh          #运行服务
        exit                        #退出

    以上完成了对hadoop/hbase的配置，下面对redis进行配置。
    运行./start_redis.sh 开启redis, ./stop_redis.sh 关闭redis

3. 后续配置
    hadoop/hbase 和redis正常启动后，运行sudo docker inspect hadoop-master | grep \"IPAddress\"| grep 172 和sudo docker inspect redis01 | grep \"IPAddress\"| grep 172 查看hadoop-master的ip和redis的ip，在程序中进行配置ip和端口即可。





