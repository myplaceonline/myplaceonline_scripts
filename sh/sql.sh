#!/bin/sh
ssh root@myplaceonline.com "cat /root/myplaceonline.json" | grep -A 8 "\"postgresql\": {" | grep "\"myplaceonline\": "
ssh root@myplaceonline.com "psql -h localhost myplaceonline_production myplaceonline -c \"$1\""
