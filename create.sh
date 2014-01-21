#!/bin/bash

TS=`date +%Y%m%d`

./scripts/create.sh -i $1
mv custom-ubuntu.iso custom-ubuntu-$TS.iso 
sudo chmod 777 custom-ubuntu-$TS.iso 

