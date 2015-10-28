#!/bin/sh
kill -INT `cat /srv/websrv/config/php/log/php-fpm.pid`
