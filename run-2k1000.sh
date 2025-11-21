#!/bin/bash
# Run StarryOS on LoongArch 2K1000 with custom QEMU

set -e

QEMU_PREFIX=/home/czc/StarryOS/qemu
KERNEL=/home/czc/StarryOS/target/loongarch64-unknown-none-softfloat/release/starry

# Check if kernel exists
if [ ! -f "$KERNEL" ]; then
    echo "Error: Kernel not found at $KERNEL"
    echo "Please build first: make 2k1000la"
    exit 1
fi

# Check if QEMU exists
if [ ! -f "$QEMU_PREFIX/bin/qemu-system-loongarch64" ]; then
    echo "Error: QEMU not found at $QEMU_PREFIX"
    echo "Please download and extract qemu-static to ./qemu/"
    exit 1
fi

echo "Starting StarryOS on LoongArch 2K1000..."
echo "QEMU: $QEMU_PREFIX/bin/qemu-system-loongarch64"
echo "Kernel: $KERNEL"
echo ""

# Run QEMU with 2K1000 machine
# Based on example scripts and 2k1000-materials
cd $QEMU_PREFIX

./bin/qemu-system-loongarch64 \
    -M ls2k \
    -m 1G \
    -kernel "$KERNEL" \
    -nographic \
    "$@"
