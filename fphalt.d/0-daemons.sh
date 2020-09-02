#!/bin/sh

kill_daemon() {
  if [ ! $(pidof $1 >/dev/null) ]; then
    kill -SIGINT $(pidof $1)
  fi
}

kill_daemon udhcpc
kill_daemon syslogd
