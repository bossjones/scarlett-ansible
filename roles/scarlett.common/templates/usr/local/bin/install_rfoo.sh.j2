#!/usr/bin/env bash

set -o nounset
set -o errexit

# source: https://wolfpaulus.com/journal/embedded/raspberrypi2-sr/
# cd ~/
# wget http://sourceforge.net/projects/cmusphinx/files/sphinxbase/5prealpha/sphinxbase-5prealpha.tar.gz
# tar -zxvf ./sphinxbase-5prealpha.tar.gz
# cd ./sphinxbase-5prealpha
# ./configure --enable-fixed
# make clean all
# make check
# sudo make install

export GSTREAMER=1.0
export PI_HOME=/home/pi
export MAIN_DIR=$PI_HOME/dev/bossjones-github/scarlett-dbus-poc
export VIRT_ROOT=$PI_HOME/.virtualenvs/scarlett-dbus-poc
export PKG_CONFIG_PATH=$VIRT_ROOT/lib/pkgconfig
export SCARLETT_CONFIG=$MAIN_DIR/tests/fixtures/.scarlett
export SCARLETT_HMM=$MAIN_DIR/tests/fixtures/model/hmm/en_US/hub4wsj_sc_8k
export SCARLETT_LM=$MAIN_DIR/tests/fixtures/lm/1602.lm
export SCARLETT_DICT=$MAIN_DIR/tests/fixtures/dict/1602.dic

# for GST PLUGINS
export LD_LIBRARY_PATH=$VIRT_ROOT/lib
export GST_PLUGIN_PATH=$VIRT_ROOT/lib/gstreamer-$GSTREAMER


cd $MAIN_DIR && \
git clone https://github.com/bossjones/rfoo.git && \
cd $MAIN_DIR/rfoo && \
python setup install && \
cd $MAIN_DIR
