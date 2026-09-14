#!/bin/bash

set -euo pipefail

# ============================================================
# Hyprland 0.56.2 native AArch64 build
# Intended for Arch Linux ARM / Asahi Alarm
# ============================================================

HYPRLAND_VERSION="v0.56.2"
BUILD_DIR="${HOME}/hyprland-build"
REPO_DIR="${BUILD_DIR}/Hyprland"

echo
echo "=============================================="
echo " Hyprland ${HYPRLAND_VERSION} AArch64 Builder"
echo "=============================================="
echo

# ------------------------------------------------------------
# Make sure we're running on Arch Linux
# ------------------------------------------------------------

if ! command -v pacman >/dev/null 2>&1; then
    echo "ERROR: pacman was not found."
    echo "This script expects Arch Linux / Arch Linux ARM."
    exit 1
fi

# ------------------------------------------------------------
# Make sure we're NOT root
# ------------------------------------------------------------

if [[ "${EUID}" -eq 0 ]]; then
    echo "ERROR: Do not run this script as root."
    echo
    echo "Run it as your normal user:"
    echo
    echo "    ./build-hyprland.sh"
    echo
    exit 1
fi

# ------------------------------------------------------------
# Determine CPU count
# ------------------------------------------------------------

if command -v nproc >/dev/null 2>&1; then
    JOBS="$(nproc)"
else
    JOBS="$(getconf _NPROCESSORS_ONLN)"
fi

echo "Build jobs: ${JOBS}"
echo

# ------------------------------------------------------------
# Install build/runtime dependencies
# ------------------------------------------------------------

echo "==> Installing build dependencies..."

sudo pacman -Syu --needed \
    base-devel \
    git \
    cmake \
    ninja \
    pkgconf \
    gcc \
    glslang \
    mesa \
    libglvnd \
    libdrm \
    libinput \
    libxkbcommon \
    wayland \
    wayland-protocols \
    wayland-scanner \
    xkbcommon \
    xcb-proto \
    libxcb \
    xcb-util \
    xcb-util-errors \
    xcb-util-image \
    xcb-util-keysyms \
    xcb-util-renderutil \
    xcb-util-wm \
    libx11 \
    libxcomposite \
    libxcursor \
    libxfixes \
    libxrender \
    xorg-xwayland \
    cairo \
    pango \
    pixman \
    lua \
    muparser \
    re2 \
    tomlplusplus \
    hyprcursor \
    hyprgraphics \
    hyprlang \
    hyprutils \
    hyprwayland-scanner \
    hyprland-guiutils \
    hyprwire \
    sdbus-c++ \
    uuid \
    python \
    libdisplay-info \
    libseat \
    seatd

echo
echo "==> Dependencies installed."
echo

# ------------------------------------------------------------
# Check the critical Aquamarine version
# ------------------------------------------------------------

echo "==> Checking Aquamarine..."

if ! pacman -Q aquamarine >/dev/null 2>&1; then
    echo "ERROR: Aquamarine is not installed."
    echo
    echo "Install the current ALARM Aquamarine package first."
    exit 1
fi

AQUAMARINE_VERSION="$(pacman -Q aquamarine | awk '{print $2}')"

echo "Installed Aquamarine: ${AQUAMARINE_VERSION}"

case "${AQUAMARINE_VERSION}" in
    0.15.*)
        echo "Aquamarine 0.15.x detected -- good."
        ;;
    *)
        echo
        echo "WARNING:"
        echo "This script expects Aquamarine 0.15.x."
        echo "Hyprland ${HYPRLAND_VERSION} requires Aquamarine >= 0.15.0."
        echo
        ;;
esac

echo

# ------------------------------------------------------------
# Check hyprwayland-scanner
# ------------------------------------------------------------

echo "==> Checking hyprwayland-scanner..."

if ! command -v hyprwayland-scanner >/dev/null 2>&1; then
    echo "ERROR: hyprwayland-scanner was not installed."
    exit 1
fi

echo "Found:"
command -v hyprwayland-scanner

echo

# ------------------------------------------------------------
# Create build directory
# ------------------------------------------------------------

mkdir -p "${BUILD_DIR}"

# ------------------------------------------------------------
# Clone Hyprland
# ------------------------------------------------------------

if [[ -d "${REPO_DIR}/.git" ]]; then

    echo "==> Existing Hyprland repository found."
    echo "    ${REPO_DIR}"
    echo

    cd "${REPO_DIR}"

    echo "==> Updating repository..."

    git fetch --tags --force origin

else

    echo "==> Cloning Hyprland..."

    git clone \
        --recursive \
        https://github.com/hyprwm/Hyprland.git \
        "${REPO_DIR}"

    cd "${REPO_DIR}"
fi

echo

# ------------------------------------------------------------
# Checkout exact release
# ------------------------------------------------------------

echo "==> Checking out ${HYPRLAND_VERSION}..."

git fetch --tags --force origin

git checkout --force "${HYPRLAND_VERSION}"

# Make sure submodules match the release
git submodule update --init --recursive

echo

echo "Hyprland version:"
git describe --tags --exact-match HEAD

echo

# ------------------------------------------------------------
# Clean previous build
# ------------------------------------------------------------

echo "==> Removing previous build directory..."

rm -rf build

# ------------------------------------------------------------
# Configure
# ------------------------------------------------------------

echo
echo "=============================================="
echo " Configuring Hyprland"
echo "=============================================="
echo

cmake \
    -S . \
    -B build \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib

echo
echo "==> Configuration successful."
echo

# ------------------------------------------------------------
# Build
# ------------------------------------------------------------

echo
echo "=============================================="
echo " Building Hyprland"
echo "=============================================="
echo

cmake \
    --build build \
    --parallel "${JOBS}"

echo
echo "=============================================="
echo " Build successful"
echo "=============================================="
echo

# ------------------------------------------------------------
# Install
# ------------------------------------------------------------

echo "==> Installing Hyprland..."

sudo cmake --install build

echo

# ------------------------------------------------------------
# Verify
# ------------------------------------------------------------

echo "=============================================="
echo " Installation verification"
echo "=============================================="
echo

if command -v Hyprland >/dev/null 2>&1; then
    echo "Hyprland executable:"
    command -v Hyprland
else
    echo "WARNING: Hyprland executable was not found in PATH."
fi

echo

if command -v hyprctl >/dev/null 2>&1; then
    echo "hyprctl:"
    command -v hyprctl
else
    echo "WARNING: hyprctl was not found in PATH."
fi

echo

echo "Installed version information:"
Hyprland --version 2>/dev/null || true

echo
echo "=============================================="
echo " DONE"
echo "=============================================="
echo
echo "Hyprland ${HYPRLAND_VERSION} has been built and installed."
echo
echo "You can now test it from a TTY with:"
echo
echo "    Hyprland"
echo
echo "or:"
echo
echo "    exec Hyprland"
echo
