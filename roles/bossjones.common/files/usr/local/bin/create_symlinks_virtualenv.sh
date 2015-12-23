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

# for GST PLUGINS
export LD_LIBRARY_PATH=$VIRT_ROOT/lib
export GST_PLUGIN_PATH=$VIRT_ROOT/lib/gstreamer-$GSTREAMER

ls -lta /usr/include/gstreamer-$GSTREAMER/
ls -lta /usr/share/pyshared | grep pygst
ls -lta $VIRT_ROOT/lib/python2.7/
cd $VIRT_ROOT/lib/python2.7/site-packages/
ln -s /usr/lib/python2.7/dist-packages/gst-$GSTREAMER
ln -s /usr/lib/python2.7/dist-packages/gstoption.so
ln -s /usr/lib/python2.7/dist-packages/pygst.pth
ln -s /usr/lib/python2.7/dist-packages/pygst.py
ln -s /usr/lib/python2.7/dist-packages/pygst.pyc


ln -s /usr/lib/python2.7/dist-packages/gobject* $VIRT_ROOT/lib/python2.7/site-packages/
ln -s /usr/lib/python2.7/dist-packages/glib* $VIRT_ROOT/lib/python2.7/site-packages/
ln -s /usr/lib/python2.7/dist-packages/cairo* $VIRT_ROOT/lib/python2.7/site-packages/
