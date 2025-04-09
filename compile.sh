#!/bin/bash
set -euo pipefail

echo "💥 Let's fucking go. Starting kernel build for arm64..."

# Export environment variables
export ARCH=arm64
export PATH="/home/hanitav/clang/clang11/bin:$PATH"

# Make output directory if it doesn't exist
mkdir -p out

# Set defconfig
echo "🛠️  Running defconfig..."
make O=out ARCH=arm64 chopin_user_defconfig || {
    echo "❌ Defconfig failed. Are you drunk?"
    exit 1
}

# Start build
echo "🔥 Building kernel..."
make -j$(nproc) \
    O=out \
    ARCH=arm64 \
    LLVM=1 \
    CC="clang" \
    LLVM_IAS=1 \
    CROSS_COMPILE=aarch64-linux-gnu- \
    CROSS_COMPILE_ARM32=arm-linux-gnueabi- || {
        echo "❌ Kernel build failed. Shit's broken."
        exit 1
    }

echo "🎉 Kernel build complete. Pour yourself a stiff one, you earned it."
