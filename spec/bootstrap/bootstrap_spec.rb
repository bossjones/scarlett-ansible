#!/usr/bin/env ruby

require 'spec_helper'

openssh_packages = ['openssh-server']
general_prereqs  = ['libssl-dev', 'libreadline-dev', 'wget', 'curl', 'gcc', 'make', 'ca-certificates', 'bash', 'lsof', 'strace', 'nmap', 'htop', 'vim', 'openssl']
python_prereqs   = ['python-setuptools', 'perl', 'software-properties-common', 'python', 'python-dev']
helpful_prereqs  = ['nmap', 'screen', 'whois', 'bzr', 'unzip']
server_packages  = ['aptitude', 'autoconf', 'automake', 'binutils-doc', 'bison', 'build-essential', 'bzr', 'coreutils', 'curl', 'debconf-utils', 'fail2ban', 'flex', 'g++', 'git-core', 'help2man', 'libbz2-dev', 'libc6', 'libcurl4-openssl-dev', 'libevent-dev', 'libmcrypt-dev', 'libncurses5-dev', 'libpcre3', 'libpcre3-dev', 'libpcrecpp0', 'libreadline5', 'libssl-dev', 'libssl1.0.0', 'libtool', 'libxml2', 'libxml2-dev', 'libxslt1-dev', 'libxslt1.1', 'mercurial', 'patch', 'python-dev', 'python-numpy', 'screen', 'software-properties-common', 'ssl-cert', 'subversion', 'sudo', 'swig', 'unattended-upgrades', 'unrar-free', 'unzip', 'uuid-dev', 'uuid-runtime', 'vim-nox', 'wget', 'zlib1g', 'zlib1g-dev', 'zlibc', 'whois']

openssh_packages.each { |x|
  describe 'openssh_packages' do
    it "installs #{x}" do
      expect(package x).to be_installed
    end
  end
}

general_prereqs.each { |x|
  describe 'general_prereqs' do
    it "installs #{x}" do
      expect(package x).to be_installed
    end
  end
}

python_prereqs.each { |x|
  describe 'python_prereqs' do
    it "installs #{x}" do
      expect(package x).to be_installed
    end
  end
}

helpful_prereqs.each { |x|
  describe 'helpful_prereqs' do
    it "installs #{x}" do
      expect(package x).to be_installed
    end
  end
}

server_packages.each { |x|
  describe 'server_packages' do
    it "installs #{x}" do
      expect(package x).to be_installed
    end
  end
}

describe 'ppa:git-core/ppa installed' do
  it "has ppa:git-core/ppa" do
    expect(ppa('git-core/ppa')).to exist
  end
end

describe 'locales set correctly' do
  it 'export LC_CTYPE=en_US.UTF-8 and export LC_ALL=en_US.UTF-8 exists in /etc/profile.d/locales.sh' do
    expect(file('/etc/profile.d/locales.sh').content).to match(/^export LC_CTYPE=en_US.UTF-8/)
    expect(file('/etc/profile.d/locales.sh').content).to match(/^export LC_ALL=en_US.UTF-8/)
  end
end

describe command('dpkg --print-architecture') do
  its(:stdout) { should match /.*amd64.*/ }
end

describe command('dpkg --print-architecture') do
  its(:stdout) { should_not match /.*i386.*/ }
end
