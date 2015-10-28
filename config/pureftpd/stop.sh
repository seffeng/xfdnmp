#!/bin/sh
pid=$(ps ax|grep pure-ftpd|grep -v grep|awk '{print $1}');
if [ "" != "$pid" ]; then 
  kill -9 $pid > /dev/null 2>&1 &
fi 
