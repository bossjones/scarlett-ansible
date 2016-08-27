#!/usr/bin/env ruby

require 'spec_helper'

python_version = '3.5'
python_version_major = '3'
gstreamer_version = '1.0'
user = 'pi'
user_home = "/home/#{user}"
language_id = '1473'
github_ranch = 'master'
github_repo_org = 'bossjones'
repo_name = 'scarlett_os'
venv_site_pkgs_folder = "/home/#{user}/.virtualenvs/#{repo_name}/lib/python#{python_version}/site-packages"
venv_site_pkgs_pocketsphinx_folder = "/home/#{user}/.virtualenvs/#{repo_name}/lib/python#{python_version}/site-packages/pocketsphinx"
venv_site_pkgs_sphinxbase_folder = "/home/#{user}/.virtualenvs/#{repo_name}/lib/python#{python_version}/site-packages/sphinxbase"
venv_lib_pkgconfig_folder = "/home/#{user}/.virtualenvs/#{repo_name}/lib/pkgconfig"
venv_lib_folder = "/home/#{user}/.virtualenvs/#{repo_name}/lib"
venv_lib_gstreamer_folder = "/home/#{user}/.virtualenvs/#{repo_name}/lib/gstreamer-#{gstreamer_version}"

setup_python = ['libpython2.7',
                "libpython#{python_version}",
                'python3',
                'python3-cairo-dev',
                'python3-coverage',
                'python3-dbus',
                'python3-dev',
                'python3-distutils-extra',
                'python3-gi',
                'python3-gi-cairo',
                'python-gobject',
                'python-gobject-dev',
                'python-gtk2',
                'python-iplib',
                'python-libxml2',
                'python-lxml',
                'python3-nose',
                'python3-numpy',
                'python3-numpy-dbg',
                'python3-pyside',
                'python3-scipy',
                'python-simplejson',
                'python2.7-dev',
                'python3.5-dev',
                'swig',
                'libffi-dev',
                'libssl-dev',
                'python-setuptools']

pip_freeze = ['ipython', 'numpy', 'pygobject', 'python-espeak', 'virtualenv', 'virtualenvwrapper']

setup_python.each do |x|
  describe 'setup_python' do
    it "installs #{x}" do
      expect(package(x)).to be_installed
    end
  end
end

describe 'python-osmgpsmap is installed', if: os[:release].to_i == 14 do
  it 'installs python-osmgpsmap' do
    expect(package('python-osmgpsmap')).to be_installed
  end
end

describe command('pip3 freeze'), sudo: false do
  pip_freeze.each do |x|
    its(:stdout) { should match /.*#{x}.*/ }
  end
end

describe '/home/pi/.pythonrc exists' do
  it '/home/pi/.pythonrc exists' do
    expect(file('/home/pi/.pythonrc')).to be_file
    expect(file('/home/pi/.pythonrc')).to be_mode('644')
  end
end
