#!/bin/sh
kill -USR2 `cat /srv/websrv/config/php/log/php-fpm.pid`
