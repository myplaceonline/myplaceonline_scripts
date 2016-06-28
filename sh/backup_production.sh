#!/bin/sh
PSQL_USER_PASSWORD=`ssh root@web1.myplaceonline.com "grep password: /var/www/html/myplaceonline/config/database.yml | sed 's/.*password: //g'"`

echo -n "Encrypted file password: "
read -s ENCRYPTED_FILE_PASSWORD
echo
echo -n "Repeat Encrypted file password: "
read -s ENCRYPTED_FILE_PASSWORD2
echo
if [ "${ENCRYPTED_FILE_PASSWORD}" != "${ENCRYPTED_FILE_PASSWORD2}" ]; then
  echo "Passwords don't match! Exiting"
  exit 1
fi
read -e -p "Local output directory: " OUTPUTDIR

# Write to the root directory because /tmp is limited in some clouds
OUTPUTFILE=/pgdump_myplaceonline_`date +"%Y%m%d_%H%M"`.sql
LARGEFILES=/largefiles_myplaceonline_`date +"%Y%m%d_%H%M"`.tar.gz
LOCALIP=`ssh root@db2.myplaceonline.com "ifconfig eth1 | grep 'inet ' | sed 's/.*inet //g' | sed 's/ .*//g'"`

ssh root@db2.myplaceonline.com "sudo -i -u postgres psql myplaceonline_production -c 'select pg_xlog_replay_pause();' && sudo -i -u postgres psql myplaceonline_production -c 'select  pg_is_xlog_replay_paused();' && PGPASSWORD=${PSQL_USER_PASSWORD} /usr/bin/pg_dump -U myplaceonline -h ${LOCALIP} -d myplaceonline_production -Fc > ${OUTPUTFILE} && sudo -i -u postgres psql myplaceonline_production -c 'select pg_xlog_replay_resume();'  && echo '${ENCRYPTED_FILE_PASSWORD}' | /usr/bin/gpg --batch --no-tty --passphrase-fd 0 --s2k-mode 3 --s2k-count 65536 --force-mdc --cipher-algo AES256 --s2k-digest-algo sha512 -o ${OUTPUTFILE}.pgp --symmetric ${OUTPUTFILE}; rm ${OUTPUTFILE}" && \
scp root@db2.myplaceonline.com:${OUTPUTFILE}.pgp ${OUTPUTDIR} && \
ssh root@db2.myplaceonline.com "rm -f ${OUTPUTFILE}.pgp" && \
ssh root@db2.myplaceonline.com "tar czvf ${LARGEFILES} /var/lib/remotenfs_backup/ && echo '${ENCRYPTED_FILE_PASSWORD}' | /usr/bin/gpg --batch --no-tty --passphrase-fd 0 --s2k-mode 3 --s2k-count 65536 --force-mdc --cipher-algo AES256 --s2k-digest-algo sha512 -o ${LARGEFILES}.pgp --symmetric ${LARGEFILES}; rm ${LARGEFILES}" &&
scp root@db2.myplaceonline.com:${LARGEFILES}.pgp ${OUTPUTDIR} && \
ssh root@db2.myplaceonline.com "rm -f ${LARGEFILES}.pgp" && \

echo "Done"
