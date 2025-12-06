#!/bin/sh
set -e

# fail fast if we won't pass a simple cargo check
cargo check --all-targets

# run the unit tests
cargo test

# build the cli
# cargo build --release
RUSTFLAGS="-C target-cpu=native" cargo build --release --target=x86_64-unknown-linux-musl

# cp the target release for a later step
mkdir tmp
cp target/x86_64-unknown-linux-musl/release/aoc-2025 tmp/
