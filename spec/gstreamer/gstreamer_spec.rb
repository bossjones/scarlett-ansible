#!/usr/bin/env ruby

require 'spec_helper'

gstreamer_prereqs = [ "gir1.2-clutter-1.0", "gir1.2-clutter-gst-1.0", "gir1.2-gda-5.0", "gir1.2-gst-plugins-base-1.0", "gir1.2-gstreamer-0.10", "gir1.2-gstreamer-1.0", "gir1.2-gtk-3.0", "gir1.2-gtkclutter-1.0", "gir1.2-gtksource-3.0", "gir1.2-vte-2.90", "gir1.2-webkit-1.0", "gir1.2-webkit-3.0", "graphviz", "gstreamer0.10-alsa", "gstreamer0.10-doc", "gstreamer0.10-nice", "gstreamer0.10-plugins-base", "gstreamer0.10-plugins-base-apps", "gstreamer0.10-plugins-good", "gstreamer0.10-pulseaudio", "gstreamer0.10-tools", "gstreamer0.10-x", "gstreamer1.0-alsa", "gstreamer1.0-clutter", "gstreamer1.0-crystalhd", "gstreamer1.0-doc", "gstreamer1.0-fluendo-mp3", "gstreamer1.0-gnonlin", "gstreamer1.0-gnonlin-dbg", "gstreamer1.0-gnonlin-doc", "gstreamer1.0-libav", "gstreamer1.0-libav-dbg", "gstreamer1.0-nice", "gstreamer1.0-plugins-bad", "gstreamer1.0-plugins-bad-dbg", "gstreamer1.0-plugins-bad-doc", "gstreamer1.0-plugins-bad-faad", "gstreamer1.0-plugins-bad-videoparsers", "gstreamer1.0-plugins-base", "gstreamer1.0-plugins-base-apps", "gstreamer1.0-plugins-base-dbg", "gstreamer1.0-plugins-base-doc", "gstreamer1.0-plugins-good", "gstreamer1.0-plugins-good-dbg", "gstreamer1.0-plugins-good-doc", "gstreamer1.0-plugins-ugly", "gstreamer1.0-plugins-ugly-dbg", "gstreamer1.0-plugins-ugly-doc", "gstreamer1.0-pulseaudio", "gstreamer1.0-tools", "gstreamer1.0-vaapi", "gstreamer1.0-vaapi-doc", "gstreamer1.0-x", "libclutter-gst-1.0-dbg", "libclutter-gst-dev", "libgstreamer-plugins-bad1.0-0", "libgstreamer-plugins-bad1.0-dev", "libgstreamer-plugins-base0.10-0", "libgstreamer-plugins-base0.10-dev", "libgstreamer-plugins-base1.0-0", "libgstreamer-plugins-base1.0-dev", "libgstreamer-plugins-good1.0-0", "libgstreamer-vaapi1.0-0", "libgstreamer-vaapi1.0-dev", "libgstreamer0.10-0", "libgstreamer0.10-dev", "libgstreamer1.0-0","libgstreamer1.0-0-dbg", "libgstreamer1.0-dev", "libgstreamer1.0-0", "libgstreamer1.0-0-dbg", "libgstreamer1.0-dev", "libreoffice-avmedia-backend-gstreamer", "phonon-backend-gstreamer", "phonon-backend-gstreamer-common", "phonon-backend-gstreamer-dbg", "phonon-backend-gstreamer1.0", "phonon-backend-gstreamer1.0-common", "phonon-backend-gstreamer1.0-dbg", "gnome-media" ]

gstreamer_prereqs.each { |x|
  describe 'gstreamer_prereqs' do
    it "installs #{x}" do
      expect(package x).to be_installed
    end
  end
}

describe 'ppa:gstreamer-developers/ppa installed' do
  it "has ppa:gstreamer-developers/ppa" do
    expect(ppa('gstreamer-developers/ppa')).to exist
  end
end

describe command('gconftool-2 -a /system/gstreamer/1.0/default') do
  its(:stdout) { should match /.*musicaudiosink = pulsesink.*/ }
  its(:stdout) { should match /.*audiosink = pulsesink.*/ }
  its(:stdout) { should match /.*audiosrc = pulsesrc.*/ }
end