#!/bin/bash
set -e

echo "📦 Building Rust static libraries..."

DEVICE_TARGET="aarch64-apple-ios"
SIM_TARGET_ARM64="aarch64-apple-ios-sim"
SIM_TARGET_X86="x86_64-apple-ios"

rustup target add $DEVICE_TARGET $SIM_TARGET_ARM64 $SIM_TARGET_X86

cargo build --release --target $DEVICE_TARGET
cargo build --release --target $SIM_TARGET_ARM64
cargo build --release --target $SIM_TARGET_X86

DEVICE_LIB="target/$DEVICE_TARGET/release/librust_add.a"
SIM_LIB_ARM64="target/$SIM_TARGET_ARM64/release/librust_add.a"
SIM_LIB_X86="target/$SIM_TARGET_X86/release/librust_add.a"

BUILD_DIR="../built"
mkdir -p "$BUILD_DIR"

echo "📦 Creating clean fat libraries for Xcode..."

# Device .a for iPhone
libtool -static -o "$BUILD_DIR/librust_add-iphoneos.a" \
    "$DEVICE_LIB"

# Simulator .a for x86_64 and arm64 sim
libtool -static -o "$BUILD_DIR/librust_add-iphonesimulator.a" \
    "$SIM_LIB_ARM64" \
    "$SIM_LIB_X86"

echo "✅ Done."
echo "📱 Device lib:        $BUILD_DIR/librust_add-iphoneos.a"
echo "🧪 Simulator lib:     $BUILD_DIR/librust_add-iphonesimulator.a"
