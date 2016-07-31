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

# install gst-python
> /tmp/scarlett_gst-python_compile.log && \
cd $MAIN_DIR && \
curl -L "http://gstreamer.freedesktop.org/src/gst-python/gst-python-1.2.4.tar.gz" > gst-python-1.2.4.tar.gz && \
tar xf gst-python-1.2.4.tar.gz && \
cd gst-python-1.2.4 && \
./configure --prefix=$VIRT_ROOT PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$VIRT_ROOT/lib/pkgconfig && \
sudo make && \
sudo make install && \
cd $MAIN_DIR
