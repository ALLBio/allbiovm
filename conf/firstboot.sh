#!/bin/bash
dialog --title "Configuring custom installation" --infobox " for Allbio..." 5 50

mkdir -p /opt/allbio
chmod 777 /opt

cd /opt/allbio
git clone https://github.com/ALLBio/allbiotc2.git 
mkdir -p /opt/allbio/software
mkdir -p /opt/allbio/runs
mkdir -p /opt/allbio/data
mkdir -p /opt/allbio/input

# get some software from the web
cd /opt/allbio/software

git clone https://github.com/samtools/samtools.git
make -f samtools/Makefile install

git clone https://github.com/genome/pindel.git
make -f pindel/Makefile

# change the rc.local to default
sed -i 's_sh /root/firstboot.sh_exit 0_' /etc/rc.local

# return exit code 0 (all of above actions where successfull)
exit 0
