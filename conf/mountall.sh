#!/usr/bin/env bash
# @author: Wai Yi Leung
# @contact: w.y.leung@lumc.nl
# let us mount all "*_storage" drives
DRIVES=`blkid | egrep _storage | egrep -o '\w+_storage'`;
for drive in $DRIVES;
do
    MOUNTNAME=`basename $drive _storage`;
    echo $MOUNTNAME;
    echo mkdir -p /data/$MOUNTNAME;
    echo mount -L $drive /data/$MOUNTNAME;
    mkdir -p /data/$MOUNTNAME;
    mount -L $drive /data/$MOUNTNAME;
done
