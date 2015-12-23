#!/usr/bin/env bash
# GOOD
# source: http://ftp.gnome.org/pub/GNOME/sources/pygobject/3.12/pygobject-3.12.0.tar.xz

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

> /tmp/scarlett_pygobject_compile.log && \
cd $MAIN_DIR && \
curl -L "http://ftp.gnome.org/pub/GNOME/sources/pygobject/3.12/pygobject-3.12.0.tar.xz" > pygobject-3.12.0.tar.xz && \
tar xf pygobject-3.12.0.tar.xz && \
cd pygobject-3.12.0 && \
./configure --prefix=$VIRT_ROOT --disable-introspection >> /tmp/scarlett_pygobject_compile.log && \
make >> /tmp/scarlett_pygobject_compile.log && \
make install >> /tmp/scarlett_pygobject_compile.log && \
cd $MAIN_DIR
