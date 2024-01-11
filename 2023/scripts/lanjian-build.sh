#!/bin/sh
set -e

# fail fast if we won't pass a simple cargo check
cargo check --all-targets

# run the unit tests
cargo test

# run integration tests
just test

# benches too slow
# run benchmarks
# just bench-all

# build the cli
just build-cli

# cp the target release for a later step
mkdir tmp
cp target/release/aoc tmp/
