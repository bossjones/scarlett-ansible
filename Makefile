.PHONY: list help

help:
	@echo "Convenience Make commands for provisioning a scarlett node"

list:
	@$(MAKE) -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$$)/ {split($$1,A,/ /);for(i in A)print A[i]}' | sort

vagrant-provision:
	VAGRANT_VAGRANTFILE=Vagrantfile-ansible-test vagrant provision

vagrant-up:
	VAGRANT_VAGRANTFILE=Vagrantfile-ansible-test vagrant up

vagrant-ssh:
	VAGRANT_VAGRANTFILE=Vagrantfile-ansible-test vagrant ssh

vagrant-destroy:
	VAGRANT_VAGRANTFILE=Vagrantfile-ansible-test vagrant destroy

vagrant-halt:
	VAGRANT_VAGRANTFILE=Vagrantfile-ansible-test vagrant halt

vagrant-config:
	VAGRANT_VAGRANTFILE=Vagrantfile-ansible-test vagrant ssh-config

serverspec-diff:
	cat serverspec_things_to_check_for.txt

serverspec:
	bundle exec rake

serverspec-install:
	bundle install --path .vendor
