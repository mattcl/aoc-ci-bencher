#!/bin/sh
set -ex

cd repo

VERSION=$(git rev-parse --short HEAD)

cd ../

# we need a way to reference the version
echo "$VERSION" > release/VERSION

echo "Packaging $VERSION for $TARGET"

mkdir dist
cp "repo/tmp/aoc-2025" dist/

cd dist
ARCHIVE="whyando-aoc-${VERSION}-${TARGET}.tar.gz"
tar czf "$ARCHIVE" "aoc-2025"
cd ../

mv "dist/$ARCHIVE" "release/$ARCHIVE"

# we need a way to reference the file name
echo "$ARCHIVE" > release/ARCHIVE_NAME
