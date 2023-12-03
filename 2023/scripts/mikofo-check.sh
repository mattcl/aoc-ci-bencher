#!/bin/sh
set -ex

# unpack and install the tools
cd aoc-tools
tar -xvf aoc-tools-*-x86_64-unknown-linux-musl.tar.gz
mv aoc-tools /usr/local/bin/
cd ../

# unpack and install the lanjian solution
npm install -g yarn
cp -r repo /mikofo
yarn --cwd /mikofo install
AOC_DAY=1 AOC_INPUT="$PWD/aoc-inputs-write/2023/day_001/input-mattcl" AOC_JSON=true yarn --cwd /mikofo start

INPUTS_DIR="${PWD}/aoc-inputs-write/${YEAR}"

cd repo

# use the tools to check the inputs
aoc-tools ci check-solutions mikofo "$INPUTS_DIR"
