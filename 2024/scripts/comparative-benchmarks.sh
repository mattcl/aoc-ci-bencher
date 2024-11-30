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

# install mattcl-py
cd mattcl-py
ci/scripts/install.sh
cd ../

INPUTS_DIR="aoc-inputs-write/${YEAR}"

set +x
# we don't need the script debugging from this point on

i=25
while [ $i -ne 0 ];
do
    aoc-tools ci bench "$YEAR" "$i" "$INPUTS_DIR"
    aoc-tools ci report "$i" "$INPUTS_DIR" -t ci/templates/report-template.md -o README.md

    # publish benches as we go
    padded=$(printf "%03d" "$i")
    day_dir="${INPUTS_DIR}/day_${padded}"
    if [ -d "$day_dir" ]; then
        pushd "$day_dir"
        aoc-tools publish-benches benches_raw.csv || true
        popd
    fi
    i=$((i - 1))
done

# make the unified benchmarks and publish them, ignoring any failures
# aoc-tools unify-benches "$INPUTS_DIR" -o unified.csv || true
# aoc-tools publish-benches unified.csv || true
