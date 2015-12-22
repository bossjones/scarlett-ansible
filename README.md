# scarlett-ansible

# start vagrant server
VAGRANT_VAGRANTFILE=Vagrantfile-ansible-test vagrant up

# provision server
VAGRANT_VAGRANTFILE=Vagrantfile-ansible-test vagrant provision

### TODO

# files to modify
/etc/sudoers
/etc/sshd_config
/etc/ssh_config
/etc/ntp.conf


1. install build tools

2. install ppa packages
3. install latest git
4. install python + dependencies
5. create pi user if they don't exist + bash_profiles , authorized_keys etc + pi group
6. install bash_it
7. setup rbenv
8. install debug tools like lsof strace htop
9. install motd
11. install pulse audio + pulse audio configs
12. modify pi user to have audio access
13. install gstreamer*
14. setup dev directory structure for pi
15. install other dependencies ( huge list ) for everything gnome related, gtk3 etc
16. install virtualenv
17. mkvirtualenv scarlett-dbus
18. install virtualbox guest additions
19. install nodejs
20. clone all cmusphinx repos into /usr/local/src
21. chown pi:pi /usr/local/src/cmu*
22. git clone scarlett-dbus-poc
23. 
