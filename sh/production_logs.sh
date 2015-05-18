#!/bin/sh
LINES=10
ssh root@myplaceonline.com "echo /var/www/html/myplaceonline/log/*; tail -$LINES /var/www/html/myplaceonline/log/*; echo /var/log/nginx/access.log; tail -$LINES /var/log/nginx/access.log; echo /var/log/nginx/error.log; tail -$LINES /var/log/nginx/error.log; echo /opt/nginx-1.7.7/access.log; tail -$LINES /opt/nginx-1.7.7/access.log; echo /opt/nginx-1.7.7/nginx_error.log; tail -$LINES /opt/nginx-1.7.7/nginx_error.log; "
