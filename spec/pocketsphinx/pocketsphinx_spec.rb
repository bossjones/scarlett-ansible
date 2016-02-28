#!/usr/bin/env ruby

require 'spec_helper'

venv_site_pkgs_folder = '/home/pi/.virtualenvs/scarlett-dbus-poc/lib/python2.7/site-packages'
venv_site_pkgs_pocketsphinx_folder='/home/pi/.virtualenvs/scarlett-dbus-poc/lib/python2.7/site-packages/pocketsphinx'
venv_site_pkgs_sphinxbase_folder='/home/pi/.virtualenvs/scarlett-dbus-poc/lib/python2.7/site-packages/sphinxbase'
venv_lib_pkgconfig_folder='/home/pi/.virtualenvs/scarlett-dbus-poc/lib/pkgconfig'
venv_lib_folder='/home/pi/.virtualenvs/scarlett-dbus-poc/lib'
venv_lib_gstreamer_folder='/home/pi/.virtualenvs/scarlett-dbus-poc/lib/gstreamer-1.0'

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

  # it 'creates /home/pi/dev/bossjones-github/scarlett-dbus-poc/py2cairo' do
  #   expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/py2cairo').to be_directory
  #   expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/py2cairo').to be_mode('755')
  #   expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/py2cairo').to be_owned_by 'pi'
  #   expect(file '/home/pi/dev/bossjones-github/scarlett-dbus-poc/py2cairo').to be_grouped_into 'pi'
  # end
end

describe "content of #{venv_lib_folder} directory" do
  %w(pkgconfig gstreamer-1.0).each do |pkg|
    it "expect directory #{venv_lib_folder}/#{pkg}" do
      expect(file "#{venv_lib_folder}/#{pkg}").to be_directory
    end
  end

  %w(libpocketsphinx.a libpocketsphinx.la libpocketsphinx.so.3.0.0 libsphinxad.a libsphinxad.la  libsphinxad.so.3.0.0 libsphinxbase.a libsphinxbase.la libsphinxbase.so.3.0.0).each do |pkg|
    it "expect directory #{venv_lib_folder}/#{pkg}" do
      expect(file "#{venv_lib_folder}/#{pkg}").to exist
    end
  end

  %w(libpocketsphinx.so libpocketsphinx.so.3 libsphinxad.so libsphinxad.so.3 libsphinxbase.so libsphinxbase.so.3).each do |pkg|
    it "expect directory #{venv_lib_folder}/#{pkg}" do
      expect(file "#{venv_lib_folder}/#{pkg}").to be_symlink
    end
  end
end

describe "content of #{venv_site_pkgs_folder} directory" do
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

describe "content of #{venv_site_pkgs_sphinxbase_folder} directory" do
  %w(__init__.pyo __init__.pyc __init__.py _sphinxbase.a _sphinxbase.la _sphinxbase.so.0.0.0 sphinxbase.pyo sphinxbase.pyc sphinxbase.py).each do |pkg|
    it "expect directory #{venv_site_pkgs_sphinxbase_folder}/#{pkg}" do
      expect(file "#{venv_site_pkgs_sphinxbase_folder}/#{pkg}").to exist
    end
  end

  %w(_sphinxbase.so _sphinxbase.so.0).each do |pkg|
    it "expect directory #{venv_site_pkgs_sphinxbase_folder}/#{pkg}" do
      expect(file "#{venv_site_pkgs_sphinxbase_folder}/#{pkg}").to be_symlink
    end
  end
end

describe "content of #{venv_lib_pkgconfig_folder} directory" do
  %w(pocketsphinx.pc sphinxbase.pc).each do |pkg|
    it "expect directory #{venv_lib_pkgconfig_folder}/#{pkg}" do
      expect(file "#{venv_lib_pkgconfig_folder}/#{pkg}").to exist
    end
  end
end

# make sure gst-espeak plugin is compiled correctly
describe "content of #{venv_lib_gstreamer_folder} directory" do
  it "expect directory #{venv_lib_gstreamer_folder}" do
    expect(file "#{venv_lib_gstreamer_folder}").to be_directory
  end


  %w(libgstespeak.la libgstespeak.so libgstpocketsphinx.a libgstpocketsphinx.la libgstpocketsphinx.so).each do |pkg|
    it "expect directory #{venv_lib_gstreamer_folder}/#{pkg}" do
      expect(file "#{venv_lib_gstreamer_folder}/#{pkg}").to exist
    end
  end
end
