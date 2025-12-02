#!/bin/sh
set -e

nimble --out:dist/kcen-aoc -d:danger --mm:orc -d:lto --passC:-march=native c aoc.nim

# cp the target release for a later step
mkdir tmp
cp dist/kcen-aoc tmp/
