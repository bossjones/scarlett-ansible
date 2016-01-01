#!/usr/bin/env ruby

require 'spec_helper'

setup_python = ["libpython2.7",
               "libpython3.4",
               "python",
               "python-cairo-dev",
               "python-coverage",
               "python-dbus",
               "python-dbus-dev",
               "python-dev",
               "python-distutils-extra",
               "python-gi",
               "python-gi-cairo",
               "python-gi-dev",
               "python-gobject",
               "python-gobject-dev",
               "python-gtk2",
               "python-iplib",
               "python-libxml2",
               "python-lxml",
               "python-nose",
               "python-numpy",
               "python-numpy-dbg",
               "python-osmgpsmap",
               "python-pyside",
               "python-scipy",
               "python-simplejson",
               "python2.7-dev",
               "swig",
               "libffi-dev",
               "libssl-dev",
               "python-setuptools"]

pip_freeze = ['ipython', 'numpy', 'pygobject', 'python-espeak', 'virtualenv', 'virtualenvwrapper']

setup_python.each { |x|
  describe 'setup_python' do
    it "installs #{x}" do
      expect(package x).to be_installed
    end
  end
}

describe command('pip freeze'), :sudo => false do
  pip_freeze.each { |x|
      its(:stdout) { should match /.*#{x}.*/ }
  }
end
