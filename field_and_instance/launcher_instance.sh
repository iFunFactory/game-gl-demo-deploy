#!/bin/bash -ex

if [ ! -d "/home/gl-user-server/.aws" ]
then
  mkdir /home/gl-user-server/.aws
  cp /local/game/config /home/gl-user-server/.aws/
  cp /local/game/credentials /home/gl-user-server/.aws/
fi

export GAME_LOG_ROOT_DIR=/local/game/logs
export GAME_CRASHDUMP_ROOT_DIR=/local/game/crash

mkdir -p ${GAME_LOG_ROOT_DIR} \
    ${GAME_LOG_ROOT_DIR}/glog \
    ${GAME_LOG_ROOT_DIR}/activity \

mkdir -p ${GAME_CRASHDUMP_ROOT_DIR}

touch /local/game/logs/serverOut.log
touch /local/game/logs/serverErr.log

exec /usr/bin/gamelift_demo.instance-launcher
