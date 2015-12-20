#!/bin/sh
set -x
if [ $# -eq 0 ]; then
  echo "Please specify commit message"
  exit 1
fi
KEYSLOADED=`ssh-add -l | grep -v "The agent has no identities." | wc -l`
if [ $KEYSLOADED -lt 1 ]; then
  ssh-add
fi
echo "$@"
git status && \
git add . && \
git commit -m "$*"
git push
PARENTDIR=`dirname ${PWD}`
while [ `basename $PARENTDIR` != "src" ]; do
  PARENTDIR=`dirname ${PARENTDIR}`
done
pushd "$PARENTDIR"
git commit -a -m "Update submodules" && \
git push
popd
