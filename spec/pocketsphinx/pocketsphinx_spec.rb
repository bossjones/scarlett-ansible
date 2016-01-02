#!/usr/bin/env ruby

require 'spec_helper'

venv_site_pkgs_folder = '/home/pi/.virtualenvs/scarlett-dbus-poc/lib/python2.7/site-packages'

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

# lrwxrwxrwx 1 pi pi 41 Dec 23 16:25 ./pygst.py -> /usr/lib/python2.7/dist-packages/pygst.py
# lrwxrwxrwx 1 pi pi 42 Dec 23 16:25 ./pygst.pth -> /usr/lib/python2.7/dist-packages/pygst.pth
# lrwxrwxrwx 1 pi pi 40 Dec 23 16:25 ./gobject -> /usr/lib/python2.7/dist-packages/gobject
# lrwxrwxrwx 1 pi pi 37 Dec 23 16:25 ./glib -> /usr/lib/python2.7/dist-packages/glib
# lrwxrwxrwx 1 pi pi 45 Dec 23 16:25 ./gstoption.so -> /usr/lib/python2.7/dist-packages/gstoption.so
# lrwxrwxrwx 1 pi pi 42 Dec 23 16:25 ./pygst.pyc -> /usr/lib/python2.7/dist-packages/pygst.pyc
# lrwxrwxrwx 1 pi pi 40 Dec 23 16:25 ./gst-1.0 -> /usr/lib/python2.7/dist-packages/gst-1.0
# lrwxrwxrwx 1 pi pi 38 Dec 23 16:25 ./cairo -> /usr/lib/python2.7/dist-packages/cairo

  %w(pygst.py pygst.pth gobject glib gstoption.so pygst.pyc gst-1.0 cairo).each do |pkg|
    it "expect directory #{venv_site_pkgs_folder}/#{pkg}" do
      expect(file "#{venv_site_pkgs_folder}/#{pkg}").to be_linked_to("/usr/lib/python2.7/dist-packages/#{pkg}")
    end
  end

end

#   using virtualenv: scarlett-dbus-poc scarlett-ansible in ~/.virtualenvs/scarlett-dbus-poc/lib/python2.7/site-packages
# ○ → ls -lta
# total 2656
# drwxrwxr-x  2 pi pi   4096 Dec 30 19:32 pocketsphinx
# drwxrwxr-x  2 pi pi   4096 Dec 30 19:23 sphinxbase
# drwxrwxr-x  2 pi pi   4096 Dec 30 19:22 wheel-0.24.0.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 30 19:22 pip-7.1.2.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 30 19:22 setuptools-18.2.dist-info
# -rw-rw-r--  1 pi pi    315 Dec 30 19:22 easy_install.pyc
# -rw-rw-r--  1 pi pi    126 Dec 30 19:22 easy_install.py
# drwxrwxr-x 88 pi pi   4096 Dec 30 13:57 .
# drwxrwxr-x  2 pi pi   4096 Dec 29 19:47 setuptools-19.2.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 29 19:47 _markerlib
# drwxrwxr-x  3 pi pi   4096 Dec 29 19:47 setuptools
# drwxrwxr-x  3 pi pi   4096 Dec 29 19:47 pkg_resources
# drwxrwxr-x  2 pi pi   4096 Dec 29 19:46 colorlog-2.6.0.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 29 19:46 colorlog
# drwxrwxr-x  2 pi pi   4096 Dec 29 19:46 autoenv-1.0.0.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 29 16:01 forecastio
# drwxrwxr-x  2 pi pi   4096 Dec 29 16:01 python_forecastio-1.3.4.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 29 16:01 phue-0.8.dist-info
# -rw-rw-r--  1 pi pi  28156 Dec 29 16:01 phue.pyc
# -rw-rw-r--  1 pi pi  30111 Dec 29 16:01 phue.py
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 flake8-2.5.1.dist-info
# drwxrwxr-x  3 pi pi   4096 Dec 24 12:09 flake8
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 pyflakes-1.0.0.dist-info
# drwxrwxr-x  4 pi pi   4096 Dec 24 12:09 pyflakes
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 mccabe-0.3.1.dist-info
# -rw-rw-r--  1 pi pi  12187 Dec 24 12:09 mccabe.pyc
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 pycurl-7.19.5.3.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 curl
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 pycares-1.0.0.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 responses-0.3.0.dist-info
# -rw-rw-r--  1 pi pi  10094 Dec 24 12:09 responses.pyc
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 autopep8-1.0.4.dist-info
# -rw-rw-r--  1 pi pi  95822 Dec 24 12:09 autopep8.pyc
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 pep8-1.5.7.dist-info
# -rw-rw-r--  1 pi pi  64296 Dec 24 12:09 pep8.pyc
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 tox-1.8.0.dist-info
# drwxrwxr-x  3 pi pi   4096 Dec 24 12:09 tox
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 py-1.4.31.dist-info
# drwxrwxr-x  7 pi pi   4096 Dec 24 12:09 py
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 pylint-1.2.0.dist-info
# drwxrwxr-x  6 pi pi   4096 Dec 24 12:09 pylint
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 astroid-1.4.3.dist-info
# drwxrwxr-x  4 pi pi   4096 Dec 24 12:09 astroid
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 wrapt-1.10.6.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 wrapt
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 lazy_object_proxy
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 lazy_object_proxy-1.2.1.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 logilab_common-1.1.0.dist-info
# drwxrwxr-x  3 pi pi   4096 Dec 24 12:09 logilab
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 unittest2-0.5.1.dist-info
# drwxrwxr-x  3 pi pi   4096 Dec 24 12:09 unittest2
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 mock-1.0.1.dist-info
# -rw-rw-r--  1 pi pi  67600 Dec 24 12:09 mock.pyc
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 PyYAML-3.11.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 yaml
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 httpretty
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 httpretty-0.8.12.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 simplejson-3.5.2.dist-info
# drwxrwxr-x  3 pi pi   4096 Dec 24 12:09 simplejson
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 rsa
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 rsa-3.1.4.dist-info
# drwxrwxr-x  5 pi pi   4096 Dec 24 12:09 pyasn1
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 pyasn1-0.1.9.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 requests-2.0.1.dist-info
# drwxrwxr-x  3 pi pi   4096 Dec 24 12:09 requests
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:09 nose-1.3.3.dist-info
# drwxrwxr-x  6 pi pi   4096 Dec 24 12:09 nose
# -rw-rw-r--  1 pi pi    308 Dec 24 12:09 logilab_common-1.1.0-py2.7-nspkg.pth
# -rwxrwxr-x  1 pi pi 331763 Dec 24 12:09 pycurl.so
# -rwxrwxr-x  1 pi pi 324653 Dec 24 12:09 pycares.so
# -rw-rw-r--  1 pi pi   7841 Dec 24 12:09 responses.py
# -rw-rw-r--  1 pi pi 121702 Dec 24 12:09 autopep8.py
# -rw-rw-r--  1 pi pi  75527 Dec 24 12:09 mock.py
# -rwxrwxr-x  1 pi pi 915023 Dec 24 12:09 _yaml.so
# -rw-rw-r--  1 pi pi   9565 Dec 24 12:09 mccabe.py
# -rw-rw-r--  1 pi pi  75073 Dec 24 12:09 pep8.py
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 transitions
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 transitions-0.2.5.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 pulsar-0.9.1.dist-info
# drwxrwxr-x  5 pi pi   4096 Dec 24 12:08 pulsar
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 trollius
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 trollius-2.0.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 futures-3.0.3.dist-info
# drwxrwxr-x  3 pi pi   4096 Dec 24 12:08 concurrent
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 hiredis-0.2.0.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 hiredis
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 redis-2.10.5.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 redis
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 colorama
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 colorama-0.3.2.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 changes
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 changes-0.6.0.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 semantic_version-2.4.2.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 semantic_version
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 path.py-4.4.dist-info
# -rw-rw-r--  1 pi pi  25493 Dec 24 12:08 test_path.pyc
# -rw-rw-r--  1 pi pi  48808 Dec 24 12:08 path.pyc
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 click
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 click-2.5.dist-info
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 plumbum-1.4.2.dist-info
# drwxrwxr-x  7 pi pi   4096 Dec 24 12:08 plumbum
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 pyserial-2.7.dist-info
# drwxrwxr-x  4 pi pi   4096 Dec 24 12:08 serial
# drwxrwxr-x  2 pi pi   4096 Dec 24 12:08 yolk-0.4.3.dist-info
# drwxrwxr-x  3 pi pi   4096 Dec 24 12:08 yolk
# -rw-rw-r--  1 pi pi  44883 Dec 24 12:08 path.py
# -rw-rw-r--  1 pi pi  26114 Dec 24 12:08 test_path.py
# lrwxrwxrwx  1 pi pi     38 Dec 23 16:25 cairo -> /usr/lib/python2.7/dist-packages/cairo
# lrwxrwxrwx  1 pi pi     37 Dec 23 16:25 glib -> /usr/lib/python2.7/dist-packages/glib
# lrwxrwxrwx  1 pi pi     40 Dec 23 16:25 gobject -> /usr/lib/python2.7/dist-packages/gobject
# lrwxrwxrwx  1 pi pi     42 Dec 23 16:25 pygst.pyc -> /usr/lib/python2.7/dist-packages/pygst.pyc
# lrwxrwxrwx  1 pi pi     40 Dec 23 16:25 gst-1.0 -> /usr/lib/python2.7/dist-packages/gst-1.0
# lrwxrwxrwx  1 pi pi     45 Dec 23 16:25 gstoption.so -> /usr/lib/python2.7/dist-packages/gstoption.so
# lrwxrwxrwx  1 pi pi     42 Dec 23 16:25 pygst.pth -> /usr/lib/python2.7/dist-packages/pygst.pth
# lrwxrwxrwx  1 pi pi     41 Dec 23 16:25 pygst.py -> /usr/lib/python2.7/dist-packages/pygst.py
# drwxrwxr-x  5 pi pi   4096 Dec 23 16:25 wheel
# drwxrwxr-x 10 pi pi   4096 Dec 23 16:25 pip
# drwxrwxr-x  4 pi pi   4096 Dec 23 16:25 ..

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
