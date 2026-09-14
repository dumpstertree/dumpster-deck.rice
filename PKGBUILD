pkgname=aquamarine
pkgver=0.14.0
pkgrel=1
pkgdesc="A very light linux rendering backend library"
arch=('aarch64')
url="https://github.com/hyprwm/aquamarine"
license=('BSD-3-Clause')

depends=(
    'glibc'
    'hyprutils'
    'libdisplay-info'
    'libdrm'
    'libgcc'
    'libglvnd'
    'libinput'
    'libstdc++'
    'mesa'
    'pixman'
    'seatd'
    'systemd-libs'
    'wayland'
    'wayland-protocols'
)

source=("$pkgname-$pkgver.tar.gz::https://github.com/hyprwm/aquamarine/archive/refs/tags/v$pkgver.tar.gz")
sha256sums=('SKIP')

build() {
    cmake \
        -S "$srcdir/$pkgname-$pkgver" \
        -B build \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr
    cmake --build build
}

package() {
    DESTDIR="$pkgdir" cmake --install build
}
