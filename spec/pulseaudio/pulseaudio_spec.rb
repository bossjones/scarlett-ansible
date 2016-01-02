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

describe command('cat /etc/pulse/daemon.conf') do
  its(:stdout) { should match /.*^exit-idle-time = 10800 # 3 hours$.*/ }
  its(:stdout) { should_not match /.*^exit-idle-time = 20 # 3 hours$.*/ }
  its(:stdout) { should match /.*^log-level = info$.*/ }
end

describe command('cat /etc/init/pulseaudio.conf') do
  its(:stdout) { should match /.*^env DISALLOW_MODULE_LOADING=0$.*/ }
  its(:stdout) { should_not match /.*^env DISALLOW_MODULE_LOADING=1$.*/ }
end

describe command('cat /etc/pulse/client.conf') do
  its(:stdout) { should match /.*^extra-arguments = --log-target=syslog -vv$.*/ }
end

describe command('cat /etc/default/speech-dispatcher') do
  its(:stdout) { should match /.*^RUN=no$.*/ }
end

# Currently in use: 1 blocks containing 63.9 KiB bytes total.
# Allocated during whole lifetime: 46233 blocks containing 74.5 MiB bytes total.
# Sample cache size: 0 B
# Server String: /run/user/1000/pulse/native
# Library Protocol Version: 28
# Server Protocol Version: 28
# Is Local: yes
# Client Index: 30
# Tile Size: 65472
# User Name: pi
# Host Name: scarlett-ansible
# Server Name: pulseaudio
# Server Version: 4.0
# Default Sample Specification: s16le 2ch 44100Hz
# Default Channel Map: front-left,front-right
# Default Sink: alsa_output.pci-0000_00_05.0.analog-stereo
# Default Source: input
# Cookie: 008c:872c
