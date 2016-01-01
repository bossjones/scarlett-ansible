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
