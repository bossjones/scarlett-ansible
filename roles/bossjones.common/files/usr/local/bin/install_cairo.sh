#!/usr/bin/env bash
# GOOD

export GSTREAMER=1.0
export PI_HOME=/home/pi
export MAIN_DIR=$PI_HOME/dev/bossjones-github/scarlett-dbus-poc
export VIRT_ROOT=$PI_HOME/.virtualenvs/scarlett-dbus-poc
export PKG_CONFIG_PATH=$VIRT_ROOT/lib/pkgconfig
export SCARLETT_CONFIG=$MAIN_DIR/tests/fixtures/.scarlett
export SCARLETT_HMM=$MAIN_DIR/tests/fixtures/model/hmm/en_US/hub4wsj_sc_8k
export SCARLETT_LM=$MAIN_DIR/tests/fixtures/lm/1602.lm
export SCARLETT_DICT=$MAIN_DIR/tests/fixtures/dict/1602.dic

> /tmp/scarlett_py2cairo_compile.log && \
cd $MAIN_DIR && \
curl -L "http://www.cairographics.org/releases/py2cairo-1.10.0.tar.bz2" > py2cairo-1.10.0.tar.bz2 && \
tar xf py2cairo-1.10.0.tar.bz2 && \
cd py2cairo-1.10.0 && \
./waf configure --prefix=$VIRT_ROOT >> /tmp/scarlett_py2cairo_compile.log && \
./waf build >> /tmp/scarlett_py2cairo_compile.log && \
./waf install >> /tmp/scarlett_py2cairo_compile.log && \
cd $MAIN_DIR
