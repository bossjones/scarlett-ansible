# scarlett-ansible

## Description

The purpose of this repository is to provision a server with all required Scarlett dependencies via ansible. When finished, we can then verify that everything is in place correctly by using serverspec as a integration testing framework. This repo will also serve as a brain dump for any installation issues we come across while attempting to get GTK+3, Gstreamer 1.0, PyGi, Pocketsphinx 5prealpha, PulseAudio, Alsa and Python to play nicely together. As you can see from the list of dependices, there are A LOT of things to take into consideration when configuring this system properly ... the fact that I did not create this earlier baffles my mind!

## Hardware Requirements
- Microphone: 4 of Kinobo - USB 2.0 Mini Microphone "Makio" Mic for Laptop/Desktop PCs - Skype / VOIP / Voice Recognition Software

```
# NOTE this particular mic is not required, it's just the one i'm using, some values are HARDCODED to this. EG, My mic's name is "USB PnP Sound Device"

# NOTE THIS IS WRONG
± |master U:3 ?:6 ✗| → cat /proc/asound/cards
 0 [I82801AAICH    ]: ICH - Intel 82801AA-ICH
                      Intel 82801AA-ICH with AD1980 at irq 21
 1 [Device         ]: USB-Audio - USB PnP Sound Device
                      C-Media Electronics Inc. USB PnP Sound Device at usb-0000:00:1f.4-1, full speed

```


## Software Requirements

*NOTE: Everything is currently being tested on a Ubuntu 14.04.3 LTS Virtualbox Machine on my Macbook Pro.*
On Macbook Pro:
- Homebrew
- Ruby ( via rbenv )
- Ansible (v1.9.4)
- fswatch ( installed via homebrew ). We will use this to sync files we're working on locally.

## Setup serverspec

Just like how Python recomends the use of virtual environments, we don't want to install any rubygems system wide. `serverspec`, a ruby gem, can be installed locally in a `.vendor` directory. Simply do the following:

```
# install bundler
gem install bundler
# install serverspec and other dependencies
bundle install --path .vendor
# run serverspec tests via rake, similar to make but for ruby
bundle exec rake
```

## How to Provision a Vagrant box

```
# NOTE: I wrapped commands w/ Make mainly due to some weird things I did with this setup. Will clean this up later.

# bring up virtualbox
make vagrant-up

# provision runs ansible
make vagrant-provision

# ssh on to server
make vagrant-ssh

# stop server
make vagrant-halt
```

## How to Provision Scarlett on another machine

Coming soon...

## Helpful links

- https://gist.github.com/GiorgioNatili/ce5647a79ce88cf73a8a
- http://cmusphinx.sourceforge.net/wiki/#advanced_user_documentation
- http://sourceforge.net/p/cmusphinx/discussion/search/?q=Pocketsphinx+listen+for+grammar
- http://sourceforge.net/p/cmusphinx/discussion/help/thread/a7822390/?limit=25#8f38/f5b8/bc40
- https://wolfpaulus.com/journal/embedded/raspberrypi2-sr/
- http://blog.scphillips.com/posts/2013/01/getting-gstreamer-to-work-on-a-raspberry-pi/
- https://wiki.debian.org/PulseAudio

- https://github.com/spk121/burro-engine
- http://cmusphinx.sourceforge.net/wiki/download
- http://cmusphinx.sourceforge.net/wiki/faq#qwhy_my_accuracy_is_poor
- https://github.com/cmusphinx/pocketsphinx/issues/25
- https://blogs.gnome.org/uraeus/2011/10/04/tutorial-for-python-gstreamer-and-gtk-3/
- https://developer.ridgerun.com/wiki/index.php/GStreamer_Debugging
- https://developer.ridgerun.com/wiki/index.php?title=Embedded_GStreamer_Performance_Tuning
- http://docs.gstreamer.com/display/GstSDK/Basic+tutorial+11%3A+Debugging+tools
- http://wiki.buzztrax.org/index.php/Debugging
- http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gst-running.html
- http://gstreamer.freedesktop.org/data/doc/gstreamer/head/manual/html/section-checklist-debug.html
- https://gramps-project.org/wiki/index.php?title=GEPS_029:_GTK3-GObject_introspection_Conversion
- https://wiki.archlinux.org/index.php/PulseAudio/Examples
- https://wiki.archlinux.org/index.php/PulseAudio/Configuration
- http://trac.gateworks.com/wiki/Yocto/gstreamer/audio
- http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html
- https://www.raspberrypi.org/forums/viewtopic.php?f=38&t=37873 *set alsa and save settings*
- https://github.com/ozzyjohnson/ansible-ffmpeg-build/blob/master/build-ffmpeg.yml *good example of how to compile from source in ansible*
- http://cmusphinx.sourceforge.net/wiki/raspberrypi *getting pocketsphinx working on raspbian ( need to add ansible commands for that )*
- https://wolfpaulus.com/journal/embedded/raspberrypi2-sr/ *NOTE: lets update steps... see following:*

## Vagrant commands

*start vagrant server*
`VAGRANT_VAGRANTFILE=Vagrantfile-ansible-test vagrant up`

*provision server*
`VAGRANT_VAGRANTFILE=Vagrantfile-ansible-test vagrant provision`

## Make commands

```
help
list
serverspec
serverspec-diff
serverspec-install
vagrant-destroy
vagrant-halt
vagrant-provision
vagrant-up
```


## Speech Recognition w/ pocketsphinx

*Corpus:* See file `./language_files/base_scarlett.corpus`, which contains a list of words/sentences seperated by new lines that we want recognized by pocketsphinx.

```
# Example Corpus

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
CLOSE THE SHADES
TURN ON BATHROOM LIGHTS
TURN ON WINDOW LIGHTS
TURN ON FAMILY ROOM LIGHTS
TURN ON LIGHTS IN BATHROOM
TURN ON LIGHTS IN FAMILY ROOM
TURN ON LIGHTS IN HALLWAY
TURN ON ALL LIGHTS

```

## Generating new .lm and .dict files from your base corpus

*MANUALLY:*
Upload the text file here: http://www.speech.cs.cmu.edu/tools/lmtool-new.html
and then download the generated Pronunciation Dictionary and Language Model.

*AUTOMATED:*

Simply run `./generate_language_pocketsphinx.sh`. This will automatically upload your corpus to http://www.speech.cs.cmu.edu/tools/lmtool-new.html and download the `.lm` and `.dict` files that get created into `./language_files/lang/`. Their format will look something like `1473.dic` and `1473.lm`. When you finish running the command, you will need to update your `.scarlett` config file. It will also write a file locally called `LANGUAGE_VERSION.txt` which will have an up-to-date # generated by lmtool, eg `1473`.

For the the text file mentioned above, this is what the tool generates:

*1473.lm:*

```
ALL AO L
APPLE AE P AH L
ARE AA R
ARE(2)  ER
BACKWARD  B AE K W ER D
BATHROOM  B AE TH R UW M
BLUE  B L UW
BRIGHTER  B R AY T ER
BUTTON  B AH T AH N
CANCEL  K AE N S AH L
CHANGE  CH EY N JH
CHANNEL CH AE N AH L
CIRCLE  S ER K AH L
CLOSE K L OW S
CLOSE(2)  K L OW Z
DARKER  D AA R K ER
DOWN  D AW N
EIGHT EY T
ENTER EH N T ER
ENTER(2)  EH N ER
FAMILY  F AE M AH L IY
FAMILY(2) F AE M L IY
FIVE  F AY V
FORWARD F AO R W ER D
FOUR  F AO R
FRIZZY  F R IH Z IY
GET G EH T
GET(2)  G IH T
GIVE  G IH V
GO  G OW
GREEN G R IY N
HALLWAY HH AO L W EY
HBO EY CH B IY OW
IDS AY D IY Z
IDS(2)  IH D Z
IN  IH N
INPUT IH N P UH T
IS  IH Z
IT  IH T
LEFT  L EH F T
LIGHT L AY T
LIGHTS  L AY T S
ME  M IY
MENU  M EH N Y UW
MTV EH M T IY V IY
MUTE  M Y UW T
MY  M AY
NAMES N EY M Z
NEGATIVE  N EH G AH T IH V
NINE  N AY N
OF  AH V
OFF AO F
ON  AA N
ON(2) AO N
ONE W AH N
ONE(2)  HH W AH N
PAUSE P AO Z
PLAY  P L EY
POWER P AW ER
RECALL  R IY K AO L
RECALL(2) R IH K AO L
RED R EH D
RIGHT R AY T
ROOM  R UW M
SCARLETT  S K AA R L IH T
SELECT  S AH L EH K T
SEVEN S EH V AH N
SEXY  S EH K S IY
SHADES  SH EY D Z
SIX S IH K S
STOP  S T AA P
THE DH AH
THE(2)  DH IY
THREE TH R IY
TIME  T AY M
TO  T UW
TO(2) T IH
TO(3) T AH
TOSHIBA T OW SH IY B AH
TURN  T ER N
TV  T IY V IY
TV(2) T EH L AH V IH ZH AH N
TWO T UW
UP  AH P
VOLUME  V AA L Y UW M
WEATHER W EH DH ER
WHAT  W AH T
WHAT(2) HH W AH T
WHATS W AH T S
WHATS(2)  HH W AH T S
WHITE W AY T
WHITE(2)  HH W AY T
WINDOW  W IH N D OW
ZERO  Z IY R OW
```


language model:

```
Language model created by QuickLM on Sat Jan  2 12:51:32 EST 2016
Copyright (c) 1996-2010 Carnegie Mellon University and Alexander I. Rudnicky

The model is in standard ARPA format, designed by Doug Paul while he was at MITRE.

The code that was used to produce this language model is available in Open Source.
Please visit http://www.speech.cs.cmu.edu/tools/ for more information

The (fixed) discount mass is 0.5. The backoffs are computed using the ratio method.
This model based on a corpus of 70 sentences and 80 words

\data\
ngram 1=80
ngram 2=155
ngram 3=128

\1-grams:
-0.9301 </s> -0.3010
-0.9301 <s> -0.2393
-2.7752 ALL -0.2892
-2.7752 APPLE -0.2468
-2.7752 ARE -0.2915
-2.7752 BACKWARD -0.2468
-2.4742 BATHROOM -0.2334
-2.7752 BLUE -0.2468
-2.7752 BRIGHTER -0.2468
-2.7752 BUTTON -0.2468
-2.7752 CANCEL -0.2468
-1.9971 CHANGE -0.2915
-2.4742 CHANNEL -0.2944
-2.7752 CIRCLE -0.3003
-2.7752 CLOSE -0.2915
-2.7752 DARKER -0.2468
-2.1732 DOWN -0.2468
-2.7752 EIGHT -0.2468
-2.7752 ENTER -0.2468
-2.4742 FAMILY -0.2996
-2.7752 FIVE -0.2468
-2.7752 FORWARD -0.2468
-2.7752 FOUR -0.2468
-2.7752 FRIZZY -0.2468
-2.4742 GET -0.2988
-2.7752 GIVE -0.3003
-2.7752 GO -0.2468
-2.7752 GREEN -0.2468
-2.7752 HALLWAY -0.2468
-2.7752 HBO -0.2468
-2.7752 IDS -0.2468
-2.2981 IN -0.2974
-2.7752 INPUT -0.2468
-2.7752 IS -0.3003
-2.7752 IT -0.2468
-2.2981 LEFT -0.2468
-2.2981 LIGHT -0.2981
-1.5711 LIGHTS -0.2393
-2.7752 ME -0.2988
-2.7752 MENU -0.2468
-2.7752 MTV -0.2468
-2.7752 MUTE -0.2468
-2.7752 MY -0.2892
-2.2981 NAMES -0.2459
-2.7752 NEGATIVE -0.2468
-2.7752 NINE -0.2468
-2.7752 OF -0.3003
-2.7752 OFF -0.2915
-1.8722 ON -0.2747
-2.7752 ONE -0.2468
-2.7752 PAUSE -0.2468
-2.7752 PLAY -0.2468
-2.7752 POWER -0.2468
-2.7752 RECALL -0.2468
-2.7752 RED -0.2468
-2.2981 RIGHT -0.2468
-2.4742 ROOM -0.2334
-2.7752 SCARLETT -0.2468
-2.1732 SELECT -0.2922
-2.7752 SEVEN -0.2468
-2.7752 SEXY -0.2996
-2.7752 SHADES -0.2468
-2.7752 SIX -0.2468
-2.7752 STOP -0.2468
-1.6613 THE -0.2832
-2.7752 THREE -0.2468
-2.4742 TIME -0.2459
-2.4742 TO -0.2996
-2.7752 TOSHIBA -0.2468
-1.7339 TURN -0.2847
-2.2981 TV -0.2451
-2.7752 TWO -0.2468
-2.0763 UP -0.2468
-2.4742 VOLUME -0.2944
-2.7752 WEATHER -0.2468
-2.4742 WHAT -0.2988
-2.7752 WHATS -0.2915
-2.7752 WHITE -0.2468
-2.7752 WINDOW -0.2892
-2.7752 ZERO -0.2468

\2-grams:
-2.1461 <s> APPLE 0.0000
-2.1461 <s> BACKWARD 0.0000
-2.1461 <s> CANCEL 0.0000
-1.3680 <s> CHANGE 0.0000
-1.8451 <s> CHANNEL 0.0000
-2.1461 <s> CIRCLE 0.0000
-2.1461 <s> CLOSE 0.0000
-1.8451 <s> DOWN 0.0000
-2.1461 <s> EIGHT 0.0000
-2.1461 <s> FIVE 0.0000
-2.1461 <s> FORWARD 0.0000
-2.1461 <s> FOUR 0.0000
-2.1461 <s> FRIZZY 0.0000
-1.8451 <s> GET 0.0000
-2.1461 <s> GIVE 0.0000
-2.1461 <s> GO 0.0000
-2.1461 <s> INPUT 0.0000
-1.8451 <s> LEFT 0.0000
-2.1461 <s> MENU 0.0000
-2.1461 <s> MUTE 0.0000
-2.1461 <s> NEGATIVE 0.0000
-2.1461 <s> NINE 0.0000
-2.1461 <s> ONE 0.0000
-2.1461 <s> PAUSE 0.0000
-2.1461 <s> PLAY 0.0000
-2.1461 <s> POWER 0.0000
-2.1461 <s> RECALL 0.0000
-1.8451 <s> RIGHT 0.0000
-2.1461 <s> SCARLETT 0.0000
-1.5441 <s> SELECT 0.0000
-2.1461 <s> SEVEN 0.0000
-2.1461 <s> SEXY 0.0000
-2.1461 <s> SIX 0.0000
-2.1461 <s> STOP 0.0000
-2.1461 <s> THREE 0.0000
-2.1461 <s> TOSHIBA 0.0000
-1.1047 <s> TURN 0.0000
-2.1461 <s> TV -0.2218
-2.1461 <s> TWO 0.0000
-1.8451 <s> UP 0.0000
-1.8451 <s> VOLUME 0.0000
-1.8451 <s> WHAT 0.0000
-2.1461 <s> WHATS 0.0000
-2.1461 <s> ZERO 0.0000
-0.3010 ALL LIGHTS -0.1938
-0.3010 APPLE </s> -0.3010
-0.3010 ARE THE -0.2840
-0.3010 BACKWARD </s> -0.3010
-0.6021 BATHROOM </s> -0.3010
-0.6021 BATHROOM LIGHTS -0.1938
-0.3010 BLUE </s> -0.3010
-0.3010 BRIGHTER </s> -0.3010
-0.3010 BUTTON </s> -0.3010
-0.3010 CANCEL </s> -0.3010
-0.3010 CHANGE THE -0.0902
-0.6021 CHANNEL DOWN 0.0000
-0.6021 CHANNEL UP 0.0000
-0.3010 CIRCLE BUTTON 0.0000
-0.3010 CLOSE THE -0.2840
-0.3010 DARKER </s> -0.3010
-0.3010 DOWN </s> -0.3010
-0.3010 EIGHT </s> -0.3010
-0.3010 ENTER </s> -0.3010
-0.3010 FAMILY ROOM 0.0000
-0.3010 FIVE </s> -0.3010
-0.3010 FORWARD </s> -0.3010
-0.3010 FOUR </s> -0.3010
-0.3010 FRIZZY </s> -0.3010
-0.3010 GET LIGHT 0.0000
-0.3010 GIVE ME 0.0000
-0.3010 GO </s> -0.3010
-0.3010 GREEN </s> -0.3010
-0.3010 HALLWAY </s> -0.3010
-0.3010 HBO </s> -0.3010
-0.3010 IDS </s> -0.3010
-0.7782 IN BATHROOM -0.1761
-0.7782 IN FAMILY 0.0000
-0.7782 IN HALLWAY 0.0000
-0.3010 INPUT </s> -0.3010
-0.3010 IS IT 0.0000
-0.3010 IT </s> -0.3010
-0.3010 LEFT </s> -0.3010
-0.7782 LIGHT IDS 0.0000
-0.4771 LIGHT NAMES -0.1249
-0.6601 LIGHTS </s> -0.3010
-1.5051 LIGHTS BLUE 0.0000
-1.5051 LIGHTS BRIGHTER 0.0000
-1.5051 LIGHTS DARKER 0.0000
-1.5051 LIGHTS GREEN 0.0000
-1.0280 LIGHTS IN 0.0000
-1.5051 LIGHTS RED 0.0000
-1.5051 LIGHTS WHITE 0.0000
-0.3010 ME LIGHT -0.1249
-0.3010 MENU </s> -0.3010
-0.3010 MTV </s> -0.3010
-0.3010 MUTE </s> -0.3010
-0.3010 MY LIGHTS -0.1938
-0.4771 NAMES </s> -0.3010
-0.7782 NAMES OF 0.0000
-0.3010 NEGATIVE </s> -0.3010
-0.3010 NINE </s> -0.3010
-0.3010 OF MY 0.0000
-0.3010 OFF THE -0.1413
-1.2041 ON ALL 0.0000
-1.2041 ON BATHROOM -0.1761
-1.2041 ON FAMILY 0.0000
-0.7270 ON LIGHTS -0.2583
-1.2041 ON THE -0.1413
-1.2041 ON WINDOW 0.0000
-0.3010 ONE </s> -0.3010
-0.3010 PAUSE </s> -0.3010
-0.3010 PLAY </s> -0.3010
-0.3010 POWER </s> -0.3010
-0.3010 RECALL </s> -0.3010
-0.3010 RED </s> -0.3010
-0.3010 RIGHT </s> -0.3010
-0.6021 ROOM </s> -0.3010
-0.6021 ROOM LIGHTS -0.1938
-0.3010 SCARLETT </s> -0.3010
-0.9031 SELECT ENTER 0.0000
-0.9031 SELECT LEFT 0.0000
-0.9031 SELECT RIGHT 0.0000
-0.9031 SELECT UP 0.0000
-0.3010 SEVEN </s> -0.3010
-0.3010 SEXY TIME -0.1761
-0.3010 SHADES </s> -0.3010
-0.3010 SIX </s> -0.3010
-0.3010 STOP </s> -0.3010
-0.5119 THE LIGHTS -0.0746
-1.4150 THE NAMES -0.2218
-1.4150 THE SHADES 0.0000
-1.1139 THE TV -0.1249
-1.4150 THE WEATHER 0.0000
-0.3010 THREE </s> -0.3010
-0.6021 TIME </s> -0.3010
-0.6021 TIME IS 0.0000
-0.6021 TO HBO 0.0000
-0.6021 TO MTV 0.0000
-0.3010 TOSHIBA </s> -0.3010
-1.3424 TURN OFF 0.0000
-0.4393 TURN ON 0.0000
-1.0414 TURN THE -0.1413
-0.7782 TV </s> -0.3010
-0.4771 TV TO 0.0000
-0.3010 TWO </s> -0.3010
-0.3010 UP </s> -0.3010
-0.6021 VOLUME DOWN 0.0000
-0.6021 VOLUME UP 0.0000
-0.3010 WEATHER </s> -0.3010
-0.6021 WHAT ARE 0.0000
-0.6021 WHAT TIME -0.1761
-0.3010 WHATS THE -0.2840
-0.3010 WHITE </s> -0.3010
-0.3010 WINDOW LIGHTS -0.1938
-0.3010 ZERO </s> -0.3010

\3-grams:
-0.3010 <s> APPLE </s>
-0.3010 <s> BACKWARD </s>
-0.3010 <s> CANCEL </s>
-0.3010 <s> CHANGE THE
-0.6021 <s> CHANNEL DOWN
-0.6021 <s> CHANNEL UP
-0.3010 <s> CIRCLE BUTTON
-0.3010 <s> CLOSE THE
-0.3010 <s> DOWN </s>
-0.3010 <s> EIGHT </s>
-0.3010 <s> FIVE </s>
-0.3010 <s> FORWARD </s>
-0.3010 <s> FOUR </s>
-0.3010 <s> FRIZZY </s>
-0.3010 <s> GET LIGHT
-0.3010 <s> GIVE ME
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
-1.3424 <s> TURN OFF
-0.4393 <s> TURN ON
-1.0414 <s> TURN THE
-0.3010 <s> TV </s>
-0.3010 <s> TWO </s>
-0.3010 <s> UP </s>
-0.6021 <s> VOLUME DOWN
-0.6021 <s> VOLUME UP
-0.6021 <s> WHAT ARE
-0.6021 <s> WHAT TIME
-0.3010 <s> WHATS THE
-0.3010 <s> ZERO </s>
-0.3010 ALL LIGHTS </s>
-0.3010 ARE THE NAMES
-0.3010 BATHROOM LIGHTS </s>
-0.4771 CHANGE THE LIGHTS
-0.7782 CHANGE THE TV
-0.3010 CHANNEL DOWN </s>
-0.3010 CHANNEL UP </s>
-0.3010 CIRCLE BUTTON </s>
-0.3010 CLOSE THE SHADES
-0.6021 FAMILY ROOM </s>
-0.6021 FAMILY ROOM LIGHTS
-0.6021 GET LIGHT IDS
-0.6021 GET LIGHT NAMES
-0.3010 GIVE ME LIGHT
-0.3010 IN BATHROOM </s>
-0.3010 IN FAMILY ROOM
-0.3010 IN HALLWAY </s>
-0.3010 IS IT </s>
-0.3010 LIGHT IDS </s>
-0.3010 LIGHT NAMES </s>
-0.3010 LIGHTS BLUE </s>
-0.3010 LIGHTS BRIGHTER </s>
-0.3010 LIGHTS DARKER </s>
-0.3010 LIGHTS GREEN </s>
-0.7782 LIGHTS IN BATHROOM
-0.7782 LIGHTS IN FAMILY
-0.7782 LIGHTS IN HALLWAY
-0.3010 LIGHTS RED </s>
-0.3010 LIGHTS WHITE </s>
-0.3010 ME LIGHT NAMES
-0.3010 MY LIGHTS </s>
-0.3010 NAMES OF MY
-0.3010 OF MY LIGHTS
-0.3010 OFF THE LIGHTS
-0.3010 ON ALL LIGHTS
-0.3010 ON BATHROOM LIGHTS
-0.3010 ON FAMILY ROOM
-0.3010 ON LIGHTS IN
-0.3010 ON THE LIGHTS
-0.3010 ON WINDOW LIGHTS
-0.3010 ROOM LIGHTS </s>
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
-0.3010 THE NAMES OF
-0.3010 THE SHADES </s>
-0.3010 THE TV TO
-0.3010 THE WEATHER </s>
-0.3010 TIME IS IT
-0.3010 TO HBO </s>
-0.3010 TO MTV </s>
-0.3010 TURN OFF THE
-1.2041 TURN ON ALL
-1.2041 TURN ON BATHROOM
-1.2041 TURN ON FAMILY
-0.7270 TURN ON LIGHTS
-1.2041 TURN ON THE
-1.2041 TURN ON WINDOW
-0.3010 TURN THE LIGHTS
-0.6021 TV TO HBO
-0.6021 TV TO MTV
-0.3010 VOLUME DOWN </s>
-0.3010 VOLUME UP </s>
-0.3010 WHAT ARE THE
-0.3010 WHAT TIME IS
-0.3010 WHATS THE WEATHER
-0.3010 WINDOW LIGHTS </s>

\end\
```


## Test out pocketsphinx_continuous after compiling
This video shows the recognizer running in keyword spotting mode, using the dictionary and model mentioned above:

`pocketsphinx_continuous -lm /home/pi/dev/bossjones-github/scarlett/static/speech/lm/1602.lm -dict /home/pi/dev/bossjones-github/scarlett/static/speech/dict/1602.dic -keyphrase "SCARLETT" -kws_threshold 1e-20 -inmic yes`

The purpose is to provide some indication of the recognition speed that can be expected, running PocketSphinx on the Raspberry Pi 2.


## Good question from ColinW re: Alsa

```
ColinW  on November 14, 2015 at 8:56 pm
Great article! Question on how to change the card index on the new Raspbian Jessie.
In Jessie, there is no longer “alsa-base.conf” to set “options snd-usb-audio index=0”.
As best as I can figure, the new config file is now at “/usr/share/alsa/alsa.conf”. Do you know how I would be able to do it there?
Alternatively, is there a way to make PocketSphinx use the mic at index 1?
```


*Is this bug still valid?*
- https://bugs.tizen.org/jira/browse/TC-664


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


## LINKS TO HELP WITH TESTING YOUR MICROPHONE
- https://www.onlinemictest.com/
- http://kinobo.co.uk/support/index.php?sid=126171&lang=en&action=artikel&cat=3&id=12&artlang=en
- http://kinobo.co.uk/support/index.php?action=artikel&cat=4&id=18&artlang=en
- http://kinobo.co.uk/support/index.php?action=artikel&cat=4&id=14&artlang=en
- http://www.kinobo.co.uk/#
- https://wiki.archlinux.org/index.php/PulseAudio/Configuration
- http://apple.stackexchange.com/questions/170105/list-usb-devices-on-osx-command-line
- http://www.alsa-project.org/main/index.php/Asoundrc

## VIRTUALBOX make sure guest can see usb mics ( MAC OS X ONLY)
Run this on your mac: `ioreg -p IOUSB -w0 -l`

*This will produce something like:*

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


## DEBUGGING Gstreamer and PulseAudio

*Figure out if Gstreamer is configued to use pulseaudio:*
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

*source:* https://twitter.com/andolamin/status/661050200614502400

`gconftool-2 -t string --set /system/gstreamer/1.0/default/audiosink pulsesink`

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
# OLD WAY OF DOING THIS gstreamer 0.10
gconftool -t string --set /system/gstreamer/0.10/default/audiosink pulsesink
gconftool -t string --set /system/gstreamer/0.10/default/audiosrc pulsesrc
```

*Source:* 
- http://www.alsa-project.org/main/index.php/Asoundrc

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

*Generic bash magic:*
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


## blog post notes

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

# GSTREAMER 1.0 + POCKETSPHINX 5prealpha WORKING IN a gst-launch-1.0 pipeline

```
  using virtualenv: scarlett-dbus-poc scarlett-ansible in ~/dev/bossjones-github/scarlett-gstreamer-pocketsphinx-demo
± |master U:3 ?:12 ✗| → gst-launch-1.0 -m alsasrc device=plughw:CARD=Device,DEV=0 ! \
>     queue leaky=2 ! \
>     audioconvert ! \
>     audioresample ! \
>     "audio/x-raw,format=S16LE,channels=1,layout=interleaved" ! \
>     pocketsphinx name=asr \
>     bestpath=0 \
>     hmm=/home/pi/.virtualenvs/scarlett-dbus-poc/share/pocketsphinx/model/en-us/en-us \
>     lm=~/dev/bossjones-github/scarlett-gstreamer-pocketsphinx-demo/1473.lm \
>     dict=~/dev/bossjones-github/scarlett-gstreamer-pocketsphinx-demo/1473.dic ! \
>     queue leaky=2 ! \
>     fakesink
Setting pipeline to PAUSED ...
Current configuration:
[NAME]      [DEFLT]   [VALUE]
-agc      none    none
-agcthresh    2.0   2.000000e+00
-allphone
-allphone_ci    no    no
-alpha      0.97    9.700000e-01
-ascale     20.0    2.000000e+01
-aw     1   1
-backtrace    no    no
-beam     1e-48   1.000000e-48
-bestpath   yes   no
-bestpathlw   9.5   9.500000e+00
-ceplen     13    13
-cmn      current   current
-cmninit    8.0   40,3,-1
-compallsen   no    no
-debug          0
-dict         /home/pi/dev/bossjones-github/scarlett-gstreamer-pocketsphinx-demo/1473.dic
-dictcase   no    no
-dither     no    no
-doublebw   no    no
-ds     1   1
-fdict
-feat     1s_c_d_dd 1s_c_d_dd
-featparams
-fillprob   1e-8    1.000000e-08
-frate      100   100
-fsg
-fsgusealtpron    yes   yes
-fsgusefiller   yes   yes
-fwdflat    yes   yes
-fwdflatbeam    1e-64   1.000000e-64
-fwdflatefwid   4   4
-fwdflatlw    8.5   8.500000e+00
-fwdflatsfwin   25    25
-fwdflatwbeam   7e-29   7.000000e-29
-fwdtree    yes   yes
-hmm          /home/pi/.virtualenvs/scarlett-dbus-poc/share/pocketsphinx/model/en-us/en-us
-input_endian   little    little
-jsgf
-keyphrase
-kws
-kws_delay    10    10
-kws_plp    1e-1    1.000000e-01
-kws_threshold    1   1.000000e+00
-latsize    5000    5000
-lda
-ldadim     0   0
-lifter     0   22
-lm         /home/pi/dev/bossjones-github/scarlett-gstreamer-pocketsphinx-demo/1473.lm
-lmctl
-lmname
-logbase    1.0001    1.000100e+00
-logfn
-logspec    no    no
-lowerf     133.33334 1.300000e+02
-lpbeam     1e-40   1.000000e-40
-lponlybeam   7e-29   7.000000e-29
-lw     6.5   6.500000e+00
-maxhmmpf   30000   30000
-maxwpf     -1    -1
-mdef
-mean
-mfclogdir
-min_endfr    0   0
-mixw
-mixwfloor    0.0000001 1.000000e-07
-mllr
-mmap     yes   yes
-ncep     13    13
-nfft     512   512
-nfilt      40    25
-nwpen      1.0   1.000000e+00
-pbeam      1e-48   1.000000e-48
-pip      1.0   1.000000e+00
-pl_beam    1e-10   1.000000e-10
-pl_pbeam   1e-10   1.000000e-10
-pl_pip     1.0   1.000000e+00
-pl_weight    3.0   3.000000e+00
-pl_window    5   5
-rawlogdir
-remove_dc    no    no
-remove_noise   yes   yes
-remove_silence   yes   yes
-round_filters    yes   yes
-samprate   16000   1.600000e+04
-seed     -1    -1
-sendump
-senlogdir
-senmgau
-silprob    0.005   5.000000e-03
-smoothspec   no    no
-svspec         0-12/13-25/26-38
-tmat
-tmatfloor    0.0001    1.000000e-04
-topn     4   4
-topn_beam    0   0
-toprule
-transform    legacy    dct
-unit_area    yes   yes
-upperf     6855.4976 6.800000e+03
-uw     1.0   1.000000e+00
-vad_postspeech   50    50
-vad_prespeech    20    20
-vad_startspeech  10    10
-vad_threshold    2.0   2.000000e+00
-var
-varfloor   0.0001    1.000000e-04
-varnorm    no    no
-verbose    no    no
-warp_params
-warp_type    inverse_linear  inverse_linear
-wbeam      7e-29   7.000000e-29
-wip      0.65    6.500000e-01
-wlen     0.025625  2.562500e-02

Pipeline is live and does not need PREROLL ...
Got message #23 from element "fakesink0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_NULL, new-state=(GstState)GST_STATE_READY, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #24 from element "queue1" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_NULL, new-state=(GstState)GST_STATE_READY, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #25 from element "asr" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_NULL, new-state=(GstState)GST_STATE_READY, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #26 from element "capsfilter0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_NULL, new-state=(GstState)GST_STATE_READY, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #27 from element "audioresample0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_NULL, new-state=(GstState)GST_STATE_READY, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #28 from element "audioconvert0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_NULL, new-state=(GstState)GST_STATE_READY, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #29 from element "queue0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_NULL, new-state=(GstState)GST_STATE_READY, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #30 from element "alsasrc0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_NULL, new-state=(GstState)GST_STATE_READY, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #31 from element "pipeline0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_NULL, new-state=(GstState)GST_STATE_READY, pending-state=(GstState)GST_STATE_PAUSED;
Got message #33 from pad "queue1:src" (stream-status): GstMessageStreamStatus, type=(GstStreamStatusType)GST_STREAM_STATUS_TYPE_CREATE, owner=(GstElement)"\(GstQueue\)\ queue1", object=(GstTask)"\(GstTask\)\ queue1:src";
Got message #34 from element "queue1" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_READY, new-state=(GstState)GST_STATE_PAUSED, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #35 from element "asr" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_READY, new-state=(GstState)GST_STATE_PAUSED, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #36 from element "capsfilter0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_READY, new-state=(GstState)GST_STATE_PAUSED, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #37 from element "audioresample0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_READY, new-state=(GstState)GST_STATE_PAUSED, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #38 from element "audioconvert0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_READY, new-state=(GstState)GST_STATE_PAUSED, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #39 from pad "queue0:src" (stream-status): GstMessageStreamStatus, type=(GstStreamStatusType)GST_STREAM_STATUS_TYPE_CREATE, owner=(GstElement)"\(GstQueue\)\ queue0", object=(GstTask)"\(GstTask\)\ queue0:src";
Got message #40 from element "queue0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_READY, new-state=(GstState)GST_STATE_PAUSED, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #41 from pad "queue1:src" (stream-status): GstMessageStreamStatus, type=(GstStreamStatusType)GST_STREAM_STATUS_TYPE_ENTER, owner=(GstElement)"\(GstQueue\)\ queue1", object=(GstTask)"\(GstTask\)\ queue1:src";
Got message #42 from pad "queue0:src" (stream-status): GstMessageStreamStatus, type=(GstStreamStatusType)GST_STREAM_STATUS_TYPE_ENTER, owner=(GstElement)"\(GstQueue\)\ queue0", object=(GstTask)"\(GstTask\)\ queue0:src";
Got message #46 from pad "alsasrc0:src" (stream-status): GstMessageStreamStatus, type=(GstStreamStatusType)GST_STREAM_STATUS_TYPE_CREATE, owner=(GstElement)"\(GstAlsaSrc\)\ alsasrc0", object=(GstTask)"\(GstTask\)\ alsasrc0:src";
Got message #47 from element "alsasrc0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_READY, new-state=(GstState)GST_STATE_PAUSED, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #48 from element "pipeline0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_READY, new-state=(GstState)GST_STATE_PAUSED, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #49 from pad "alsasrc0:src" (stream-status): GstMessageStreamStatus, type=(GstStreamStatusType)GST_STREAM_STATUS_TYPE_ENTER, owner=(GstElement)"\(GstAlsaSrc\)\ alsasrc0", object=(GstTask)"\(GstTask\)\ alsasrc0:src";
Got message #50 from element "pipeline0" (stream-start): GstMessageStreamStart, group-id=(uint)0;
Setting pipeline to PLAYING ...
Got message #53 from element "pipeline0" (new-clock): GstMessageNewClock, clock=(GstClock)"\(GstAudioClock\)\ GstAudioSrcClock";
New clock: GstAudioSrcClock
Got message #55 from element "queue1" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_PAUSED, new-state=(GstState)GST_STATE_PLAYING, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #56 from element "asr" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_PAUSED, new-state=(GstState)GST_STATE_PLAYING, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #57 from element "capsfilter0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_PAUSED, new-state=(GstState)GST_STATE_PLAYING, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #58 from element "audioresample0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_PAUSED, new-state=(GstState)GST_STATE_PLAYING, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #59 from element "audioconvert0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_PAUSED, new-state=(GstState)GST_STATE_PLAYING, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #60 from element "queue0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_PAUSED, new-state=(GstState)GST_STATE_PLAYING, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #61 from element "alsasrc0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_PAUSED, new-state=(GstState)GST_STATE_PLAYING, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #62 from object "audiosrcringbuffer0" (stream-status): GstMessageStreamStatus, type=(GstStreamStatusType)GST_STREAM_STATUS_TYPE_ENTER, owner=(GstElement)"\(GstAlsaSrc\)\ alsasrc0", object=(GThread)NULL;
Got message #69 from element "asr" (element): pocketsphinx, timestamp=(guint64)940000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)SIX;
Got message #70 from element "asr" (element): pocketsphinx, timestamp=(guint64)980000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)TO;
Got message #71 from element "asr" (element): pocketsphinx, timestamp=(guint64)1030000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)TURN;
Got message #72 from element "asr" (element): pocketsphinx, timestamp=(guint64)1270000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"TURN\ IS";
Got message #73 from element "asr" (element): pocketsphinx, timestamp=(guint64)1400000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"TURN\ IS\ IT";
Got message #74 from element "asr" (element): pocketsphinx, timestamp=(guint64)1500000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"TURN\ IS\ IT\ GO";
Got message #75 from element "asr" (element): pocketsphinx, timestamp=(guint64)1640000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"TURN\ IS\ IT\ TURN";
Got message #76 from element "asr" (element): pocketsphinx, timestamp=(guint64)18446744073709551615, final=(boolean)true, confidence=(glong)0, hypothesis=(string)"TURN\ IS\ IT\ TURN";
Got message #77 from element "fakesink0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_READY, new-state=(GstState)GST_STATE_PAUSED, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #79 from element "pipeline0" (async-done): GstMessageAsyncDone, running-time=(guint64)18446744073709551615;
Got message #81 from element "fakesink0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_PAUSED, new-state=(GstState)GST_STATE_PLAYING, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #82 from element "pipeline0" (state-changed): GstMessageStateChanged, old-state=(GstState)GST_STATE_PAUSED, new-state=(GstState)GST_STATE_PLAYING, pending-state=(GstState)GST_STATE_VOID_PENDING;
Got message #83 from element "asr" (element): pocketsphinx, timestamp=(guint64)5320000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)EIGHT;
Got message #84 from element "asr" (element): pocketsphinx, timestamp=(guint64)5580000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)THE;
Got message #85 from element "asr" (element): pocketsphinx, timestamp=(guint64)6270000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)PAUSE;
Got message #86 from element "asr" (element): pocketsphinx, timestamp=(guint64)6290000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)ON;
Got message #87 from element "asr" (element): pocketsphinx, timestamp=(guint64)6730000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"ON\ GET";
Got message #88 from element "asr" (element): pocketsphinx, timestamp=(guint64)18446744073709551615, final=(boolean)true, confidence=(glong)0, hypothesis=(string)GET;
Got message #89 from element "asr" (element): pocketsphinx, timestamp=(guint64)8870000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)GET;
Got message #90 from element "asr" (element): pocketsphinx, timestamp=(guint64)9150000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)ONE;
Got message #91 from element "asr" (element): pocketsphinx, timestamp=(guint64)9450000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)WHAT;
Got message #92 from element "asr" (element): pocketsphinx, timestamp=(guint64)18446744073709551615, final=(boolean)true, confidence=(glong)0, hypothesis=(string)WHAT;
Got message #93 from element "asr" (element): pocketsphinx, timestamp=(guint64)11830000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)THE;
Got message #94 from element "asr" (element): pocketsphinx, timestamp=(guint64)11870000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)TV;
Got message #95 from element "asr" (element): pocketsphinx, timestamp=(guint64)12070000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)THE;
Got message #96 from element "asr" (element): pocketsphinx, timestamp=(guint64)12080000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)TV;
Got message #97 from element "asr" (element): pocketsphinx, timestamp=(guint64)12470000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)THE;
Got message #98 from element "asr" (element): pocketsphinx, timestamp=(guint64)12650000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"THE\ WHAT";
Got message #99 from element "asr" (element): pocketsphinx, timestamp=(guint64)12690000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"THE\ WHITE";
Got message #100 from element "asr" (element): pocketsphinx, timestamp=(guint64)12750000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"THE\ PLAY";
Got message #101 from element "asr" (element): pocketsphinx, timestamp=(guint64)12770000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"THE\ WHITE";
Got message #102 from element "asr" (element): pocketsphinx, timestamp=(guint64)18446744073709551615, final=(boolean)true, confidence=(glong)0, hypothesis=(string)"THE\ WHITE";
Got message #103 from element "asr" (element): pocketsphinx, timestamp=(guint64)13980000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)EIGHT;
Got message #104 from element "asr" (element): pocketsphinx, timestamp=(guint64)14040000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)TO;
Got message #105 from element "asr" (element): pocketsphinx, timestamp=(guint64)14090000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)TURN;
Got message #106 from element "asr" (element): pocketsphinx, timestamp=(guint64)14120000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)ZERO;
Got message #107 from element "asr" (element): pocketsphinx, timestamp=(guint64)14140000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)TURN;
Got message #108 from element "asr" (element): pocketsphinx, timestamp=(guint64)14170000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)ZERO;
Got message #109 from element "asr" (element): pocketsphinx, timestamp=(guint64)14320000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)SCARLETT;
Got message #110 from element "asr" (element): pocketsphinx, timestamp=(guint64)18446744073709551615, final=(boolean)true, confidence=(glong)0, hypothesis=(string)SCARLETT;
Got message #111 from element "asr" (element): pocketsphinx, timestamp=(guint64)19840000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)FOUR;
Got message #112 from element "asr" (element): pocketsphinx, timestamp=(guint64)19870000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)WHAT;
Got message #113 from element "asr" (element): pocketsphinx, timestamp=(guint64)19900000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)ONE;
Got message #114 from element "asr" (element): pocketsphinx, timestamp=(guint64)19910000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)WHAT;
Got message #115 from element "asr" (element): pocketsphinx, timestamp=(guint64)20220000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"WHAT\ TIME";
Got message #116 from element "asr" (element): pocketsphinx, timestamp=(guint64)20230000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"WHAT\ TIME\ IS";
Got message #117 from element "asr" (element): pocketsphinx, timestamp=(guint64)20370000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"WHAT\ TIME\ IS\ IT";
Got message #118 from element "asr" (element): pocketsphinx, timestamp=(guint64)18446744073709551615, final=(boolean)true, confidence=(glong)0, hypothesis=(string)"WHAT\ TIME\ IS\ IT";
Got message #119 from element "asr" (element): pocketsphinx, timestamp=(guint64)22940000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)TURN;
Got message #120 from element "asr" (element): pocketsphinx, timestamp=(guint64)22950000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)FRIZZY;
Got message #121 from element "asr" (element): pocketsphinx, timestamp=(guint64)22980000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)TURN;
Got message #122 from element "asr" (element): pocketsphinx, timestamp=(guint64)23050000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)ENTER;
Got message #123 from element "asr" (element): pocketsphinx, timestamp=(guint64)23070000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"TURN\ ON";
Got message #124 from element "asr" (element): pocketsphinx, timestamp=(guint64)23120000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)NINE;
Got message #125 from element "asr" (element): pocketsphinx, timestamp=(guint64)23480000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"TURN\ ON\ THE";
Got message #126 from element "asr" (element): pocketsphinx, timestamp=(guint64)23670000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"TURN\ ON\ THE\ GET";
Got message #127 from element "asr" (element): pocketsphinx, timestamp=(guint64)24190000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"TURN\ ON\ THE\ GET\ ENTER";
Got message #128 from element "asr" (element): pocketsphinx, timestamp=(guint64)18446744073709551615, final=(boolean)true, confidence=(glong)0, hypothesis=(string)"TURN\ ON\ THE\ GET";
Got message #129 from element "asr" (element): pocketsphinx, timestamp=(guint64)27970000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)ARE;
Got message #130 from element "asr" (element): pocketsphinx, timestamp=(guint64)28100000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)PAUSE;
Got message #131 from element "asr" (element): pocketsphinx, timestamp=(guint64)28110000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)ARE;
Got message #132 from element "asr" (element): pocketsphinx, timestamp=(guint64)28220000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)PAUSE;
Got message #133 from element "asr" (element): pocketsphinx, timestamp=(guint64)18446744073709551615, final=(boolean)true, confidence=(glong)0, hypothesis=(string)ARE;
Got message #134 from element "asr" (element): pocketsphinx, timestamp=(guint64)29150000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)MY;
Got message #135 from element "asr" (element): pocketsphinx, timestamp=(guint64)29400000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)TURN;
Got message #136 from element "asr" (element): pocketsphinx, timestamp=(guint64)29510000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)APPLE;
Got message #137 from element "asr" (element): pocketsphinx, timestamp=(guint64)29880000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"TURN\ THE\ ON";
Got message #138 from element "asr" (element): pocketsphinx, timestamp=(guint64)29890000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"TURN\ THE\ PAUSE";
Got message #139 from element "asr" (element): pocketsphinx, timestamp=(guint64)29940000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"TURN\ THE\ ON";
Got message #140 from element "asr" (element): pocketsphinx, timestamp=(guint64)30020000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"TURN\ THE\ OFF\ THE";
Got message #141 from element "asr" (element): pocketsphinx, timestamp=(guint64)30320000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"TURN\ THE\ OFF\ THE\ GO";
Got message #142 from element "asr" (element): pocketsphinx, timestamp=(guint64)30360000000, final=(boolean)false, confidence=(glong)0, hypothesis=(string)"TURN\ THE\ OFF\ THE\ FOUR";
Got message #143 from element "asr" (element): pocketsphinx, timestamp=(guint64)18446744073709551615, final=(boolean)true, confidence=(glong)0, hypothesis=(string)"TURN\ OFF\ THE\ FOUR";
^Chandling interrupt.
Got message #144 from element "pipeline0" (application): GstLaunchInterrupt, message=(string)"Pipeline\ interrupted";
Interrupt: Stopping pipeline ...
Execution ended after 0:00:33.286680180
Setting pipeline to PAUSED ...
Setting pipeline to READY ...
Setting pipeline to NULL ...
Freeing pipeline ...
```
