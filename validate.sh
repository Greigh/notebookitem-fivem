#!/bin/bash

# Notebook Item Resource Validation Script
# This script validates the resource structure and files

echo "🔍 Notebook Item Resource Validation"
echo "===================================="

errors=0
warnings=0

# Check if main resource directory exists
if [ ! -d "notebook_item" ]; then
    echo "❌ Error: notebook_item directory not found"
    ((errors++))
else
    echo "✅ notebook_item directory found"
fi

# Check required files
required_files=(
    "notebook_item/fxmanifest.lua"
    "notebook_item/client/main.lua"
    "notebook_item/server/main.lua"
    "notebook_item/shared/config.lua"
    "notebook_item/shared/advanced.lua"
    "items.txt"
    "README.md"
    "README_ENHANCED.md"
    "HOW_IT_WORKS.md"
    "TECHNICAL_OVERVIEW.md"
    "INTEGRATION_GUIDE.md"
    "DEVELOPMENT_SHOWCASE.md"
    "IMPORTANT_NOTES.md"
    "deploy.sh"
    "build.sh"
    "notebook.sh"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ Error: $file not found"
        ((errors++))
    fi
done

# Check for common FiveM file patterns
echo ""
echo "📋 Additional checks:"

# Check fxmanifest.lua for required fields
if [ -f "notebook_item/fxmanifest.lua" ]; then
    if grep -q "fx_version" "notebook_item/fxmanifest.lua"; then
        echo "✅ fxmanifest.lua has fx_version"
    else
        echo "⚠️  Warning: fxmanifest.lua missing fx_version"
        ((warnings++))
    fi
    
    if grep -q "game.*gta5" "notebook_item/fxmanifest.lua"; then
        echo "✅ fxmanifest.lua configured for GTA5"
    else
        echo "⚠️  Warning: fxmanifest.lua not configured for GTA5"
        ((warnings++))
    fi
fi

# Check for export function in client script
if [ -f "notebook_item/client/main.lua" ]; then
    if grep -q "exports(" "notebook_item/client/main.lua"; then
        echo "✅ Client script has export function"
        
        # Check for multiple export functions
        export_count=$(grep -c "exports(" "notebook_item/client/main.lua")
        if [ $export_count -gt 1 ]; then
            echo "✅ Multiple export functions found ($export_count items supported)"
        fi
    else
        echo "❌ Error: Client script missing export function"
        ((errors++))
    fi
fi

# Summary
echo ""
echo "📊 Validation Summary:"
echo "====================="

if [ $errors -eq 0 ] && [ $warnings -eq 0 ]; then
    echo "🎉 Perfect! No errors or warnings found."
    echo "The resource is ready to be installed."
elif [ $errors -eq 0 ]; then
    echo "✅ No errors found, but $warnings warning(s) detected."
    echo "The resource should work, but consider addressing the warnings."
else
    echo "❌ $errors error(s) and $warnings warning(s) found."
    echo "Please fix the errors before installing the resource."
fi

echo ""
if [ $errors -eq 0 ]; then
    echo "🚀 You can now run ./install.sh to install the resource to your server."
else
    echo "🔧 Please fix the errors above before proceeding with installation."
fi
