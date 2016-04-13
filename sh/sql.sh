#!/bin/sh
PSQL_USER_PASSWORD=`ssh root@web1.myplaceonline.com "grep password: /var/www/html/myplaceonline/config/database.yml | sed 's/.*password: //g'"`
LOCALIP=`ssh root@db2.myplaceonline.com "ifconfig eth1 | grep 'inet ' | sed 's/.*inet //g' | sed 's/ .*//g'"`
ssh root@db2.myplaceonline.com "PGPASSWORD=${PSQL_USER_PASSWORD} psql -U myplaceonline -h ${LOCALIP} -d myplaceonline_production -c \"$1\""
