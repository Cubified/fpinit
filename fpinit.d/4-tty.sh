#!/bin/sh

GETTY="getty"
NOCLEAR=""

if [ ! -e "/sbin/$GETTY" ]; then
  GETTY="agetty"
  NOCLEAR="--noclear"
fi

bash -c "(while kill -0 $(pidof script) 2> /dev/null; do usleep 500000; done; /sbin/$GETTY $NOCLEAR /dev/tty1 38400 linux) & disown"
bash -c "/sbin/$GETTY /dev/tty2 38400 linux & disown"
bash -c "/sbin/$GETTY /dev/tty3 38400 linux & disown"
