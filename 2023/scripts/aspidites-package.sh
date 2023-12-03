#!/bin/sh
set -ex

cd repo

VERSION=$(git rev-parse --short HEAD)

cd ../

# we need a way to reference the version
echo "$VERSION" > release/VERSION

echo "Packaging $VERSION"

mkdir dist
cp "repo/tmp/aoc2023" dist/

cd dist
ARCHIVE="aspidites-aoc-${VERSION}.tar.gz"
tar czf "$ARCHIVE" "aoc2023"
cd ../

mv "dist/$ARCHIVE" "release/$ARCHIVE"

# we need a way to reference the file name
echo "$ARCHIVE" > release/ARCHIVE_NAME
