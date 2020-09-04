#!/bin/sh

# FIXME: Attempting to kill either busybox udhcpc or login causes system hang -- the former is a busybox bug most likely, but the latter I'm less sure of
# (Very similar behavior to https://superuser.com/questions/1204231/busybox-udhcpc-can-not-be-killed)

pkill -2 -v -f "init|script|sh|fphalt.d|udhcpc|login"
sleep 1
pkill -9 -v -f "init|script|sh|fphalt.d|udhcpc|login"
