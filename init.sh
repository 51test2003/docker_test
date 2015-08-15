#!/bin/bash

while true
do
        process=`ps aux | grep mysqld | grep -v grep`;

        if [ "$process" == "" ]; then
                sleep 1;
        else
                break;
        fi
done

INIT=/webdata/ReChat/setup.sh

if [ -f $INIT ]; then
sh $INIT
fi
