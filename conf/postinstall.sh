#!/bin/bash
unset DEBCONF_REDIR
unset DEBCONF_FRONTEND
unset DEBIAN_HAS_FRONTEND
unset DEBIAN_FRONTEND

dialog --title "Postinstall" --infobox "Installing tools specific for this node..." 5 50

apt-get update
apt-get -y install \
    ant \
    bc \
    openjdk-6-jre-headless \
    openjdk-6-jdk \
    openjdk-7-jdk \
    build-essential \
    byobu \
    htop \
    cmake \
    git-core \
    libboost-all-dev \
    libncurses5 \
    libncurses5-dev \
    libncursesw5 \
    libstatistics-basic-perl \
    libstatistics-descriptive-perl \
    libgd-graph-perl \
    zlib1g \
    zlib1g:i386 \
    zlib1g-dev \
    ncurses-base \
    ncurses-bin \
    pkg-config \
    python-dev \
    python-pip \
    rsync \
    sshfs \
    tree \
    unzip \
    vim \
    vnstat \
    texlive-latex-base \
    texlive-latex-recommended >> /root/postinstall.log 2>&1

dialog --title "Postinstall" --infobox "Done installing, rebooting in a moment..." 5 50

# Create the mountpoint /data
mkdir -p /data
chmod 777 /data
cp /root/mountall.sh /data
chmod 755 /root/mountall.sh

echo benchmark > /etc/hostname

# Run firstboot.sh by rc.local on first boot.
sed -i 's_exit 0_sh /root/firstboot.sh_' /etc/rc.local >> /root/postinstall.log  2>&1;

# return exit code 0 (all of above actions where successfull)
exit 0
