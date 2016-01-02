#!/usr/bin/env ruby

require 'spec_helper'

buildessential_packages = ["autoconf",
                           "binutils-doc",
                           "bison",
                           "build-essential",
                           "flex",
                           "gettext",
                           "ncurses-dev",
                           "automake",
                           "bison",
                           "libtool",
                           "pkg-config",
                           "autopoint",
                           "autotools-dev",
                           "itstool",
                           "yasm",
                           "flex",
                           "bison",
                           "g++",
                           "autopoint",
                           "ragel",
                           "dh-autoreconf",
                           "anjuta",
                           "libssl-dev",
                           "libreadline-dev",
                           "wget",
                           "apt-transport-https",
                           "curl",
                           "openssl",
                           "perl",
                           "dkms"]

buildessential_packages.each { |x|
  describe 'buildessential_packages' do
    it "installs #{x}" do
      expect(package x).to be_installed
    end
  end
}
