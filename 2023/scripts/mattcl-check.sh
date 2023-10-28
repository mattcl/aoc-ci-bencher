#!/bin/sh
set -ex

# unpack and install the tools
cd aoc-tools
tar -xvf aoc-tools-*-x86_64-unknown-linux-musl.tar.gz
mv aoc-tools /usr/local/bin/
cd ../

# unpack and install the mattcl solution
cd repo
tar -xvf aoc-*-x86_64-unknown-linux-gnu.tar.gz
mv aoc /usr/local/bin/mattcl-aoc

# this is now above us
INPUTS_DIR="../aoc-inputs-write/${YEAR}"

# use the tools to check the inputs
aoc-tools check-solutions mattcl "$INPUTS_DIR"
