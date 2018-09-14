#!/bin/bash

# stop on errors
set -e

# fake syslog
socat UNIX-RECV:/dev/log,mode=666 STDOUT &

# start and stop postfix first through init.d to populate
# postfix spool directory for chroot in which postfix is running
/usr/sbin/postfix -c /etc/postfix start > /dev/null 2>&1
/usr/sbin/postfix -c /etc/postfix abort > /dev/null 2>&1

# run additional scripts
for f in /docker-entrypoint-init.d/*
do
	[ -f $f ] && source $f
done

# create aliases
newaliases

exec /usr/sbin/postfix "$1"