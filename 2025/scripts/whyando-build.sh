#!/bin/sh
set -e

# fail fast if we won't pass a simple cargo check
cargo check --all-targets

# run the unit tests
cargo test

# build the cli
cargo build --release

# cp the target release for a later step
mkdir tmp
cp target/release/aoc-2025 tmp/
