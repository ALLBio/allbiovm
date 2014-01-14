#!/bin/bash
dialog --title "Configuring custom installation" --infobox "NGS data analysis ready system..." 5 50


# Allbio specific directory setup
mkdir -p /opt/allbio
chmod 777 /opt

CHROOT=/opt/allbio
SOFTWARE_DIR=${CHROOT}/software

cd ${CHROOT}
git clone https://github.com/ALLBio/allbiotc2.git 
mkdir -p ${SOFTWARE_DIR}
mkdir -p ${CHROOT}/runs
mkdir -p ${CHROOT}/data
mkdir -p ${CHROOT}/input




# get some software from github (of which don't have distributions in apt')
cd ${SOFTWARE_DIR}

wget http://downloads.sourceforge.net/project/boost/boost/1.55.0/boost_1_55_0.tar.gz
tar -zxf boost_1_55_0.tar.gz
cd boost_1_55_0
sh bootstrap.sh
cd ${SOFTWARE_DIR}

# HTSlib for samtools (latest version >=0.2.0)
git clone https://github.com/samtools/htslib.git
make -C htslib -f Makefile
make -C htslib -f Makefile install
cd ${SOFTWARE_DIR}

# Bamtools
git clone https://github.com/pezmaster31/bamtools.git
cd bamtools
mkdir build
cd build
cmake ..
make
cd ${SOFTWARE_DIR}

# Samtools
git clone https://github.com/samtools/samtools.git
cd samtools
git checkout tags/0.1.19
cd ${SOFTWARE_DIR}
make -C samtools -f Makefile
cd ${SOFTWARE_DIR}

# Pindel
#git clone https://github.com/genome/pindel.git
#make -C pindel -f Makefile SAMTOOLS=`pwd`/samtools
wget -O pindel.tar.gz https://github.com/genome/pindel/archive/v0.2.5.tar.gz
tar -xzf pindel.tar.gz
mv pindel-0.2.5 pindel
cd pindel
/bin/bash INSTALL `pwd`/samtools
cd ${SOFTWARE_DIR}

# Clever-sv
git clone https://code.google.com/p/clever-sv/
cd clever-sv
cmake -DCMAKE_INSTALL_PREFIX=`pwd` .
make
make install
cd ${SOFTWARE_DIR}

# New version of Delly
#git clone https://github.com/tobiasrausch/delly.git
#make -C delly -f Makefile BOOST=${SOFTWARE_DIR}/boost BAMTOOLS=${SOFTWARE_DIR}/bamtools KSEQ=
mkdir delly
#wget -O delly/delly_v0.2.2_parallel_linux_x86_64bit https://github.com/tobiasrausch/delly/releases/download/v0.2.2/delly_v0.2.2_parallel_linux_x86_64bit
wget -O delly/delly_v0.2.2_linux_x86_64bit https://github.com/tobiasrausch/delly/releases/download/v0.2.2/delly_v0.2.2_linux_x86_64bit
chmod +x delly/*
cd ${SOFTWARE_DIR}










# change the rc.local to default
sed -i 's_sh /root/firstboot.sh_exit 0_' /etc/rc.local

# return exit code 0 (all of above actions where successfull)
exit 0
