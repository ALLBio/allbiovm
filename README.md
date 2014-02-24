Allbio Virtual Machine installer
===

This is just a package to streamline the installation of the virtualmachines 
and/or cluster machines. ( custom installation disk of Ubuntu 12.04.3 LTS )

This package installs the nessecery packages needed for the AllbioTC2 
pipeline: 
    https://github.com/ALLBio/allbiotc2 

Instructions
---
1. First download Ubuntu from [ubuntu.com](http://nl.archive.ubuntu.com/ubuntu-cdimages/12.04.3/release/) (the alternate version)
2. Place the ISO image in this folder
3. Modify the create.sh to fit to your ISO image name
4. Run: `sudo bash create.sh`
5. The new branded ISO image will be ready in a few minutes.

To modify the bootscript and installation of other packages after first boot, check the file `conf/firstboot.sh` and `conf/postinstall.sh`.

Changing initial root password and initial user (+passwd)
---

In `conf/preseed.cfg`, the root user and its credentials can set in the following subsection:

```
d-i passwd/root-password-crypted $6$I8WJedWU$UkRom...Uyoj1
```

You can use the following to get an encrypted version of your password:

```$ python -c "import crypt, getpass, pwd; print crypt.crypt('somepassword', '\$6\$I8WJedWU\$')"```

Next to this section, you will find the setup for the first user of the system.

Virtualbox specific notes on creating addtional hard drive
---

In Virtualbox select the virtualmachine that was created using the custom ISO.

1. Make sure the VM is currently not running.
1. Open the settings screen with CTRL+S
1. Click 'Storage' and Add a new disk to the SATA controller.
1. In the question popup, select 'Create new disk'
1. Go through the virtual disk creation wizard.

After the disk creation, startup the VM and login as root.

Issue `blkid` on the commandline to see whether a new disk is added.
The disk without a `LABEL` and `TYPE` is the new disk. (in any case /dev/sda is never the new disk since this is the OS disk)

    $ fdisk /dev/sdb

    Command (m for help): n
    Partition type:
       p   primary (0 primary, 0 extended, 4 free)
       e   extended
    Select (default p): p
    Partition number (1-4, default 1): 1
    First sector (2048-209715199, default 2048): 
    Using default value 2048
    Last sector, +sectors or +size{K,M,G} (2048-209715199, default 209715199): 
    Using default value 209715199

Press `w` and `return` to write the changes to disk.

All what is left is to format the disk

    $ sudo mkfs.ext4 /dev/sdc1



Fork
---
This repository is based on previous (drafts) work on: https://github.com/wyleung/nebulae

Copyright
---

2013-2014 (c) Wai Yi Leung - SASC - Leiden University Medical Centre
