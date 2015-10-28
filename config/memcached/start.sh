#!/bin/sh
/usr/bin/memcached -d -m 512 -u www -l 127.0.0.1 -p 0 -c 10000 -P /srv/websrv/tmp/memcached.pid -s /srv/websrv/tmp/memcached.sock
