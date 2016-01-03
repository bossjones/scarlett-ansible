# scarlett-ansible

https://blogs.gnome.org/uraeus/2011/10/04/tutorial-for-python-gstreamer-and-gtk-3/
https://developer.ridgerun.com/wiki/index.php/GStreamer_Debugging
https://developer.ridgerun.com/wiki/index.php?title=Embedded_GStreamer_Performance_Tuning
http://docs.gstreamer.com/display/GstSDK/Basic+tutorial+11%3A+Debugging+tools
http://wiki.buzztrax.org/index.php/Debugging
http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gst-running.html
http://gstreamer.freedesktop.org/data/doc/gstreamer/head/manual/html/section-checklist-debug.html
https://gramps-project.org/wiki/index.php?title=GEPS_029:_GTK3-GObject_introspection_Conversion

https://wiki.archlinux.org/index.php/PulseAudio/Examples

https://wiki.archlinux.org/index.php/PulseAudio/Configuration

http://trac.gateworks.com/wiki/Yocto/gstreamer/audio

# good example of how to compile from source in ansible
https://github.com/ozzyjohnson/ansible-ffmpeg-build/blob/master/build-ffmpeg.yml

# getting pocketsphinx working on raspbian ( need to add ansible commands for that )
http://cmusphinx.sourceforge.net/wiki/raspberrypi

# start vagrant server
VAGRANT_VAGRANTFILE=Vagrantfile-ansible-test vagrant up

# provision server
VAGRANT_VAGRANTFILE=Vagrantfile-ansible-test vagrant provision

### TODO

# files to modify
/etc/sudoers
/etc/sshd_config
/etc/ssh_config
/etc/ntp.conf


1. install build tools

2. install ppa packages
3. install latest git
4. install python + dependencies
5. create pi user if they don't exist + bash_profiles , authorized_keys etc + pi group
6. install bash_it
7. setup rbenv
8. install debug tools like lsof strace htop
9. install motd
11. install pulse audio + pulse audio configs
12. modify pi user to have audio access
13. install gstreamer*
14. setup dev directory structure for pi
15. install other dependencies ( huge list ) for everything gnome related, gtk3 etc
16. install virtualenv
17. mkvirtualenv scarlett-dbus
18. install virtualbox guest additions
19. install nodejs
20. clone all cmusphinx repos into /usr/local/src
21. chown pi:pi /usr/local/src/cmu*
22. git clone scarlett-dbus-poc
23. 


### NOTE: lets update steps... see following:
## check this https://wolfpaulus.com/journal/embedded/raspberrypi2-sr/

# Creating a Language Model
Create a text file ( eg `scarlett.corpus.txt` ), containing a list of words/sentences we want to be recognized
For instance ..

```
SCARLETT
TURN ON THE LIGHTS
TURN OFF THE LIGHTS
CHANGE THE LIGHTS BLUE
CHANGE THE LIGHTS GREEN
CHANGE THE LIGHTS RED
CHANGE THE LIGHTS WHITE
WHATS THE WEATHER
WHAT TIME IS IT
CHANGE THE TV TO MTV
CHANGE THE TV TO HBO
TURN THE LIGHTS BRIGHTER
TURN THE LIGHTS DARKER
SEXY TIME
CANCEL
NEGATIVE
STOP
GO
LEFT
RIGHT
UP
DOWN
FORWARD
BACKWARD
FRIZZY
TV
APPLE
TOSHIBA
UP
DOWN
LEFT
RIGHT
MENU
PAUSE
PLAY
CIRCLE BUTTON
CHANNEL UP
CHANNEL DOWN
VOLUME UP
VOLUME DOWN
MUTE
RECALL
INPUT
SELECT UP
SELECT LEFT
SELECT RIGHT
SELECT ENTER
ONE
TWO
THREE
FOUR
FIVE
SIX
SEVEN
EIGHT
NINE
ZERO
POWER
GET LIGHT NAMES
GET LIGHT IDS
WHAT ARE THE NAMES OF MY LIGHTS
GIVE ME LIGHT NAMES

```

Upload the text file here: http://www.speech.cs.cmu.edu/tools/lmtool-new.html
and then download the generated Pronunciation Dictionary and Language Model
For the the text file mentioned above, this is what the tool generates:

```
APPLE   AE P AH L
BACKWARD    B AE K W ER D
BLUE    B L UW
BRIGHTER    B R AY T ER
BUTTON  B AH T AH N
CANCEL  K AE N S AH L
CHANGE  CH EY N JH
CHANNEL CH AE N AH L
CIRCLE  S ER K AH L
DARKER  D AA R K ER
DOWN    D AW N
EIGHT   EY T
ENTER   EH N T ER
ENTER(2)    EH N ER
FIVE    F AY V
FORWARD F AO R W ER D
FOUR    F AO R
FRIZZY  F R IH Z IY
GO  G OW
GREEN   G R IY N
HBO HH B OW
INPUT   IH N P UH T
IS  IH Z
IT  IH T
LEFT    L EH F T
LIGHTS  L AY T S
MENU    M EH N Y UW
MTV EH M T IY V
MUTE    M Y UW T
NEGATIVE    N EH G AH T IH V
NINE    N AY N
OFF AO F
ON  AA N
ON(2)   AO N
ONE W AH N
ONE(2)  HH W AH N
PAUSE   P AO Z
PLAY    P L EY
POWER   P AW ER
RECALL  R IY K AO L
RECALL(2)   R IH K AO L
RED R EH D
RIGHT   R AY T
SCARLETT    S K AA R L IH T
SELECT  S AH L EH K T
SEVEN   S EH V AH N
SEXY    S EH K S IY
SIX S IH K S
STOP    S T AA P
THE DH AH
THE(2)  DH IY
THREE   TH R IY
TIME    T AY M
TO  T UW
TO(2)   T IH
TO(3)   T AH
TOSHIBA T OW SH IY B AH
TURN    T ER N
TV  T IY V IY
TV(2)   T EH L AH V IH ZH AH N
TWO T UW
UP  AH P
VOLUME  V AA L Y UW M
WEATHER W EH DH ER
WHAT    W AH T
WHAT(2) HH W AH T
WHATS   W AH T S
WHATS(2)    HH W AH T S
WHITE   W AY T
WHITE(2)    HH W AY T
ZERO    Z IH R OW
ZERO(2) Z IY R OW
```


language model:

```
Language model created by QuickLM on Thu Mar  6 01:35:05 EST 2014
Copyright (c) 1996-2010 Carnegie Mellon University and Alexander I. Rudnicky

The model is in standard ARPA format, designed by Doug Paul while he was at MITRE.

The code that was used to produce this language model is available in Open Source.
Please visit http://www.speech.cs.cmu.edu/tools/ for more information

The (fixed) discount mass is 0.5. The backoffs are computed using the ratio method.
This model based on a corpus of 58 sentences and 62 words

\data\
ngram 1=62
ngram 2=119
ngram 3=88

\1-grams:
-0.8820 </s> -0.3010
-0.8820 <s> -0.2296
-2.6454 APPLE -0.2399
-2.6454 BACKWARD -0.2399
-2.6454 BLUE -0.2399
-2.6454 BRIGHTER -0.2399
-2.6454 BUTTON -0.2399
-2.6454 CANCEL -0.2399
-1.8673 CHANGE -0.2901
-2.3444 CHANNEL -0.2921
-2.6454 CIRCLE -0.3000
-2.6454 DARKER -0.2399
-2.0434 DOWN -0.2399
-2.6454 EIGHT -0.2399
-2.6454 ENTER -0.2399
-2.6454 FIVE -0.2399
-2.6454 FORWARD -0.2399
-2.6454 FOUR -0.2399
-2.6454 FRIZZY -0.2399
-2.6454 GO -0.2399
-2.6454 GREEN -0.2399
-2.6454 HBO -0.2399
-2.6454 INPUT -0.2399
-2.6454 IS -0.3000
-2.6454 IT -0.2399
-2.1683 LEFT -0.2399
-1.7423 LIGHTS -0.2331
-2.6454 MENU -0.2399
-2.6454 MTV -0.2399
-2.6454 MUTE -0.2399
-2.6454 NEGATIVE -0.2399
-2.6454 NINE -0.2399
-2.6454 OFF -0.2901
-2.6454 ON -0.2901
-2.6454 ONE -0.2399
-2.6454 PAUSE -0.2399
-2.6454 PLAY -0.2399
-2.6454 POWER -0.2399
-2.6454 RECALL -0.2399
-2.6454 RED -0.2399
-2.1683 RIGHT -0.2399
-2.6454 SCARLETT -0.2399
-2.0434 SELECT -0.2891
-2.6454 SEVEN -0.2399
-2.6454 SEXY -0.2991
-2.6454 SIX -0.2399
-2.6454 STOP -0.2399
-1.6040 THE -0.2891
-2.6454 THREE -0.2399
-2.3444 TIME -0.2388
-2.3444 TO -0.2991
-2.6454 TOSHIBA -0.2399
-2.0434 TURN -0.2881
-2.1683 TV -0.2377
-2.6454 TWO -0.2399
-1.9465 UP -0.2399
-2.3444 VOLUME -0.2921
-2.6454 WEATHER -0.2399
-2.6454 WHAT -0.2991
-2.6454 WHATS -0.2901
-2.6454 WHITE -0.2399
-2.6454 ZERO -0.2399

\2-grams:
-2.0645 <s> APPLE 0.0000
-2.0645 <s> BACKWARD 0.0000
-2.0645 <s> CANCEL 0.0000
-1.2863 <s> CHANGE 0.0000
-1.7634 <s> CHANNEL 0.0000
-2.0645 <s> CIRCLE 0.0000
-1.7634 <s> DOWN 0.0000
-2.0645 <s> EIGHT 0.0000
-2.0645 <s> FIVE 0.0000
-2.0645 <s> FORWARD 0.0000
-2.0645 <s> FOUR 0.0000
-2.0645 <s> FRIZZY 0.0000
-2.0645 <s> GO 0.0000
-2.0645 <s> INPUT 0.0000
-1.7634 <s> LEFT 0.0000
-2.0645 <s> MENU 0.0000
-2.0645 <s> MUTE 0.0000
-2.0645 <s> NEGATIVE 0.0000
-2.0645 <s> NINE 0.0000
-2.0645 <s> ONE 0.0000
-2.0645 <s> PAUSE 0.0000
-2.0645 <s> PLAY 0.0000
-2.0645 <s> POWER 0.0000
-2.0645 <s> RECALL 0.0000
-1.7634 <s> RIGHT 0.0000
-2.0645 <s> SCARLETT 0.0000
-1.4624 <s> SELECT 0.0000
-2.0645 <s> SEVEN 0.0000
-2.0645 <s> SEXY 0.0000
-2.0645 <s> SIX 0.0000
-2.0645 <s> STOP 0.0000
-2.0645 <s> THREE 0.0000
-2.0645 <s> TOSHIBA 0.0000
-1.4624 <s> TURN 0.0000
-2.0645 <s> TV -0.2218
-2.0645 <s> TWO 0.0000
-1.7634 <s> UP 0.0000
-1.7634 <s> VOLUME 0.0000
-2.0645 <s> WHAT 0.0000
-2.0645 <s> WHATS 0.0000
-2.0645 <s> ZERO 0.0000
-0.3010 APPLE </s> -0.3010
-0.3010 BACKWARD </s> -0.3010
-0.3010 BLUE </s> -0.3010
-0.3010 BRIGHTER </s> -0.3010
-0.3010 BUTTON </s> -0.3010
-0.3010 CANCEL </s> -0.3010
-0.3010 CHANGE THE -0.0378
-0.6021 CHANNEL DOWN 0.0000
-0.6021 CHANNEL UP 0.0000
-0.3010 CIRCLE BUTTON 0.0000
-0.3010 DARKER </s> -0.3010
-0.3010 DOWN </s> -0.3010
-0.3010 EIGHT </s> -0.3010
-0.3010 ENTER </s> -0.3010
-0.3010 FIVE </s> -0.3010
-0.3010 FORWARD </s> -0.3010
-0.3010 FOUR </s> -0.3010
-0.3010 FRIZZY </s> -0.3010
-0.3010 GO </s> -0.3010
-0.3010 GREEN </s> -0.3010
-0.3010 HBO </s> -0.3010
-0.3010 INPUT </s> -0.3010
-0.3010 IS IT 0.0000
-0.3010 IT </s> -0.3010
-0.3010 LEFT </s> -0.3010
-0.9031 LIGHTS </s> -0.3010
-1.2041 LIGHTS BLUE 0.0000
-1.2041 LIGHTS BRIGHTER 0.0000
-1.2041 LIGHTS DARKER 0.0000
-1.2041 LIGHTS GREEN 0.0000
-1.2041 LIGHTS RED 0.0000
-1.2041 LIGHTS WHITE 0.0000
-0.3010 MENU </s> -0.3010
-0.3010 MTV </s> -0.3010
-0.3010 MUTE </s> -0.3010
-0.3010 NEGATIVE </s> -0.3010
-0.3010 NINE </s> -0.3010
-0.3010 OFF THE -0.1047
-0.3010 ON THE -0.1047
-0.3010 ONE </s> -0.3010
-0.3010 PAUSE </s> -0.3010
-0.3010 PLAY </s> -0.3010
-0.3010 POWER </s> -0.3010
-0.3010 RECALL </s> -0.3010
-0.3010 RED </s> -0.3010
-0.3010 RIGHT </s> -0.3010
-0.3010 SCARLETT </s> -0.3010
-0.9031 SELECT ENTER 0.0000
-0.9031 SELECT LEFT 0.0000
-0.9031 SELECT RIGHT 0.0000
-0.9031 SELECT UP 0.0000
-0.3010 SEVEN </s> -0.3010
-0.3010 SEXY TIME -0.1761
-0.3010 SIX </s> -0.3010
-0.3010 STOP </s> -0.3010
-0.4393 THE LIGHTS 0.0000
-1.0414 THE TV -0.1249
-1.3424 THE WEATHER 0.0000
-0.3010 THREE </s> -0.3010
-0.6021 TIME </s> -0.3010
-0.6021 TIME IS 0.0000
-0.6021 TO HBO 0.0000
-0.6021 TO MTV 0.0000
-0.3010 TOSHIBA </s> -0.3010
-0.9031 TURN OFF 0.0000
-0.9031 TURN ON 0.0000
-0.6021 TURN THE -0.1047
-0.7782 TV </s> -0.3010
-0.4771 TV TO 0.0000
-0.3010 TWO </s> -0.3010
-0.3010 UP </s> -0.3010
-0.6021 VOLUME DOWN 0.0000
-0.6021 VOLUME UP 0.0000
-0.3010 WEATHER </s> -0.3010
-0.3010 WHAT TIME -0.1761
-0.3010 WHATS THE -0.2808
-0.3010 WHITE </s> -0.3010
-0.3010 ZERO </s> -0.3010

\3-grams:
-0.3010 <s> APPLE </s>
-0.3010 <s> BACKWARD </s>
-0.3010 <s> CANCEL </s>
-0.3010 <s> CHANGE THE
-0.6021 <s> CHANNEL DOWN
-0.6021 <s> CHANNEL UP
-0.3010 <s> CIRCLE BUTTON
-0.3010 <s> DOWN </s>
-0.3010 <s> EIGHT </s>
-0.3010 <s> FIVE </s>
-0.3010 <s> FORWARD </s>
-0.3010 <s> FOUR </s>
-0.3010 <s> FRIZZY </s>
-0.3010 <s> GO </s>
-0.3010 <s> INPUT </s>
-0.3010 <s> LEFT </s>
-0.3010 <s> MENU </s>
-0.3010 <s> MUTE </s>
-0.3010 <s> NEGATIVE </s>
-0.3010 <s> NINE </s>
-0.3010 <s> ONE </s>
-0.3010 <s> PAUSE </s>
-0.3010 <s> PLAY </s>
-0.3010 <s> POWER </s>
-0.3010 <s> RECALL </s>
-0.3010 <s> RIGHT </s>
-0.3010 <s> SCARLETT </s>
-0.9031 <s> SELECT ENTER
-0.9031 <s> SELECT LEFT
-0.9031 <s> SELECT RIGHT
-0.9031 <s> SELECT UP
-0.3010 <s> SEVEN </s>
-0.3010 <s> SEXY TIME
-0.3010 <s> SIX </s>
-0.3010 <s> STOP </s>
-0.3010 <s> THREE </s>
-0.3010 <s> TOSHIBA </s>
-0.9031 <s> TURN OFF
-0.9031 <s> TURN ON
-0.6021 <s> TURN THE
-0.3010 <s> TV </s>
-0.3010 <s> TWO </s>
-0.3010 <s> UP </s>
-0.6021 <s> VOLUME DOWN
-0.6021 <s> VOLUME UP
-0.3010 <s> WHAT TIME
-0.3010 <s> WHATS THE
-0.3010 <s> ZERO </s>
-0.4771 CHANGE THE LIGHTS
-0.7782 CHANGE THE TV
-0.3010 CHANNEL DOWN </s>
-0.3010 CHANNEL UP </s>
-0.3010 CIRCLE BUTTON </s>
-0.3010 IS IT </s>
-0.3010 LIGHTS BLUE </s>
-0.3010 LIGHTS BRIGHTER </s>
-0.3010 LIGHTS DARKER </s>
-0.3010 LIGHTS GREEN </s>
-0.3010 LIGHTS RED </s>
-0.3010 LIGHTS WHITE </s>
-0.3010 OFF THE LIGHTS
-0.3010 ON THE LIGHTS
-0.3010 SELECT ENTER </s>
-0.3010 SELECT LEFT </s>
-0.3010 SELECT RIGHT </s>
-0.3010 SELECT UP </s>
-0.3010 SEXY TIME </s>
-0.9031 THE LIGHTS </s>
-1.2041 THE LIGHTS BLUE
-1.2041 THE LIGHTS BRIGHTER
-1.2041 THE LIGHTS DARKER
-1.2041 THE LIGHTS GREEN
-1.2041 THE LIGHTS RED
-1.2041 THE LIGHTS WHITE
-0.3010 THE TV TO
-0.3010 THE WEATHER </s>
-0.3010 TIME IS IT
-0.3010 TO HBO </s>
-0.3010 TO MTV </s>
-0.3010 TURN OFF THE
-0.3010 TURN ON THE
-0.3010 TURN THE LIGHTS
-0.6021 TV TO HBO
-0.6021 TV TO MTV
-0.3010 VOLUME DOWN </s>
-0.3010 VOLUME UP </s>
-0.3010 WHAT TIME IS
-0.3010 WHATS THE WEATHER

\end\
```


### Live Demo
This video shows the recognizer running in keyword spotting mode, using the dictionary and model mentioned above:

`pocketsphinx_continuous -lm /home/pi/dev/bossjones-github/scarlett/static/speech/lm/1602.lm -dict /home/pi/dev/bossjones-github/scarlett/static/speech/dict/1602.dic -keyphrase "SCARLETT" -kws_threshold 1e-20 -inmic yes`

The purpose is to provide some indication of the recognition speed that can be expected, running PocketSphinx on the Raspberry Pi 2.


# Good question from ColinW

```
ColinW  on November 14, 2015 at 8:56 pm
Great article! Question on how to change the card index on the new Raspbian Jessie.
In Jessie, there is no longer “alsa-base.conf” to set “options snd-usb-audio index=0”.
As best as I can figure, the new config file is now at “/usr/share/alsa/alsa.conf”. Do you know how I would be able to do it there?
Alternatively, is there a way to make PocketSphinx use the mic at index 1?
```


# Is this still valid?

https://bugs.tizen.org/jira/browse/TC-664


# NOTE:
If there is ever concern about env variables messing up how scarlett runs, make sure these are either set/unset, which are defined in postactivate and postdeactivate:

```
export GSTREAMER=1.0
export PI_HOME=/home/pi
export MAIN_DIR=$PI_HOME/dev/bossjones-github/scarlett-dbus-poc
export VIRT_ROOT=$PI_HOME/.virtualenvs/scarlett-dbus-poc
export PKG_CONFIG_PATH=$VIRT_ROOT/lib/pkgconfig
export SCARLETT_CONFIG=$MAIN_DIR/tests/fixtures/.scarlett
export SCARLETT_HMM=$MAIN_DIR/tests/fixtures/model/hmm/en_US/hub4wsj_sc_8k
export SCARLETT_LM=$MAIN_DIR/tests/fixtures/lm/1602.lm
export SCARLETT_DICT=$MAIN_DIR/tests/fixtures/dict/1602.dic
```


#### TEST MICROPHONE
https://www.onlinemictest.com/
http://kinobo.co.uk/support/index.php?sid=126171&lang=en&action=artikel&cat=3&id=12&artlang=en
http://kinobo.co.uk/support/index.php?action=artikel&cat=4&id=18&artlang=en
http://kinobo.co.uk/support/index.php?action=artikel&cat=4&id=14&artlang=en
http://www.kinobo.co.uk/#

# VIRTUALBOX make sure guest can see usb mics
run this on your mac: `ioreg -p IOUSB -w0 -l`

SEE THIS: http://apple.stackexchange.com/questions/170105/list-usb-devices-on-osx-command-line


this will produce something like:

```
○ → ioreg -p IOUSB -w0 | sed 's/[^o]*o //; s/@.*$//' | grep -v '^Root.*'
XHCI Root Hub SS Simulation
XHCI Root Hub USB 2.0 Simulation
USB PnP Sound Device
EHCI Root Hub Simulation
HubDevice
FaceTime HD Camera (Built-in)
EHCI Root Hub Simulation
HubDevice
HubDevice
Apple Internal Keyboard / Trackpad
BRCM20702 Hub
Bluetooth USB Host Controller
```


# DEBUGGING

```
± |master U:3 ?:3 ✗| → gconftool-2 --recursive-list /system/gstreamer
 /system/gstreamer/0.10:
  /system/gstreamer/0.10/default:
   musicaudiosink_description = Default
   audiosrc = autoaudiosrc
   audiosrc_description = Default
   chataudiosink_description = Default
   musicaudiosink = autoaudiosink
   audiosink_description = Default
   visualization = goom
   videosrc = v4l2src
   audiosink = autoaudiosink
   chataudiosink = autoaudiosink
   videosink = autovideosink
 /system/gstreamer/1.0:
  /system/gstreamer/1.0/default:
   audiosink = pulsesink
   audiosrc = pulsesrc
  /system/gstreamer/1.0/audio:
   /system/gstreamer/1.0/audio/profiles:
    /system/gstreamer/1.0/audio/profiles/mp3:
     name = CD Quality, MP3
     extension = mp3
     pipeline = audio/x-raw,rate=44100,channels=2 ! lamemp3enc name=enc target=0 quality=6 ! xingmux ! id3v2mux
     description = Used for converting to CD-quality audio, but with the lossy MP3 codec. Use this for preparing files for copying to devices that only support the MP3 codec. Note that using this format may be illegal in your jurisdiction; contact your lawyer for advice.
     active = true
    /system/gstreamer/1.0/audio/profiles/cdlossless:
     name = CD Quality, Lossless
     extension = flac
     pipeline = audio/x-raw,rate=44100,channels=2 ! flacenc name=enc
     description = Used for converting to CD-quality audio, but with a lossless compression codec. Use this if you later want to edit the file or burn it to CD.
     active = true
    /system/gstreamer/1.0/audio/profiles/mp2:
     name = CD Quality, MP2
     extension = mp2
     pipeline = audio/x-raw,rate=44100,channels=2 ! twolame name=enc mode=0 bitrate=192 ! id3v2mux
     description = Used for converting to CD-quality audio, but with the lossy MP2 codec. Use this for preparing files for copying to devices that only support the MP2 codec. Note that using this format may be illegal in your jurisdiction; contact your lawyer for advice.
     active = true
    /system/gstreamer/1.0/audio/profiles/aac:
     name = CD Quality, AAC
     extension = m4a
     pipeline = audio/x-raw,rate=44100,channels=2 ! faac profile=2 ! ffmux_mp4
     description = Used for converting to CD-quality audio, but with the lossy AAC codec. Use this for preparing files for copying to devices that only support the AAC codec. Note that using this format may be illegal in your jurisdiction; contact your lawyer for advice.
     active = true
    /system/gstreamer/1.0/audio/profiles/voicelossless:
     name = Voice, Lossless
     extension = wav
     pipeline = audio/x-raw,rate=22050,channels=1 ! wavenc name=enc
     description = Used for converting to lossless voice-quality audio. Use this for recording and editing speech.
     active = true
    /system/gstreamer/1.0/audio/profiles/voicelossy:
     name = Voice, Lossy
     extension = spx
     pipeline = audio/x-raw,rate=32000,channels=1 ! speexenc name=enc ! oggmux
     description = Used for converting to lossy voice-quality audio. Use this for recording speech that doesn't need to be edited.
     active = true
    /system/gstreamer/1.0/audio/profiles/cdlossy:
     name = CD Quality, Lossy
     extension = ogg
     pipeline = audio/x-raw,rate=44100,channels=2 ! vorbisenc name=enc quality=0.5 ! oggmux
     description = Used for converting to CD-quality audio, but with a lossy compression codec. Use this for CD extraction and radio recordings.
     active = true
   /system/gstreamer/1.0/audio/global:
    profile_list = [cdlossy,cdlossless,aac,mp2,mp3,voicelossy,voicelossless]

  using virtualenv: scarlett-dbus-poc scarlett-ansible in ~/dev/bossjones-github/scarlett-gstreamer-pocketsphinx-demo
± |master U:3 ?:3 ✗| →
```

# source: https://twitter.com/andolamin/status/661050200614502400
gconftool-2 -t string --set /system/gstreamer/1.0/default/audiosink pulsesink

```
# modified with 1.0
gconftool-2 -t string --set /system/gstreamer/1.0/default/audiosink pulsesink
gconftool-2 -t string --set /system/gstreamer/1.0/default/audiosrc pulsesrc
gconftool-2 -t string --set /system/gstreamer/1.0/default/musicaudiosink pulsesink

# source: http://blog.scphillips.com/posts/2013/01/getting-gstreamer-to-work-on-a-raspberry-pi/
# check the keys are there:
± |master U:3 ?:3 ✗| → gconftool-2 -a /system/gstreamer/1.0/default
 musicaudiosink = pulsesink
 audiosink = pulsesink
 audiosrc = pulsesrc
```


```
# modified with 1.0
gconftool -t string --set /system/gstreamer/1.0/default/audiosink pulsesink
gconftool -t string --set /system/gstreamer/1.0/default/audiosrc pulsesrc
```

```
# gstreamer 0.10
gconftool -t string --set /system/gstreamer/0.10/default/audiosink pulsesink
gconftool -t string --set /system/gstreamer/0.10/default/audiosrc pulsesrc
```

source: http://www.alsa-project.org/main/index.php/Asoundrc

```
The numbers after hw: stand for the soundcard number and device number. This can get confusing as some sound "cards" are better represented by calling them sound "devices", for example USB sounddevices. However they are still "cards" in the sense that they have a specific driver controlling a specific piece of hardware. They also correspond to the index shown in
/proc/asound/cards
As with most arrays the first item usually starts at 0 not 1. This is true for the way pcm devices (physical I/O channels) are represented in ALSA. Starting at pcm0c (capture), pcm0p (playback).
We use subdevices mainly for hardware which can mix several streams together. It is impractical to have 32 devices with exactly the same capabilities. The subdevices can be opened without a specific address, so the first free subdevice is opened. Also, we temporarily use subdevices for hardware with a lot of streams (I/O connectors) — for example MIDI. There are several limits given by used minor numbers (8 PCM devices per card, 8 MIDI devices per card etc.).
For example, to access the first device on the first soundcard/device, you would use
hw:0,0
to access the first device on the second soundcard/device, you would use
hw:1,0
to access the second device on the third soundcard/device, you would use
hw:2,1
```

https://wiki.archlinux.org/index.php/PulseAudio/Configuration


```
echo "libpulse-dev
libpulse-mainloop-glib0
libpulse-mainloop-glib0-dbg
libpulse0
libpulse0-dbg
libsox-fmt-pulse
paman
paprefs
pavucontrol
pavumeter
pulseaudio
pulseaudio-dbg
pulseaudio-esound-compat
pulseaudio-esound-compat-dbg
pulseaudio-module-bluetooth
pulseaudio-module-gconf
pulseaudio-module-jack
pulseaudio-module-lirc
pulseaudio-module-lirc-dbg
pulseaudio-module-x11
pulseaudio-module-zeroconf
pulseaudio-module-zeroconf-dbg
pulseaudio-utils
pavucontrol
avahi-daemon
libtheora-dev
libogg-dev
libvorbis-dev
libasound2-dev
libjack-dev" | sed 's,^,",g' | sed 's,$,",g'
```


```
# COMMANDS THAT FINALLY LET ME RECORD W/ PULSE AUDIO FROM COMMANDLINE

$ pacmd "load-module module-alsa-source source_name=input device=hw:1"

$ pacmd "set-default-source input"

$ pactl stat
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

$ parecord -d input outfile.wav

$ aplay outfile.wav

# IMPORTANT NOTE: IF DEFAULT SOURCE ISNT SET TO HW:1, THIS DOES NOT WORK!
```


# blog post notes

```
UPGRADING FROM POCKETSPHINX 0.8 -> 5prealpha

# what is alsa
# what is pulse audio
# why do we need to configure both
# setting up alsa
# setting up pulseaudio
# other sound frameworks ( Gstreamer ) + how to configure it
# testing alsa works correctly w/ arecord and aplay
# testing pulseaduio works with parecord and paplay
# pocketsphinx install 
# finally running pocketsphinx_continuous

# TERMS
PCM - Pulse-code modulation (PCM) is a method used to digitally represent sampled analog signals. It is the standard form of digital audio in computers, Compact Discs, digital telephony and other digital audio applications.
```

# set usb to default sound device

```

1. To configure the adapter to be card 0, I changed the following line in /etc/modprobe.d/alsa-base.conf from
options snd-usb-audio index=-2
to
options snd-usb-audio index=0

2. REBOOT

3. with /proc/asound/cards now showing the adapter as the default (card 0), I'm able to record audio from the mic input with "arecord -d 5 -r 48000 test.wav" and play it back through the headset output with "aplay test.wav." I used alsamixer to adjust the Speaker output level and the Capture input level.

# NOTE THIS IS WRONG
± |master U:3 ?:6 ✗| → cat /proc/asound/cards
 0 [I82801AAICH    ]: ICH - Intel 82801AA-ICH
                      Intel 82801AA-ICH with AD1980 at irq 21
 1 [Device         ]: USB-Audio - USB PnP Sound Device
                      C-Media Electronics Inc. USB PnP Sound Device at usb-0000:00:1f.4-1, full speed

# NOTE THIS IS RIGHT
± |master U:3 ?:6 ✗| → cat /proc/asound/cards
 0 [Device         ]: USB-Audio - USB PnP Sound Device
                      C-Media Electronics Inc. USB PnP Sound Device at usb-0000:00:1f.4-1, full speed
 1 [I82801AAICH    ]: ICH - Intel 82801AA-ICH
                      Intel 82801AA-ICH with AD1980 at irq 21
```
