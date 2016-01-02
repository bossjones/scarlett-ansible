#!/usr/bin/env bash -x

scarlett_ansible_home=$(pwd)/language_files
sentences=$scarlett_ansible_home/base_scarlett.corpus
langdir=$scarlett_ansible_home/lang
tempfile=$scarlett_ansible_home/url.txt
lmtoolurl=http://www.speech.cs.cmu.edu/cgi-bin/tools/lmtool/run

cd $scarlett_ansible_home

# upload corpus file, find the resulting dictionary file url
curl -L -F corpus=@"$sentences" -F formtype=simple $lmtoolurl \
  |grep -A 1 "base name" |grep http \
  | sed -e 's/^.*\="//' | sed -e 's/\.tgz.*$//' | sed -e 's/TAR//' > $tempfile

# download the .dic and .lm files
curl -C - -O $(cat $tempfile).dic
curl -C - -O $(cat $tempfile).lm

# mv em to the right name/place
mv *.dic $langdir/dic
mv *.lm $langdir/lm

_LANGUAGE_VERSION=$(cat $tempfile | cut -d\/ -f7)

echo $_LANGUAGE_VERSION > $(pwd)/LANGUAGE_VERSION.txt

rm $tempfile
