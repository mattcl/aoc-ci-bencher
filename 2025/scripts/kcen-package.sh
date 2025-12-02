#!/bin/sh
set -ex

cd repo

VERSION=$(git rev-parse HEAD)

cd ../

# we need a way to reference the version
echo "$VERSION" > release/VERSION

echo "Packaging $VERSION"

mkdir dist
cp "repo/tmp/kcen-aoc" dist/

cd dist
ARCHIVE="kcen-aoc-${VERSION}.tar.gz"
tar czf "$ARCHIVE" "kcen-aoc"
cd ../

mv "dist/$ARCHIVE" "release/$ARCHIVE"

# we need a way to reference the file name
echo "$ARCHIVE" > release/ARCHIVE_NAME
