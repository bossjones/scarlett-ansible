#!/usr/bin/env bash

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

# cd $MAIN_DIR && \
# curl -L "http://www.cairographics.org/releases/py2cairo-1.10.0.tar.bz2" > py2cairo-1.10.0.tar.bz2 && \
# tar xf py2cairo-1.10.0.tar.bz2 && \
# cd py2cairo-1.10.0 && \
# ./waf configure --prefix=$VIRT_ROOT > /dev/null && \
# ./waf build > /dev/null && \
# ./waf install > /dev/null && \
# cd $MAIN_DIR
# pocketsphinx
- travis_retry git clone https://github.com/bossjones/bossjones-pocketsphinx.git
- cd bossjones-pocketsphinx
- ./configure --prefix=$VIRT_ROOT
- make > /dev/null
- make install > /dev/null
- cd $MAIN_DIR
- sudo ldconfig
- pip install -q -r requirements.txt --use-mirrors
- pip install -q -r requirements_plugins.txt --use-mirrors
- pip install -q -r requirements_dev.txt --use-mirrors
