#!/usr/bin/env bash -x

_USER=pi
_SSH_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD5vn4kcMAOotNa86ghSjKNyGN+6aRO33ji5drpMSjKEXcRCsHPT03gSlTvZC7L1kaeV65Bujduwyj/Wgf/LDi9MrUsYDF4xHwz5ppAj/elbj+J5BbQLZXGO0peumI3T10woLae9tsdwj76Yx1qU9jCT6Ykn1afsxGKpKzLht+vJccyTnQ2HRyCFc/HT7McfHGXSHGpFKThZsU8mAliBb9delY3j3RJd7+0GlCfSenj53pwKSlmVZYzlPUHKZ1C/cNzW7pkVoUdALZ79WE7nHkN8Rv5UK5ygCrzxueYIeyHqV3vMJgO/ipo4cfQ3x5sphCQxviWcQHr+xOrzkve8aO3G0EIxZfaA1GkTqHjik0ApJ9/dCOz+1z6nOlr59cPq7ksv/QNpQMSTgx2DnopvPsS3enEBNZmA9yhvczgcmbSISS3U+szhPzS1E3J+F9aLeGTqZZr7BPAL+eWM4dAzBJUsgsitswjBbSw41H8DTJ4yeSz4hslB68Bha/Fxc4dzfPsd908gOMHPK7oHY6PpqMGu4ZNUQxd0giD91VwMl1lIcEln3Q9o6ooqPVXSHMbC8VIzJron+di2at9ykURzMHlmymZrUCUzVFSUdt7VtGRs9Y5OLjk2Pt9iuQhcT/8hIMGNAO3EU808T9GUMSvZmODWydfhYR91dOvOlbjmFIT5Q== malcolm@adobe.com github ssh-key 12-1-2015"
_PASS=raspberry

apt-get  update -y && \
apt-get  install -y git && \
apt-get  install -y build-essential libssl-dev libreadline-dev wget curl openssh-server && \
apt-get  install -y gcc make linux-headers-$(uname -r) && \
apt-get  install -y ca-certificates bash && \
apt-get  install -y python-setuptools perl pkg-config software-properties-common python python-pip python-dev && \
easy_install --upgrade pip && easy_install --upgrade setuptools && \
add-apt-repository ppa:git-core/ppa -y && apt-get update && apt-get install -yqq git && \
apt-get update && \
apt-get upgrade -y && \
apt-get install -y lsof strace && \
apt -y update && apt-get -y upgrade && \
apt -y install software-properties-common && \
apt-add-repository ppa:ansible/ansible && \
apt -y update && \
apt -y install ansible && \
apt-get -y install openssh-server cryptsetup build-essential libssl-dev libreadline-dev zlib1g-dev linux-source dkms nfs-common zip unzip tree screen vim ntp vim-nox


echo "-- Add public key to pi user..."
homedir=/home/${_USER}
mkdir -p $homedir/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD5vn4kcMAOotNa86ghSjKNyGN+6aRO33ji5drpMSjKEXcRCsHPT03gSlTvZC7L1kaeV65Bujduwyj/Wgf/LDi9MrUsYDF4xHwz5ppAj/elbj+J5BbQLZXGO0peumI3T10woLae9tsdwj76Yx1qU9jCT6Ykn1afsxGKpKzLht+vJccyTnQ2HRyCFc/HT7McfHGXSHGpFKThZsU8mAliBb9delY3j3RJd7+0GlCfSenj53pwKSlmVZYzlPUHKZ1C/cNzW7pkVoUdALZ79WE7nHkN8Rv5UK5ygCrzxueYIeyHqV3vMJgO/ipo4cfQ3x5sphCQxviWcQHr+xOrzkve8aO3G0EIxZfaA1GkTqHjik0ApJ9/dCOz+1z6nOlr59cPq7ksv/QNpQMSTgx2DnopvPsS3enEBNZmA9yhvczgcmbSISS3U+szhPzS1E3J+F9aLeGTqZZr7BPAL+eWM4dAzBJUsgsitswjBbSw41H8DTJ4yeSz4hslB68Bha/Fxc4dzfPsd908gOMHPK7oHY6PpqMGu4ZNUQxd0giD91VwMl1lIcEln3Q9o6ooqPVXSHMbC8VIzJron+di2at9ykURzMHlmymZrUCUzVFSUdt7VtGRs9Y5OLjk2Pt9iuQhcT/8hIMGNAO3EU808T9GUMSvZmODWydfhYR91dOvOlbjmFIT5Q== malcolm@adobe.com github ssh-key 12-1-2015" >> $homedir/.ssh/authorized_keys
chown -Rf ${_USER} $homedir/.ssh
chmod 700 $homedir/.ssh
chmod 600 $homedir/.ssh/authorized_keys

echo "${_USER}"|passwd --stdin ${_PASS}
echo "${_USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/${_USER}
chmod 0440 /etc/sudoers.d/${_USER}

# source: https://github.com/geekduck/packer-templates/blob/76fb94e4161cd21a30047205c77cefeb4b881f8d/Ubuntu16.04/scripts/base.sh
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=sudo' /etc/sudoers
sed -i -e 's/%sudo ALL=(ALL:ALL) ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

echo "UseDNS no" >> /etc/ssh/sshd_config

date > /etc/vagrant_box_build_time

# cleanup
# source: https://github.com/geekduck/packer-templates/blob/76fb94e4161cd21a30047205c77cefeb4b881f8d/Ubuntu16.04/scripts/cleanup.sh

apt-get -y autoremove
apt-get -y clean

echo "cleaning up gest additions"
rm -rf VBoxGuestAdditions*.iso VBoxGuestAdditions*.iso.?

echo "cleaning up dhcp leases"
rm /var/lib/dhcp/*
#echo "cleaning up udev rules"
#rm /etc/udev/rules.d/70-persistent-net.rules
#mkdir /etc/udev/rules.d/70-persistent-net.rules
#rm -rf /dev/.udev/
#rm /lib/udev/rules.d/75-persistent-net-generator.rules


# zerodisk
dd if=/dev/zero of=/EMPTY bs=1M
sleep 5
rm -f /EMPTY

sync
sync
sync
exit 0
