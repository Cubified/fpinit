#!/bin/sh

pkill SIGTERM -v -s0
pkill SIGTERM -v -s1
sleep 1
pkill SIGKILL -v -s0
pkill SIGKILL -v -s1
