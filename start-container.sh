#!/bin/bash
####################################
# @author: kdf5000 <kdf5000@163.com>
# @date: 2016-05-15
####################################

#node number including master
node_num=$1
if [ $# = 0 ] 
then
	#starting three node for the cluster in default
	node_num=3
fi
#echo $node_num
#stop all the master and slave
sudo docker rm -f $(sudo docker ps -a |awk '/(slave)|(master)/{print $1}') &> /dev/null

#start master first
echo "start master..."
sudo docker run -d -t  --name hadoop-master --net=hadoop -h hadoop-master  xuehanict/hadoop_hbase:0.1 
# get the IP address of master container
MASTER_IP=$(sudo docker inspect -f="{{.NetworkSettings.IPAddress}}" master)
echo "master starts successfully with ipaddress $MASTER_IP"

#start slave
slave_num=$[node_num - 1]
#echo $slave_num
for i in `seq $slave_num`
do
	echo "start slave$i container..."
	sudo docker run -d -t  --net=hadoop  --name hadoop-slave$i -h hadoop-slave$i  xuehanict/hadoop_hbase:0.1 &> /dev/null
done

#enter master
sudo docker exec -it hadoop-master bash
