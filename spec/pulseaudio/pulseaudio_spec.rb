#!/usr/bin/env ruby

require 'spec_helper'

sound_libs = ['faac', 'faad', 'flex']

setup_pulseaudio = ["libpulse-dev",
                    "libpulse-mainloop-glib0",
                    "libpulse-mainloop-glib0-dbg",
                    "libpulse0",
                    "libpulse0-dbg",
                    "libsox-fmt-pulse",
                    "paman",
                    "paprefs",
                    "pavucontrol",
                    "pavumeter",
                    "pulseaudio",
                    "pulseaudio-dbg",
                    "pulseaudio-esound-compat",
                    "pulseaudio-esound-compat-dbg",
                    "pulseaudio-module-bluetooth",
                    "pulseaudio-module-gconf",
                    "pulseaudio-module-jack",
                    "pulseaudio-module-lirc",
                    "pulseaudio-module-lirc-dbg",
                    "pulseaudio-module-x11",
                    "pulseaudio-module-zeroconf",
                    "pulseaudio-module-zeroconf-dbg",
                    "pulseaudio-utils",
                    "pavucontrol",
                    "avahi-daemon",
                    "libtheora-dev",
                    "libogg-dev",
                    "libvorbis-dev",
                    "libasound2-dev",
                    "libjack-dev"]


sound_libs.each { |x|
  describe 'sound_libs' do
    it "installs #{x}" do
      expect(package x).to be_installed
    end
  end
}

setup_pulseaudio.each { |x|
  describe 'setup_pulseaudio' do
    it "installs #{x}" do
      expect(package x).to be_installed
    end
  end
}

describe command('pactl stat'), :sudo => false do
  its(:stdout) { should match /.*Default Source: input.*/ }
  its(:stdout) { should match /.*Default Sink: alsa_output.pci-0000_00_05.0.analog-stereo.*/ }
  its(:stdout) { should_not match /.*Default Source: alsa_input.pci-0000_00_05.0.analog-stereo.*/ }
end

describe command('cat /etc/modprobe.d/alsa-base.conf') do
  its(:stdout) { should match /.*^options snd-usb-audio index=0$.*/ }
  its(:stdout) { should match /.*^options snd-hda-intel model=generic$.*/ }
  its(:stdout) { should_not match /.*^options snd-usb-audio index=-2$.*/ }
end

# /etc/modprobe.d/alsa-base.conf
# options snd-usb-audio index=0
# snd-hda-intel model=generic
# NOT ^options snd-usb-audio index=-2$


# /etc/pulse/daemon.conf
# ^exit-idle-time = 10800 # 3 hours$
# NOT ^exit-idle-time = 20 # 3 hours$
# ^log-level = info$

# /home/pi/postactivate
# export GSTREAMER=1.0
# export PI_HOME=/home/pi
# export MAIN_DIR=$PI_HOME/dev/bossjones-github/scarlett-dbus-poc
# export VIRT_ROOT=$PI_HOME/.virtualenvs/scarlett-dbus-poc
# export PKG_CONFIG_PATH=$VIRT_ROOT/lib/pkgconfig
# export SCARLETT_CONFIG=$MAIN_DIR/tests/fixtures/.scarlett
# export SCARLETT_HMM=$MAIN_DIR/tests/fixtures/model/hmm/en_US/hub4wsj_sc_8k
# export SCARLETT_LM=$MAIN_DIR/tests/fixtures/lm/1602.lm
# export SCARLETT_DICT=$MAIN_DIR/tests/fixtures/dict/1602.dic
# # for GST PLUGINS
# export LD_LIBRARY_PATH=$VIRT_ROOT/lib
# export GST_PLUGIN_PATH=$VIRT_ROOT/lib/gstreamer-$GSTREAMER

# /etc/init/pulseaudio.conf
# env DISALLOW_MODULE_LOADING=0
# NOT ^env DISALLOW_MODULE_LOADING=1$
