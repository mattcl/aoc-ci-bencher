#!/bin/sh
set -e

# fail fast if we won't pass a simple cargo check
cargo check --all-targets

# run the unit tests
cargo test

# run integration tests
just test

# run benchmarks
just bench-all

# build the cli
# just build-cli
RUSTFLAGS="-C target-cpu=native" cargo build -p aoc-cli --profile release --target=x86_64-unknown-linux-musl

# cp the target release for a later step
mkdir tmp
cp target/x86_64-unknown-linux-musl/release/aoc tmp/
