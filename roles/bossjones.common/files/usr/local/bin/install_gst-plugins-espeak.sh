#!/usr/bin/env bash
# GOOD

set -o nounset
set -o errexit

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
curl -L "http://download.sugarlabs.org/sources/honey/gst-plugins-espeak/gst-plugins-espeak-0.4.0.tar.gz" > gst-plugins-espeak-0.4.0.tar.gz && \
tar xvf gst-plugins-espeak-0.4.0.tar.gz && \
cd gst-plugins-espeak-0.4.0 && \
./configure --prefix=$VIRT_ROOT && \
make && \
make install && \
cd $MAIN_DIR

# # ##############################################################################################################
# # # HOW TO INSTALL gst-plugins-espeak : gstreamer 1.0
# # # source: http://download.sugarlabs.org/sources/honey/gst-plugins-espeak/gst-plugins-espeak-0.4.0.tar.gz
# # ##############################################################################################################
# # export PYTHONPATH=/usr/local/lib/python2.7/site-packages
# # export LD_LIBRARY_PATH=/usr/local/lib
# # export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
# # export GST_PLUGIN_PATH=/usr/local/lib/gstreamer-1.0

# mkdir -p ~/packages
# cd ~/packages
# wget http://download.sugarlabs.org/sources/honey/gst-plugins-espeak/gst-plugins-espeak-0.4.0.tar.gz
# tar xvf gst-plugins-espeak-0.4.0.tar.gz
# cd gst-plugins-espeak-0.4.0
# ./configure
# make
# sudo make install
