#!/bin/bash
unset DEBCONF_REDIR
unset DEBCONF_FRONTEND
unset DEBIAN_HAS_FRONTEND
unset DEBIAN_FRONTEND

dialog --title "Postinstall" --infobox "Installing tools specific for this node..." 5 50

apt-get update
apt-get -y install \
    build-essential \
    byobu \
    cmake \
    git-core \
    libboost-all-dev \
    libncurses5 \
    libncurses5-dev \
    libncursesw5 \
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
    vim \
    vnstat \
    texlive-latex-base \
    texlive-latex-recommended >> /root/postinstall.log 2>&1

dialog --title "Postinstall" --infobox "Done installing, rebooting in a moment..." 5 50

# Run firstboot.sh by rc.local on first boot.
sed -i 's_exit 0_sh /root/firstboot.sh_' /etc/rc.local >> /root/postinstall.log  2>&1;

# return exit code 0 (all of above actions where successfull)
exit 0