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

# echo "libpulse-dev
# libpulse-mainloop-glib0
# libpulse-mainloop-glib0-dbg
# libpulse0
# libpulse0-dbg
# libsox-fmt-pulse
# paman
# paprefs
# pavucontrol
# pavumeter
# pulseaudio
# pulseaudio-dbg
# pulseaudio-esound-compat
# pulseaudio-esound-compat-dbg
# pulseaudio-module-bluetooth
# pulseaudio-module-gconf
# pulseaudio-module-jack
# pulseaudio-module-lirc
# pulseaudio-module-lirc-dbg
# pulseaudio-module-x11
# pulseaudio-module-zeroconf
# pulseaudio-module-zeroconf-dbg
# pulseaudio-utils
# pavucontrol
# avahi-daemon
# libtheora-dev
# libogg-dev
# libvorbis-dev
# libasound2-dev
# libjack-dev" | sed 's,^,",g' | sed 's,$,",g'


describe command('pactl stat'), :sudo => false do
  its(:stdout) { should match /.*Default Source: input.*/ }
  its(:stdout) { should match /.*Default Sink: alsa_output.pci-0000_00_05.0.analog-stereo.*/ }
  its(:stdout) { should_not match /.*Default Source: alsa_input.pci-0000_00_05.0.analog-stereo.*/ }
end
