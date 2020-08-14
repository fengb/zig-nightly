#!/bin/bash

set -eou pipefail

meta="$(curl -s https://ziglang.org/download/index.json)"

VERSION="$(<<<"$meta" jq --raw-output '.master.version | sub("\\+.*"; "")')"
DATE="$(<<<"$meta" jq --raw-output '.master.date | gsub("-"; "")')"
TARBALL="$(<<<"$meta" jq --raw-output '.master["x86_64-linux"].tarball')"
SHA256="$(<<<"$meta" jq --raw-output '.master["x86_64-linux"].shasum')"
EXTRACT="$(basename "$TARBALL" .tar.xz)"

cat >PKGBUILD <<EOF
pkgname=zig
pkgver="$VERSION"
pkgrel="$DATE"
pkgdesc="A general-purpose programming language and toolchain for maintaining robust, optimal, and reusable software"
arch=('x86_64')
url="https://ziglang.org"
license=('MIT')
source=("$TARBALL")
depends=()
sha256sums=("$SHA256")
options=("!strip")

package() {
  cd "\${srcdir}/${EXTRACT}"
  install -D -m0755 zig "\${pkgdir}/usr/bin/zig"

  find lib/zig -type f -print0 | xargs -0 -I {} install -D -m0644 "{}" "\${pkgdir}/usr/{}"
}
EOF
