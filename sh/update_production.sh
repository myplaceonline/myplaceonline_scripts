#!/bin/sh
KEYSLOADED=`ssh-add -l | grep -v "The agent has no identities." | wc -l`
if [ $KEYSLOADED -lt 1 ]; then
  ssh-add
fi
pushd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
pushd ../../myplaceonline_chefrepo
knife ssh -C 1 "chef_environment:production AND role:web_server" "chef-client --force-logger" --ssh-user root --identity-file ~/.ssh/id_rsa
popd
popd
