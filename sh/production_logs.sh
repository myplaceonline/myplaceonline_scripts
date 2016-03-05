#!/bin/sh
clear
LINES=$1
if [[ -z "$LINES" ]]; then
  LINES=10
fi
ssh root@myplaceonline.com "echo ''; echo ''; echo `date`; echo `date -u`; tail -n $LINES /var/www/html/myplaceonline/log/*`date +'%Y-%m-%d'`*log; echo ''; echo /var/log/nginx/access.log; echo '=============='; echo ''; tail -$LINES /var/log/nginx/access.log; echo ''; echo /var/log/nginx/error.log; echo '=============='; echo ''; tail -$LINES /var/log/nginx/error.log; echo ''; echo /opt/nginx-1.7.7/access.log; echo '=============='; echo ''; tail -$LINES /opt/nginx-1.7.7/access.log; echo ''; echo /opt/nginx-1.7.7/nginx_error.log; echo '=============='; echo ''; tail -$LINES /opt/nginx-1.7.7/nginx_error.log;"
