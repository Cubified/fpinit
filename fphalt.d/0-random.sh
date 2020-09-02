#!/bin/sh

RANDOM_SEED=/var/lib/misc/random-seed
POOL_FILE=/proc/sys/kernel/random/poolsize

touch $RANDOM_SEED
chmod 600 $RANDOM_SEED
[ -r $POOL_FILE ] && POOL_SIZE=$(cat $POOL_FILE) || POOL_SIZE=512
dd if=/dev/urandom of=$RANDOM_SEED count=1 bs=$POOL_SIZE &>/dev/null
