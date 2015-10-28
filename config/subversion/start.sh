#!/bin/sh
/srv/websrv/program/subversion/bin/svnserve -d --listen-port 6868 -r /srv/websrv/config/subversion/data --log-file=/srv/websrv/tmp/subversion.log --pid-file=/srv/websrv/tmp/subversion.pid
