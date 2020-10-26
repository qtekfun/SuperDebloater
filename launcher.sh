#!/bin/sh

TIMENOW=`date +'%Y-%m-%d-%H%m%S'`
LOGFILE="./log_"$TIMENOW".txt"
DEVICE=$2
APPSFILE="./devices/"$DEVICE

echo "Welcome to the ADB debloater by Qtekfun"
echo "Sit down and wait for it to end"
echo "The log file is here:" $LOGFILE

case $1 in
	remove* )  echo "Removing apps ...";for file in `cat $APPSFILE`; do echo $file; adb shell pm uninstall -k --user 0 $file; done > $LOGFILE;;
	restore* ) echo "Restoring Apps ...";for file in `cat $APPSFILE`; do echo $file; adb shell cmd package install-existing $file; done > $LOGFILE;;
	* ) echo "Wrong argument";;
esac

while true; do
    read -p "Do you wish to disable heads up notifications?" yn
    case $yn in
        [Yy]* ) adb shell settings put global heads_up_notifications_enabled 0; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "Is recomended to reboot your phone right now" 
while true; do
    read -p "Do you wish to reboot your phone?" yn
    case $yn in
        [Yy]* ) adb reboot now; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo "Work Done!! Enjoy your freedom"
