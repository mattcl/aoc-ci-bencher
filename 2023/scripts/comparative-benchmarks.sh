#!/bin/bash
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
cd ../

# install mattcl-py
cd mattcl-py
ci/scripts/install.sh
cd ../

INPUTS_DIR="aoc-inputs-write/${YEAR}"

i=1
while [ $i -ne 26 ];
do
    aoc-tools bench "$1" "$INPUTS_DIR"
    aoc-tools report "$1" "$INPUTS_DIR" -t ci/templates/report-template.md -o README.md
    i=$((i + 1))
done
