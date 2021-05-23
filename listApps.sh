#!/bin/sh

adb shell pm list packages | awk -F':' '{print $2}'
