#!/bin/sh
set -ex

cd repo

VERSION=$(git rev-parse --short HEAD)

cd ../

# we need a way to reference the version
echo "$VERSION" > release/VERSION

echo "Packaging $VERSION for $TARGET"

mkdir dist
cp "repo/tmp/aoc" dist/

cd dist
ARCHIVE="lanjian-aoc-${VERSION}-${TARGET}.tar.gz"
tar czf "$ARCHIVE" "aoc"
cd ../

mv "dist/$ARCHIVE" "release/$ARCHIVE"

# we need a way to reference the file name
echo "$ARCHIVE" > release/ARCHIVE_NAME
