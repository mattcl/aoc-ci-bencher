#!/bin/sh
set -ex

# unpack the tools
cd aoc-tools
tar -xvf aoc-tools-*-x86_64-unknown-linux-musl.tar.gz
mv aoc-tools /usr/local/bin/
cd ../

# unpack and install the solver
cd mattcl-bin
tar -xvf aoc-*-x86_64-unknown-linux-gnu.tar.gz
mv aoc /usr/local/bin/mattcl-aoc
cd ../

INPUTS_DIR="aoc-inputs-write/${YEAR}"

# use the tools to solve the inputs
aoc-tools solve-inputs "$INPUTS_DIR"
