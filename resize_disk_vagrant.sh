#!/usr/bin/env bash
# To make this 55GB ubuntu/trusty64 VM I did the following:

set -e
set -u
set -x

CD_TO=~/dev/bossjones/scarlett-ansible
USERDIR=$PWD
VDMK_FILE=packer-ubuntu-16.04-amd64-disk1.vmdk
VAGRANT_VMNAME=scarlett-base-16-04
VDI_FILENAME=scarlett_50gb.vdi
if [ -e $PWD/$VAGRANT_VMNAME ]; then
    echo >&2 "$PWD/$VAGRANT_VMNAME exists!"
    echo >&2 "Please remove it and re-run to use this script."
    exit 1
fi

cd $CD_TO
VMNAME=$(grep "  vb.name" Vagrantfile | cut -d\' -f2)
VM_PATH="$HOME/VirtualBox VMs/$VMNAME"

# echo "Making temp directory /tmp/$VAGRANT_VMNAME"
# mkdir -p /tmp/$VAGRANT_VMNAME
# trap "cd $HOME/VirtualBox VMs/; rm -Rf $HOME/VirtualBox VMs/$VMNAME; exit" INT TERM EXIT
trap "cd $HOME/VirtualBox VMs/; ls -lta $HOME/VirtualBox VMs/$VMNAME; exit" INT TERM EXIT
# cd /tmp/$VAGRANT_VMNAME
# echo "Initializing vagrant box ubuntu/trusty64"
# vagrant init ubuntu/trusty64 > /dev/null
# vagrantfile_backup=$(mktemp Vagrantfile.XXXXXXX.tmp)
# awk '{ print $0 }; /config.vm.box / { print "  config.ssh.insert_key = false"}' Vagrantfile > $vagrantfile_backup
# cat $vagrantfile_backup > Vagrantfile
# rm $vagrantfile_backup
vagrant_up_outfile=$PWD/scarlett-ansible-1604-packer2.log
echo "Starting vagrant box bossjones/scarlett-ansible to initialize the VirtualBox VM"
vagrant up --no-provision | tee $vagrant_up_outfile
trap "cd $PWD; vagrant destroy -f; exit" INT TERM EXIT
echo "Terminating vagrant box bossjones/scarlett-ansible"
vagrant halt
# VMNAME=$(grep "  vb.name" Vagrantfile | cut -d\' -f2)
# VM_PATH="$HOME/VirtualBox VMs/$VMNAME"
cd "$VM_PATH"
echo "Inside Path: $VM_PATH"
ls -lta
echo "Cloning virtual disk to VDI format so we can resize it."
VBoxManage clonehd $VDMK_FILE ${VDI_FILENAME} --format VDI
echo "Resizing VDI disk to 55GB"
VBoxManage modifyhd ${VDI_FILENAME} --resizebyte 59055800320
echo "Converting VDI disk back to VMDK format"
VBoxManage clonehd ${VDI_FILENAME} box-disk1_50gb.vmdk --format VMDK
echo "Removing intermediate VDI disk"
rm ${VDI_FILENAME}
echo "Detaching old VMDK disk from the VM and removing it"
VBoxManage storageattach $VMNAME --storagectl "SATA Controller" --port 0 --medium none
rm $VDMK_FILE
echo "Attaching the new 55GB VMDK to the VM"
VBoxManage storageattach $VMNAME --storagectl "SATA Controller" --port 0 --medium "$VM_PATH/box-disk1_50gb.vmdk" --type hdd
cd $PWD
echo "Packaging up the VM back into a Vagrant box file"
vagrant package --base $VMNAME --output $USERDIR/${VAGRANT_VMNAME}.box

# Note that after this, you will end up with some media files that are registered but "inaccessible" -- notably the '${VDI_FILENAME}' and 'box-disk1.vmdk' from the original VM.
