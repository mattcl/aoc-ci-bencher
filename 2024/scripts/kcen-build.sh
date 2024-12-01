#!/bin/bash
set -e

nim --out:dist/kcen-aoc --passL:-static --opt:speed  -d:release c aoc.nim

# cp the target release for a later step
mkdir tmp
cp dist/kcen-aoc tmp/
