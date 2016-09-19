#!/bin/sh

# 停止 nginx
/usr/bin/nginx -s stop

# 停止 php
/srv/websrv/config/php/stop.sh

# 停止 mysql
/etc/init.d/mysql.server stop

# 停止 memcached
# /srv/websrv/config/memcached/stop.sh

# 停止 redis
# /srv/websrv/config/redis/stop.sh
