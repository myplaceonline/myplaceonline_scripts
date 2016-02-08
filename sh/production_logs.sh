#!/bin/sh
clear
LINES=10
ssh root@myplaceonline.com "echo /var/www/html/myplaceonline/log/*; echo "=============="; echo ""; tail -$LINES /var/www/html/myplaceonline/log/*; echo ""; echo /var/log/nginx/access.log; echo "=============="; echo ""; tail -$LINES /var/log/nginx/access.log; echo ""; echo /var/log/nginx/error.log; echo "=============="; echo ""; tail -$LINES /var/log/nginx/error.log; echo ""; echo /opt/nginx-1.7.7/access.log; echo "=============="; echo ""; tail -$LINES /opt/nginx-1.7.7/access.log; echo ""; echo /opt/nginx-1.7.7/nginx_error.log; echo "=============="; echo ""; tail -$LINES /opt/nginx-1.7.7/nginx_error.log;"
