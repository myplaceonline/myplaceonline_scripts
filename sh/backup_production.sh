#!/bin/sh
ssh root@myplaceonline.com "cat /root/myplaceonline.json" | grep -A 8 "\"postgresql\": {" | grep "\"myplaceonline\": "
echo -n "psql myplaceonline user password: "
read -s PSQL_USER_PASSWORD
echo
echo -n "Encrypted file password: "
read -s ENCRYPTED_FILE_PASSWORD
echo
read -e -p "Local output directory: " OUTPUTDIR
OUTPUTFILE=/tmp/pgdump_myplaceonline_`date +"%Y%m%d_%H%M"`.sql
ssh root@myplaceonline.com "PGPASSWORD=${PSQL_USER_PASSWORD} /usr/bin/pg_dump -U myplaceonline -h localhost -d myplaceonline_production > ${OUTPUTFILE} && echo '${ENCRYPTED_FILE_PASSWORD}' | /usr/bin/gpg --batch --no-tty --passphrase-fd 0 --s2k-mode 3 --s2k-count 65536 --force-mdc --cipher-algo AES256 --s2k-digest-algo sha512 -o ${OUTPUTFILE}.pgp --symmetric ${OUTPUTFILE}; rm ${OUTPUTFILE}" && \
scp root@myplaceonline.com:${OUTPUTFILE}.pgp ${OUTPUTDIR} && \
ssh root@myplaceonline.com "rm -f ${OUTPUTFILE}.pgp"
