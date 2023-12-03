#!/bin/sh
set -e

# install dependencies
cabal build

# run tests
cabal test

# run tests
cabal install

mkdir tmp
cp /root/.cabal/store/ghc-9.4.6/aoc2023-*/bin/aoc2023 tmp/
