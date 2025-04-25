#!/bin/bash

set -e

echo "🔧 Starting PACKED fixer for TinWoo..."

TARGET_FILES=(
    "./include/nx/ipc/ns_ext.h"
    "./include/install/nca.hpp"
    "./include/install/hfs0.hpp"
    "./include/install/pfs0.hpp"
)

for file in "${TARGET_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "⚠️ File not found: $file (Skipping)"
        continue
    fi

    echo "⚙️ Patching $file"

    # Backup original
    cp "$file" "$file.bak"

    # Insert PACKED define at the top if missing
    if ! grep -q '#define PACKED __attribute__((packed))' "$file"; then
        sed -i '1i#define PACKED __attribute__((packed))' "$file"
        echo "✅ Inserted PACKED macro into $file"
    fi

    # Fix wrong struct endings: '} PACKED StructName;' -> '} StructName __attribute__((packed));'
    sed -i -E 's/\} PACKED ([A-Za-z0-9_]+);/\} __attribute__\(\(packed\)\) \1;/' "$file"

done

echo "🎉 All done! You can now re-run make."
