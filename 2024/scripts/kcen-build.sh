#!/bin/bash
set -e

./ci/scripts/build.sh

# cp the target release for a later step
mkdir tmp
cp dist/kcen-aoc tmp/
