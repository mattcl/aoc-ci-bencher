#!/bin/sh
set -ex

# unpack and install the tools
cd aoc-tools
tar -xvf aoc-tools-*-x86_64-unknown-linux-musl.tar.gz
mv aoc-tools /usr/local/bin/
cd ../

cd repo
# install the project if necessary
if [ -z ${INSTALL+x} ]; then
    echo "no install script"
else
    eval "$INSTALL"
fi

# this is now above us
INPUTS_DIR="../aoc-inputs-write/${YEAR}"

# use the tools to check the inputs
aoc-tools ci check-solutions "$PARTICIPANT" "$INPUTS_DIR"
