#!/bin/bash

sudo docker stop $(sudo docker ps -a | awk '/(redis)/{print $1}') &> /dev/null
echo -e "stop redis success~".



