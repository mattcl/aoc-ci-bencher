#!/bin/sh
set -ex

# unpack and install the tools
cd aoc-tools
tar -xvf aoc-tools-*-x86_64-unknown-linux-musl.tar.gz
mv aoc-tools /usr/local/bin/
cd ../

# unpack and install the kcen solution
cd repo
tar -xvf kcen-aoc-*.tar.gz
mv kcen-aoc /usr/local/bin/kcen-aoc

# this is now above us
INPUTS_DIR="../aoc-inputs-write/${YEAR}"

# use the tools to check the inputs
aoc-tools ci check-solutions kcen "$INPUTS_DIR"
