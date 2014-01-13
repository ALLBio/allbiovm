#!/bin/bash

TS=`date +%Y%m%d`

./scripts/create.sh -i ubuntu-12.04.3-alternate-amd64+mac.iso
mv custom-ubuntu.iso custom-ubuntu-$TS.iso 
sudo chmod 777 custom-ubuntu-$TS.iso 

