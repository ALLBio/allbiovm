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



# Fix the git:// protocol to https:// (we are working behind firewall, git connection is not possible)
echo "Changing git config" 2>&1 >> ${SOFTWARE_DIR}/install.log
#git config --global url.https://github.com/.insteadOf git://github.com/ 2>&1 >> ${SOFTWARE_DIR}/install.log
(
cat <<'EOF'
[url "https://github.com/"]
	insteadOf = git://github.com/
EOF
) > /etc/gitconfig
git config --global -l 2>&1 >> ${SOFTWARE_DIR}/install.log



# get some software from github (of which don't have distributions in apt')
cd ${SOFTWARE_DIR}

# Boost C++ library
wget http://downloads.sourceforge.net/project/boost/boost/1.55.0/boost_1_55_0.tar.gz
tar -zxf boost_1_55_0.tar.gz
cd boost_1_55_0
sh bootstrap.sh
cd ${SOFTWARE_DIR}

# BWA
mkdir bwa
cd bwa
git clone https://github.com/lh3/bwa.git bwa-v0.7.5a
cd bwa-v0.7.5a
git checkout tags/0.7.5a
make 
ln -s `pwd`/bwa /usr/local/bin/bwa
cd ${SOFTWARE_DIR}

# FastQC
mkdir FastQC
cd FastQC
wget -O fastqc_v0.10.1.zip http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.10.1.zip
unzip *.zip
mv FastQC fastqc_v0.10.1
cd fastqc_v0.10.1
chmod 777 fastqc
cd ${SOFTWARE_DIR}



# HTSlib for samtools (latest version >=0.2.0)
git clone https://github.com/samtools/htslib.git
make -C htslib -f Makefile 2>&1 >> ${SOFTWARE_DIR}/install.log
make -C htslib -f Makefile install 2>&1 >> ${SOFTWARE_DIR}/install.log
cd ${SOFTWARE_DIR}

# Bamtools
git clone https://github.com/pezmaster31/bamtools.git
cd bamtools
mkdir build
cd build
cmake .. 2>&1 >> ${SOFTWARE_DIR}/install.log
make
cd ${SOFTWARE_DIR}

# Samtools
mkdir samtools
cd samtools
git clone https://github.com/samtools/samtools.git samtools-v0.1.19
cd samtools-v0.1.19
git checkout tags/0.1.19
make -f Makefile 2>&1 >> ${SOFTWARE_DIR}/install.log
ln -s `pwd`/samtools /usr/local/bin/samtools
cd ${SOFTWARE_DIR}

# Sickle trimming tool
mkdir -p sickle
cd sickle
git clone https://github.com/najoshi/sickle.git sickle-v1.2.1
cd sickle-v1.2.1
make 2>&1 >> ${SOFTWARE_DIR}/install.log
cd ${SOFTWARE_DIR}


# Pindel
#git clone https://github.com/genome/pindel.git
#make -C pindel -f Makefile SAMTOOLS=`pwd`/samtools
mkdir pindel
cd pindel
wget -O pindel.tar.gz https://github.com/genome/pindel/archive/v0.2.5.tar.gz
tar -xzf pindel.tar.gz
cd pindel-0.2.5
/bin/sh INSTALL ${SOFTWARE_DIR}/samtools/samtools-v0.1.19 2>&1 >> ${SOFTWARE_DIR}/install.log
cd ${SOFTWARE_DIR}

# Clever-sv
mkdir -p clever
cd clever
#git clone https://code.google.com/p/clever-sv/
#cd clever-sv
#cmake -DCMAKE_INSTALL_PREFIX=`pwd` . 2>&1 >> ${SOFTWARE_DIR}/install.log
#make 2>&1 >> ${SOFTWARE_DIR}/install.log
#make install 2>&1 >> ${SOFTWARE_DIR}/install.log

# the rc version
wget https://clever-sv.googlecode.com/files/clever-toolkit-v2.0rc3.tar.gz
tar -zxf clever-toolkit-v2.0rc3.tar.gz
cd clever-toolkit-v2.0rc3
cmake -DCMAKE_INSTALL_PREFIX=`pwd` . 2>&1 >> ${SOFTWARE_DIR}/install.log
make 2>&1 >> ${SOFTWARE_DIR}/install.log
make install 2>&1 >> ${SOFTWARE_DIR}/install.log
cd ${SOFTWARE_DIR}

# New version of Delly
#git clone https://github.com/tobiasrausch/delly.git
#make -C delly -f Makefile BOOST=${SOFTWARE_DIR}/boost BAMTOOLS=${SOFTWARE_DIR}/bamtools KSEQ=
mkdir delly
cd delly
mkdir delly-v0.2.2
wget -O delly-v0.2.2/delly_v0.2.2_parallel_linux_x86_64bit https://github.com/tobiasrausch/delly/releases/download/v0.2.2/delly_v0.2.2_parallel_linux_x86_64bit
wget -O delly-v0.2.2/delly_v0.2.2_linux_x86_64bit https://github.com/tobiasrausch/delly/releases/download/v0.2.2/delly_v0.2.2_linux_x86_64bit
chmod -R +x *
cd ${SOFTWARE_DIR}

# New version of Breakdancer
mkdir breakdancer
cd breakdancer
git clone --recursive https://github.com/genome/breakdancer.git breakdancer-v1.4.4
cd breakdancer-v1.4.4
git checkout tags/v1.4.4
mkdir -p build
mkdir -p bin
cd build
export SAMTOOLS_ROOT=${SOFTWARE_DIR}/samtools
cmake .. -DCMAKE_BUILD_TYPE=release -DCMAKE_INSTALL_PREFIX=..  2>&1 >> ${SOFTWARE_DIR}/install.log
make  2>&1 >> ${SOFTWARE_DIR}/install.log
make install  2>&1 >> ${SOFTWARE_DIR}/install.log
cd ${SOFTWARE_DIR}


# Install PRISM
mkdir prism
wget -O prism/PRISM_1_1_6.linux.x86_64.tar.gz http://compbio.cs.toronto.edu/prism/releases/PRISM_1_1_6.linux.x86_64.tar.gz
cd prism
tar -zxf PRISM_1_1_6.linux.x86_64.tar.gz
echo "export PRISM_PATH=`pwd`/PRISM_1_1_6" > /etc/profile.d/prism.sh
cd ${SOFTWARE_DIR}

# Install SVDetect
mkdir svdetect
cd svdetect
wget http://downloads.sourceforge.net/project/svdetect/SVDetect/0.80/SVDetect_r0.8b.tar.gz
tar -xzf *.tar.gz
cd ${SOFTWARE_DIR}

# Install GASV
mkdir gasv
cd gasv
wget https://gasv.googlecode.com/files/GASVRelease_Oct1_2013.tgz
tar -zxf *.tgz
mv gasv GASVRelease_Oct1_2013
cd GASVRelease_Oct1_2013
/bin/bash install >> ${SOFTWARE_DIR}/install.log
cd ${SOFTWARE_DIR}

# python libraries
pip install SciPy bitarray


# change the rc.local to default
sed -i 's_sh /root/firstboot.sh_exit 0_' /etc/rc.local

# return exit code 0 (all of above actions where successfull)
exit 0
