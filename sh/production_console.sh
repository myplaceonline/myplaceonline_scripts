#!/bin/sh
ssh root@web1.myplaceonline.com "cd /var/www/html/myplaceonline/; RAILS_ENV=production bin/rails console"

