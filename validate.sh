#!/bin/bash

# Enhanced Notebook Item Resource - Validation Script
# This script validates the notebook_item resource structure and configuration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

errors=0
warnings=0

echo -e "${BLUE}🔍 Notebook Item Resource Validation${NC}"
echo "======================================"

# Check main resource directory
echo -e "${CYAN}📁 Checking notebook_item resource directory...${NC}"
if [ ! -d "notebook_item" ]; then
    echo -e "${RED}❌ Error: notebook_item directory not found${NC}"
    ((errors++))
else
    echo -e "${GREEN}✅ notebook_item directory found${NC}"
fi

echo ""

# Check required files
echo -e "${CYAN}📋 Checking required files...${NC}"
echo -e "${PURPLE}📓 Validating notebook_item resource...${NC}"

required_files=(
    "notebook_item/fxmanifest.lua"
    "notebook_item/client/main.lua"
    "notebook_item/server/main.lua"
    "notebook_item/shared/config.lua"
    "notebook_item/shared/advanced.lua"
)

for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo -e "${RED}❌ Error: $file not found${NC}"
        ((errors++))
    else
        echo -e "${GREEN}✅ $file exists${NC}"
    fi
done

echo ""

# Check documentation and scripts
echo -e "${PURPLE}📚 Validating documentation and scripts...${NC}"

doc_files=(
    "items.txt"
    "README.md"
    "HOW_IT_WORKS.md"
    "TECHNICAL_OVERVIEW.md"
    "INTEGRATION_GUIDE.md"
    "deploy.sh"
    "build.sh"
    "notebook.sh"
    "validate.sh"
    "install.sh"
)

for file in "${doc_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo -e "${RED}❌ Error: $file not found${NC}"
        ((errors++))
    else
        echo -e "${GREEN}✅ $file exists${NC}"
    fi
done

echo ""
echo -e "${CYAN}📋 Additional validation checks:${NC}"
echo ""

# Check fxmanifest.lua configuration
echo -e "${BLUE}🔍 Notebook Item Resource Checks:${NC}"

if [ -f "notebook_item/fxmanifest.lua" ]; then
    # Check for fx_version
    if grep -q "fx_version" "notebook_item/fxmanifest.lua"; then
        echo -e "${GREEN}✅ notebook_item fxmanifest.lua has fx_version${NC}"
    else
        echo -e "${RED}❌ Error: notebook_item fxmanifest.lua missing fx_version${NC}"
        ((errors++))
    fi
    
    # Check for game specification
    if grep -q "game.*'gta5'" "notebook_item/fxmanifest.lua" || grep -q 'games.*{.*"gta5"' "notebook_item/fxmanifest.lua"; then
        echo -e "${GREEN}✅ notebook_item fxmanifest.lua configured for GTA5${NC}"
    else
        echo -e "${YELLOW}⚠️  Warning: notebook_item fxmanifest.lua should specify game 'gta5'${NC}"
        ((warnings++))
    fi
    
    # Check client scripts
    if [ -f "notebook_item/client/main.lua" ]; then
        # Check for export function
        if grep -q "exports\[.*\]:" "notebook_item/client/main.lua" || grep -q "exports(" "notebook_item/client/main.lua"; then
            # Count different item types supported
            item_count=$(grep -c "item_type.*==" "notebook_item/client/main.lua" 2>/dev/null || echo "0")
            # Ensure item_count is numeric
            if ! [[ "$item_count" =~ ^[0-9]+$ ]]; then
                item_count=0
            fi
            if [ "$item_count" -gt 0 ]; then
                echo -e "${GREEN}✅ notebook_item client script has export function${NC}"
                echo -e "${GREEN}✅ Multiple export functions found (${item_count} items supported)${NC}"
            else
                echo -e "${GREEN}✅ notebook_item client script has export function${NC}"
            fi
        else
            echo -e "${RED}❌ Error: notebook_item client script missing export functions${NC}"
            ((errors++))
        fi
    fi
fi

echo ""

# Phone apps note
echo -e "${CYAN}📱 Phone Apps Integration:${NC}"
echo -e "${BLUE}ℹ️  Phone apps are now available in a separate repository for better modularity:${NC}"
echo -e "${BLUE}   https://github.com/Greigh/FiveM-phone${NC}"
echo -e "${BLUE}ℹ️  This resource (notebook_item) only handles notebook items${NC}"
echo ""
echo -e "${CYAN}📋 Phone App Structure (for developers):${NC}"
echo -e "${BLUE}Each phone app should follow this structure:${NC}"
echo -e "${YELLOW}your_app/${NC}"
echo -e "${YELLOW}├── client/${NC}"
echo -e "${YELLOW}│   └── client.lua           ${CYAN}# Client-side logic, NUI communication${NC}"
echo -e "${YELLOW}├── server/${NC}"
echo -e "${YELLOW}│   └── server.lua           ${CYAN}# Server-side logic, database interaction${NC}"
echo -e "${YELLOW}├── html/${NC}"
echo -e "${YELLOW}│   ├── index.html           ${CYAN}# Main app structure${NC}"
echo -e "${YELLOW}│   ├── style.css            ${CYAN}# Styling${NC}"
echo -e "${YELLOW}│   ├── script.js            ${CYAN}# UI logic, NUI callbacks${NC}"
echo -e "${YELLOW}│   └── img/                 ${CYAN}# Images for icons, logos${NC}"
echo -e "${YELLOW}├── config.lua               ${CYAN}# Customizable settings${NC}"
echo -e "${YELLOW}├── fxmanifest.lua           ${CYAN}# Resource manifest${NC}"
echo -e "${YELLOW}└── sql.sql                  ${CYAN}# Database table creation${NC}"
echo ""

# Summary
echo -e "${CYAN}📊 Validation Summary:${NC}"
echo "====================="

if [ $errors -eq 0 ] && [ $warnings -eq 0 ]; then
    echo -e "${GREEN}🎉 Perfect! No errors or warnings found.${NC}"
    echo -e "${GREEN}The notebook_item resource is ready for installation.${NC}"
elif [ $errors -eq 0 ]; then
    echo -e "${YELLOW}✅ Validation completed with $warnings warning(s).${NC}"
    echo -e "${GREEN}The notebook_item resource is ready for installation.${NC}"
else
    echo -e "${RED}❌ $errors error(s) and $warnings warning(s) found.${NC}"
    echo -e "${RED}Please fix the errors before installing the resource.${NC}"
fi

echo ""
echo -e "${CYAN}📁 Resource Structure:${NC}"
echo -e "- ${GREEN}📓 notebook_item${NC}: Focused notebook resource with 4 notebook item types only"
echo ""

if [ $errors -eq 0 ]; then
    echo -e "${GREEN}🚀 You can now run ./install.sh to install the resource to your server.${NC}"
    echo -e "${BLUE}📱 For phone apps, visit: https://github.com/Greigh/FiveM-phone${NC}"
    echo -e "${BLUE}🎯 This resource focuses only on notebook items (notebook, journal, businesscard, photo)${NC}"
else
    echo -e "${RED}🔧 Please fix the errors above before proceeding with installation.${NC}"
fi

exit $errors
