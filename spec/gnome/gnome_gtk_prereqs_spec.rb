#!/usr/bin/env ruby

require 'spec_helper'

gnome_gtk_prereqs_shortlist = ["dbus-x11",
                               "faac",
                               "faad",
                               "gettext",
                               "glade",
                               "gnome-common",
                               "gnome-core-devel",
                               "gnome-devel",
                               "gnome-doc-utils",
                               "gnome-pkg-tools",
                               "gobject-introspection",
                               "ladspa-sdk",
                               "liba52-0.7.4-dev",
                               "libaa1-dev",
                               "libasound2-dev",
                               "libasound2-plugins",
                               "libcairo2-dev",
                               "libfaac-dev",
                               "libfaad-dev",
                               "libffi-dev",
                               "libflac-dev",
                               "libglib2.0-*",
                               "libglib2.0-dev",
                               "libglib3.0*",
                               "libgtk-3-dev",
                               "libgtk-3-doc",
                               "libgtk2.0-dev",
                               "libgtkmm-3.0-dev",
                               "libgudev-1.0-dev",
                               "libiw-dev",
                               "libjack-dev",
                               "libjasper1",
                               "libnice-dev",
                               "libpango1.0-dev",
                               "libpcre3-dev",
                               "libpng-dev",
                               "libpulse-dev",
                               "libpython2.7",
                               "libpython3.4",
                               "libsndfile-dev",
                               "libsndfile1-dev",
                               "libsoundtouch-dev",
                               "libsoup2.4-dev",
                               "libsox-fmt-pulse",
                               "libspandsp-dev",
                               "libspeex-dev",
                               "libssl-dev",
                               "libvalad*",
                               "libvorbis-dev",
                               "libvpx-dev",
                               "libwavpack-dev",
                               "libwebkitgtk-3.0-dev",
                               "libwebp-dev",
                               "valac",
                               "valac-0.14"]

gnome_gtk_prereqs_shortlist.each { |x|
  describe 'gnome_gtk_prereqs_shortlist' do
    it "installs #{x}" do
      expect(package x).to be_installed
    end
  end
}

describe 'ppa:ricotz/testing installed', if: os[:release].to_i == 15 do
  it 'has ppa:ricotz/testing' do
    expect(ppa('ppa:ricotz/testing')).to exist
  end
end

describe 'ppa:gnome3-team/gnome3 installed', if: os[:release].to_i == 15 do
  it 'has ppa:gnome3-team/gnome3' do
    expect(ppa('ppa:gnome3-team/gnome3')).to exist
  end
end

describe 'ppa:gnome3-team/gnome3-staging installed', if: os[:release].to_i == 15 do
  it 'has ppa:gnome3-team/gnome3-staging' do
    expect(ppa('ppa:gnome3-team/gnome3-staging')).to exist
  end
end
