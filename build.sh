#!/usr/bin/env bash

set -euo pipefail

# ============================================================
# Build Hyprland 0.56.2 for Arch Linux ARM / Asahi AArch64
#
# Uses the official Arch Linux PKGBUILD rather than the
# hyprland-git AUR package.
#
# Existing Hypr stack expected:
#   aquamarine      0.15.x
#   hyprutils      0.14.x
#   hyprlang        0.6.x
#   hyprgraphics   0.5.x
#   hyprwire       0.3.x
# ============================================================

VERSION="0.56.2"
BUILD_ROOT="${HOME}/hyprland-build"
PKG_DIR="${BUILD_ROOT}/hyprland"

echo
echo "=============================================="
echo " Hyprland ${VERSION} AArch64 Builder"
echo "=============================================="
echo

# ------------------------------------------------------------
# Safety checks
# ------------------------------------------------------------

if [[ "${EUID}" -eq 0 ]]; then
    echo "ERROR: Do not run this script as root."
    echo
    echo "Run:"
    echo "  ./build-hyprland.sh"
    exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
    echo "ERROR: pacman not found."
    echo "This script is intended for Arch Linux / Arch Linux ARM."
    exit 1
fi

ARCH="$(uname -m)"

if [[ "${ARCH}" != "aarch64" ]]; then
    echo "WARNING: This machine reports architecture: ${ARCH}"
    echo "This script is intended for aarch64."
    read -rp "Continue anyway? [y/N] " answer
    [[ "${answer}" =~ ^[Yy]$ ]] || exit 1
fi

# ------------------------------------------------------------
# Check current Hypr stack
# ------------------------------------------------------------

echo "==> Current Hyprland libraries:"
echo

for pkg in aquamarine hyprutils-git hyprutils hyprlang hyprgraphics hyprwire; do
    if pacman -Q "${pkg}" >/dev/null 2>&1; then
        pacman -Q "${pkg}"
    fi
done

echo

# ------------------------------------------------------------
# Install build dependencies
# ------------------------------------------------------------

echo "==> Installing build dependencies..."
echo

sudo pacman -S --needed \
    base-devel \
    git \
    cmake \
    ninja \
    glaze \
    hyprland-protocols \
    hyprwayland-scanner \
    meson \
    xorgproto

echo
echo "==> Build dependencies installed."
echo

# ------------------------------------------------------------
# Verify critical runtime libraries
# ------------------------------------------------------------

echo "==> Checking required Hypr libraries..."
echo

REQUIRED_PKGS=(
    aquamarine
    hyprgraphics
    hyprlang
    hyprwire
)

for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! pacman -Q "${pkg}" >/dev/null 2>&1; then
        echo "ERROR: ${pkg} is not installed."
        echo
        echo "Install it with:"
        echo "  sudo pacman -S ${pkg}"
        exit 1
    fi

    pacman -Q "${pkg}"
done

# hyprutils can be either the normal package or -git.
if pacman -Q hyprutils-git >/dev/null 2>&1; then
    pacman -Q hyprutils-git
elif pacman -Q hyprutils >/dev/null 2>&1; then
    pacman -Q hyprutils
else
    echo "ERROR: Neither hyprutils nor hyprutils-git is installed."
    exit 1
fi

echo

# ------------------------------------------------------------
# Check Aquamarine ABI
# ------------------------------------------------------------

echo "==> Checking Aquamarine ABI..."

if pacman -T 'libaquamarine.so=14-64' >/dev/null 2>&1; then
    echo "ERROR: Your installed Aquamarine does NOT provide"
    echo "       libaquamarine.so=14-64"
    echo
    echo "Current Aquamarine:"
    pacman -Q aquamarine
    exit 1
fi

echo "OK: libaquamarine.so=14-64 is provided."

# ------------------------------------------------------------
# Create build directory
# ------------------------------------------------------------

mkdir -p "${BUILD_ROOT}"

# ------------------------------------------------------------
# Clone official Arch package repository
# ------------------------------------------------------------

if [[ -d "${PKG_DIR}/.git" ]]; then
    echo
    echo "==> Existing Arch Hyprland packaging repository found."
    echo

    cd "${PKG_DIR}"

    git fetch --all --tags
else
    echo
    echo "==> Cloning official Arch Hyprland packaging repository..."
    echo

    git clone \
        https://gitlab.archlinux.org/archlinux/packaging/packages/hyprland.git \
        "${PKG_DIR}"

    cd "${PKG_DIR}"
fi

# ------------------------------------------------------------
# Make sure we are using the 0.56.2 package
# ------------------------------------------------------------

echo
echo "==> Checking package version..."

PKGVER="$(grep '^pkgver=' PKGBUILD | cut -d= -f2)"

echo "PKGBUILD version: ${PKGVER}"

if [[ "${PKGVER}" != "${VERSION}" ]]; then
    echo
    echo "The Arch packaging repository has moved past ${VERSION}."
    echo
    echo "We need the 0.56.2 packaging revision for this build."
    echo

    # Try to locate a 0.56.2 tag.
    if git tag --list | grep -qx "${VERSION}-3"; then
        git checkout "${VERSION}-3"
    elif git tag --list | grep -qx "${VERSION}-2"; then
        git checkout "${VERSION}-2"
    else
        echo "ERROR: Could not locate the ${VERSION} package revision."
        echo
        echo "Available matching tags:"
        git tag --list | grep "${VERSION}" || true
        exit 1
    fi
fi

# ------------------------------------------------------------
# Force AArch64 package architecture
# ------------------------------------------------------------

echo
echo "==> Configuring PKGBUILD for AArch64..."

# Back up the original package recipe.
cp PKGBUILD PKGBUILD.arch-original

# Add aarch64 if the PKGBUILD does not already contain it.
if ! grep -q "'aarch64'" PKGBUILD && \
   ! grep -q '"aarch64"' PKGBUILD; then

    sed -i \
        "s/^arch=(.*/arch=('aarch64')/" \
        PKGBUILD
fi

echo
echo "Architecture line:"
grep '^arch=' PKGBUILD

# ------------------------------------------------------------
# Remove stale build artifacts
# ------------------------------------------------------------

echo
echo "==> Cleaning old package/build artifacts..."

rm -rf src pkg
rm -f *.pkg.tar.zst
rm -f *.pkg.tar.zst.sig

# ------------------------------------------------------------
# Display dependency information
# ------------------------------------------------------------

echo
echo "=============================================="
echo " PKGBUILD"
echo "=============================================="
echo

grep -E '^(pkgname|pkgver|pkgrel|arch|depends|makedepends)' PKGBUILD || true

echo
echo "=============================================="
echo " Building Hyprland"
echo "=============================================="
echo

# ------------------------------------------------------------
# Build and install
# ------------------------------------------------------------

makepkg -si --noconfirm

# ------------------------------------------------------------
# Verification
# ------------------------------------------------------------

echo
echo "=============================================="
echo " Verification"
echo "=============================================="
echo

if command -v Hyprland >/dev/null 2>&1; then
    echo "Hyprland executable:"
    command -v Hyprland
else
    echo "ERROR: Hyprland executable was not installed."
    exit 1
fi

echo
echo "Installed package:"
pacman -Q hyprland

echo
echo "Hyprland version:"
Hyprland --version || true

echo
echo "hyprctl:"
command -v hyprctl || true

echo
echo "=============================================="
echo " Hyprland installation complete!"
echo "=============================================="
echo
echo "You can test it from a TTY with:"
echo
echo "    Hyprland"
echo
