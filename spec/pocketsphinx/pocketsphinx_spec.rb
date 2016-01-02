#!/usr/bin/env ruby

require 'spec_helper'

venv_site_pkgs_folder = '/home/pi/.virtualenvs/scarlett-dbus-poc/lib/python2.7/site-packages'
venv_site_pkgs_pocketsphinx_folder='/home/pi/.virtualenvs/scarlett-dbus-poc/lib/python2.7/site-packages/pocketsphinx'

describe 'pocketsphinx_setup' do
  it 'creates /home/pi/dev/bossjones-github/scarlett-dbus-poc/sphinxbase' do
    expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/sphinxbase').to be_directory
    expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/sphinxbase').to be_mode('755')
    expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/sphinxbase').to be_owned_by 'pi'
    expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/sphinxbase').to be_grouped_into 'pi'
  end

  it 'creates /home/pi/dev/bossjones-github/scarlett-dbus-poc/pocketsphinx' do
    expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/pocketsphinx').to be_directory
    expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/pocketsphinx').to be_mode('755')
    expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/pocketsphinx').to be_owned_by 'pi'
    expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/pocketsphinx').to be_grouped_into 'pi'
  end

  it 'creates /home/pi/dev/bossjones-github/scarlett-dbus-poc/py2cairo' do
    expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/py2cairo').to be_directory
    expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/py2cairo').to be_mode('755')
    expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/py2cairo').to be_owned_by 'pi'
    expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/py2cairo').to be_grouped_into 'pi'
  end

  # %w(install_gst-plugins-espeak.sh create_symlinks_virtualenv.sh install_sphinxbase.sh install_pocketsphinx.sh).each do |pkg|
  #     it "expect  /tmp/#{pkg} to exist" do
  #       expect(file "/tmp/#{pkg}"").to be_file
  #     end
  #   end
end

describe 'content of /home/pi/.virtualenvs/scarlett-dbus-poc/lib directory' do
  %w(pkgconfig gstreamer-1.0).each do |pkg|
    it "expect directory /home/pi/.virtualenvs/scarlett-dbus-poc/lib/#{pkg}" do
      expect(file "/home/pi/.virtualenvs/scarlett-dbus-poc/lib/#{pkg}").to be_directory
    end
  end

  %w(libpocketsphinx.a libpocketsphinx.la libpocketsphinx.so.3.0.0 libsphinxad.a libsphinxad.la  libsphinxad.so.3.0.0 libsphinxbase.a libsphinxbase.la libsphinxbase.so.3.0.0).each do |pkg|
    it "expect directory /home/pi/.virtualenvs/scarlett-dbus-poc/lib/#{pkg}" do
      expect(file "/home/pi/.virtualenvs/scarlett-dbus-poc/lib/#{pkg}").to exist
    end
  end

  %w(libpocketsphinx.so libpocketsphinx.so.3 libsphinxad.so libsphinxad.so.3 libsphinxbase.so libsphinxbase.so.3).each do |pkg|
    it "expect directory /home/pi/.virtualenvs/scarlett-dbus-poc/lib/#{pkg}" do
      expect(file "/home/pi/.virtualenvs/scarlett-dbus-poc/lib/#{pkg}").to be_symlink
    end
  end
end

describe 'content of #{venv_site_pkgs_folder} directory' do
  %w(pocketsphinx sphinxbase).each do |pkg|
    it "expect directory #{venv_site_pkgs_folder}/#{pkg}" do
      expect(file "#{venv_site_pkgs_folder}/#{pkg}").to be_directory
    end
  end

  %w(pygst.py pygst.pth gobject glib gstoption.so pygst.pyc gst-1.0 cairo).each do |pkg|
    it "expect directory #{venv_site_pkgs_folder}/#{pkg}" do
      expect(file "#{venv_site_pkgs_folder}/#{pkg}").to be_linked_to("/usr/lib/python2.7/dist-packages/#{pkg}")
    end
  end
end

describe "content of #{venv_site_pkgs_pocketsphinx_folder} directory" do
  %w(__init__.pyo __init__.pyc __init__.py _pocketsphinx.a _pocketsphinx.la _pocketsphinx.so.0.0.0 pocketsphinx.pyo pocketsphinx.pyc pocketsphinx.py).each do |pkg|
    it "expect directory #{venv_site_pkgs_pocketsphinx_folder}/#{pkg}" do
      expect(file "#{venv_site_pkgs_pocketsphinx_folder}/#{pkg}").to exist
    end
  end

  %w(_pocketsphinx.so _pocketsphinx.so.0).each do |pkg|
    it "expect directory #{venv_site_pkgs_pocketsphinx_folder}/#{pkg}" do
      expect(file "#{venv_site_pkgs_pocketsphinx_folder}/#{pkg}").to be_symlink
    end
  end
end


#   using virtualenv: scarlett-dbus-poc scarlett-ansible in ~/.virtualenvs/scarlett-dbus-poc/lib/python2.7/site-packages/pocketsphinx
# ○ → ls -lta
# total 924
# drwxrwxr-x  2 pi pi   4096 Dec 30 19:32 .
# -rw-rw-r--  1 pi pi    222 Dec 30 19:32 __init__.pyo
# -rw-rw-r--  1 pi pi    222 Dec 30 19:32 __init__.pyc
# -rw-r--r--  1 pi pi   1813 Dec 30 19:32 __init__.py
# -rw-r--r--  1 pi pi 494940 Dec 30 19:32 _pocketsphinx.a
# -rwxr-xr-x  1 pi pi   1480 Dec 30 19:32 _pocketsphinx.la
# lrwxrwxrwx  1 pi pi     22 Dec 30 19:32 _pocketsphinx.so -> _pocketsphinx.so.0.0.0
# lrwxrwxrwx  1 pi pi     22 Dec 30 19:32 _pocketsphinx.so.0 -> _pocketsphinx.so.0.0.0
# -rwxr-xr-x  1 pi pi 326476 Dec 30 19:32 _pocketsphinx.so.0.0.0
# -rw-rw-r--  1 pi pi  36154 Dec 30 19:32 pocketsphinx.pyo
# -rw-rw-r--  1 pi pi  36154 Dec 30 19:32 pocketsphinx.pyc
# -rw-r--r--  1 pi pi  23445 Dec 30 19:32 pocketsphinx.py
# drwxrwxr-x 88 pi pi   4096 Dec 30 13:57 ..

#   using virtualenv: scarlett-dbus-poc scarlett-ansible in ~/.virtualenvs/scarlett-dbus-poc/lib/python2.7/site-packages/sphinxbase
# ○ → ls -lta
# total 900
# drwxrwxr-x  2 pi pi   4096 Dec 30 19:23 .
# -rw-rw-r--  1 pi pi    218 Dec 30 19:23 __init__.pyo
# -rw-rw-r--  1 pi pi    218 Dec 30 19:23 __init__.pyc
# -rw-r--r--  1 pi pi   1811 Dec 30 19:23 __init__.py
# -rw-r--r--  1 pi pi 468286 Dec 30 19:23 _sphinxbase.a
# -rwxr-xr-x  1 pi pi   1132 Dec 30 19:23 _sphinxbase.la
# lrwxrwxrwx  1 pi pi     20 Dec 30 19:23 _sphinxbase.so -> _sphinxbase.so.0.0.0
# lrwxrwxrwx  1 pi pi     20 Dec 30 19:23 _sphinxbase.so.0 -> _sphinxbase.so.0.0.0
# -rwxr-xr-x  1 pi pi 317690 Dec 30 19:23 _sphinxbase.so.0.0.0
# -rw-rw-r--  1 pi pi  38525 Dec 30 19:23 sphinxbase.pyo
# -rw-rw-r--  1 pi pi  38525 Dec 30 19:23 sphinxbase.pyc
# -rw-r--r--  1 pi pi  23675 Dec 30 19:23 sphinxbase.py
# drwxrwxr-x 88 pi pi   4096 Dec 30 13:57 ..

#   using virtualenv: scarlett-dbus-poc scarlett-ansible in ~/.virtualenvs/scarlett-dbus-poc/lib/pkgconfig
# ○ → ls -lta
# total 16
# drwxrwxr-x 2 pi pi 4096 Dec 30 19:32 .
# -rw-r--r-- 1 pi pi  526 Dec 30 19:32 pocketsphinx.pc
# drwxrwxr-x 5 pi pi 4096 Dec 30 19:32 ..
# -rw-r--r-- 1 pi pi  487 Dec 30 19:23 sphinxbase.pc
