#!/bin/sh

# 启动 nginx
/usr/bin/nginx

# 启动 php
/usr/bin/php-fpm

# 启动 mysql
/etc/init.d/mysqld start

# 启动 memcached
# /srv/websrv/config/memcached/start.sh

# 启动 redis
# /srv/websrv/config/redis/start.sh
