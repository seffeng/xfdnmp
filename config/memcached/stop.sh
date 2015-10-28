#!/bin/sh
kill -s 9 `cat /srv/websrv/tmp/memcached.pid`
