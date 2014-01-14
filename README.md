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

````$ python -c "import crypt, getpass, pwd; print crypt.crypt('somepassword', '\$6\$I8WJedWU\$')"```

Next to this section, you will find the setup for the first user of the system.

Fork
---
This repository is based on previous (drafts) work on: 
    https://github.com/wyleung/nebulae

Copyright
---

2013-2014 (c) Wai Yi Leung - SASC - Leiden University Medical Centre