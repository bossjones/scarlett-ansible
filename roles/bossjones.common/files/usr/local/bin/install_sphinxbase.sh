#!/usr/bin/env bash

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

> /tmp/scarlett_sphinxbasecompile.log && \
cd $MAIN_DIR && \
./autogen.sh >> /tmp/scarlett_sphinxbasecompile.log && \
./configure --prefix=$VIRT_ROOT >> /tmp/scarlett_sphinxbasecompile.log && \
make clean all >> /tmp/scarlett_sphinxbasecompile.log && \
make check >> /tmp/scarlett_sphinxbasecompile.log && \
make install >> /tmp/scarlett_sphinxbasecompile.log && \
cd $MAIN_DIR
