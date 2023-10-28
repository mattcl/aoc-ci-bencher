#!/bin/sh
set -ex

# unpack the tools
cd aoc-tools
tar -xvf aoc-tools-*-x86_64-unknown-linux-gnu.tar.gz
cd ../

INPUTS_DIR="aoc-inputs/${YEAR}"

# ensure the directory for this year exists
mkdir -p "$INPUTS_DIR"

# use the tools to write the summary for this year
./aoc-tools/aoc-tools summary -t ci/templates/summary-template.md -o "${INPUTS_DIR}/README.md"

# use the tools to get the inputs from the participants
./aoc-tools/aoc-tools copy-inputs "$INPUTS_DIR"
