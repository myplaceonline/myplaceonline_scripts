#!/bin/sh
ssh root@web1.myplaceonline.com "cd /var/www/html/myplaceonline/; RAILS_ENV=production FTS_TARGET=db2-internal.myplaceonline.com:9200 bin/rails console"

