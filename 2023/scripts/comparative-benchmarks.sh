#!/bin/bash
set -ex

# unpack and install the tools
cd aoc-tools
tar -xvf aoc-tools-*-x86_64-unknown-linux-musl.tar.gz
mv aoc-tools /usr/local/bin/
cd ../

aoc-tools --version

# unpack and install the mattcl solution
cd mattcl-bin
tar -xvf aoc-*-x86_64-unknown-linux-gnu.tar.gz
mv aoc /usr/local/bin/mattcl-aoc
cd ../

# unpack and install the mattcl-ts solution
cd mattcl-ts-bin
tar -xvf aoc-js-*.tar.gz
mv mattcl-aoc2023-js /usr/local/bin/
cd ../

# unpack and install the mikofo solution
cd mikofo-bin
tar -xvf aoc-js-*.tar.gz
mv mikofo-advent-of-code-2023-js /usr/local/bin/
cd ../

# install mattcl-py
cd mattcl-py
ci/scripts/install.sh
cd ../

# install chancalan
cd chancalan
ci/scripts/install.sh
cd ../

# unpack and install the lanjian solution
cd lanjian-bin
tar -xvf lanjian-aoc-*-x86_64-unknown-linux-gnu.tar.gz
mv aoc /usr/local/bin/lanjian-aoc
cd ../

# install pting
cd pting
ci/scripts/install.sh
cd ../

# install kcen
cd kcen
ci/scripts/install.sh
cd ../

# install aspidites
cd aspidites-bin
tar -xvf aspidites-aoc-*.tar.gz
mv aoc2023 /usr/local/bin/aspidites-aoc
cd ../

INPUTS_DIR="aoc-inputs-write/${YEAR}"

set +x
# we don't need the script debugging from this point on

i=3
while [ $i -ne 26 ];
do
    aoc-tools ci bench "$YEAR" "$i" "$INPUTS_DIR"
    aoc-tools ci report "$i" "$INPUTS_DIR" -t ci/templates/report-template.md -o README.md
    i=$((i + 1))
done

# make the unified benchmarks and publish them, ignoring any failures
aoc-tools unify-benches "$INPUTS_DIR" -o unified.csv || true
aoc-tools publish-benches unified.csv || true
