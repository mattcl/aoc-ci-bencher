#!/bin/sh
set -e

# install dependencies
cabal build

# run tests
cabal test

# run tests
cabal install

mkdir -p tmp
cp -L /root/.cabal/bin/aoc2023 tmp/
