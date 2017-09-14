#!/bin/bash
#docker start redis01 redis02 redis03 redis04 redis05 redis06

sudo docker rm $(sudo docker ps -a | awk '/(redis)/{print $1}')
path= 'pwd';


for ((i=1; i<=6; i++))
do
    sudo docker run -tid \
        --name redis0$i \
        --net=redis \
        -v ~/bigdata/redis.conf:/usr/local/etc/redis/redis.conf \
        xuehanict/redis
done
    

sleep 3

sudo ./redis-trib.rb create --replicas 1 $(sudo docker inspect redis01 redis02 redis03 redis04 redis05 redis06 | grep \"IPAddress\"| grep 172 | awk '/(172)/{print substr($2,2,10)":6379"}')

echo -e "redis start success."
