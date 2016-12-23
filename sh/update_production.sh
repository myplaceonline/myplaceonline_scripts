#!/bin/sh
KEYSLOADED=`ssh-add -l | grep -v "The agent has no identities." | wc -l`
if [ $KEYSLOADED -lt 1 ]; then
  ssh-add
fi
pushd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
pushd ../../myplaceonline_posixcubes
../../../posixcube/posixcube.sh -u root -h web*.myplaceonline.com -o "cubevar_app_web_servers=web*" -c core_begin -c web -c core_end
popd
popd
