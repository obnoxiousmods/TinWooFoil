#!/bin/bash

set -e

echo "🔧 Starting ThemeInstPage fixer for TinWoo..."

TARGET_FILE="./source/util/curl.cpp"

if [ ! -f "$TARGET_FILE" ]; then
    echo "❌ Error: $TARGET_FILE not found!"
    exit 1
fi

# Backup original
cp "$TARGET_FILE" "$TARGET_FILE.bak"
echo "✅ Backup created: $TARGET_FILE.bak"

# Comment out the ThemeinstPage include
sed -i 's|^\(#include.*ui/ThemeinstPage\.hpp.*\)$|// \1|' "$TARGET_FILE"
echo "✅ Commented out #include for ThemeinstPage.hpp"

# Comment out all references to ThemeInstPage::setInstBarPerc
sed -i 's|^\(.*ThemeInstPage::setInstBarPerc.*\)$|// \1|' "$TARGET_FILE"
echo "✅ Commented out ThemeInstPage::setInstBarPerc lines"

echo "🎉 All done patching $TARGET_FILE"
