#!/bin/bash

# Enhanced Notebook Item Resource - Installation Script
# Simple installation script for the notebook_item resource

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${PURPLE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║           Enhanced Notebook Item - Installation               ║${NC}"
echo -e "${PURPLE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}📓 Installing notebook_item resource with 4 item types${NC}"
echo ""

# Run validation first
echo -e "${BLUE}🔍 Running validation...${NC}"
if [ -f "validate.sh" ]; then
    if ./validate.sh; then
        echo -e "${GREEN}✅ Validation passed${NC}"
    else
        echo -e "${RED}❌ Validation failed. Please fix errors before installation.${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⚠️  Warning: validate.sh not found, skipping validation${NC}"
fi

echo ""

# Get server path
echo -e "${BLUE}📁 FiveM Server Configuration${NC}"
echo ""

while true; do
    read -p "Enter your FiveM server resources path: " server_path
    if [ -d "$server_path" ]; then
        echo -e "${GREEN}✅ Path exists: $server_path${NC}"
        break
    else
        echo -e "${RED}❌ Path does not exist. Please enter a valid path.${NC}"
    fi
done

# Copy resource
echo ""
echo -e "${BLUE}📋 Installing notebook_item resource...${NC}"

target_path="$server_path/notebook_item"

if [ -d "$target_path" ]; then
    echo -e "${YELLOW}⚠️  notebook_item already exists at $target_path${NC}"
    read -p "Overwrite existing installation? (y/N): " overwrite
    if [[ ! $overwrite =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Installation cancelled.${NC}"
        exit 0
    fi
    echo -e "${CYAN}🗑️  Removing existing installation...${NC}"
    rm -rf "$target_path"
fi

if [ -d "notebook_item" ]; then
    cp -r "notebook_item" "$target_path"
    echo -e "${GREEN}✅ notebook_item copied to $target_path${NC}"
else
    echo -e "${RED}❌ Error: notebook_item directory not found in current directory${NC}"
    exit 1
fi

# ox_inventory items
echo ""
echo -e "${BLUE}📦 ox_inventory Configuration${NC}"
echo ""

if [ -f "items.txt" ]; then
    echo -e "${CYAN}Item definitions are available in items.txt${NC}"
    echo -e "${YELLOW}⚠️  Please manually add these items to your ox_inventory/data/items.lua:${NC}"
    echo ""
    head -20 "items.txt"
    echo ""
    echo -e "${CYAN}(Full content in items.txt)${NC}"
else
    echo -e "${YELLOW}⚠️  Warning: items.txt not found${NC}"
fi

# Server.cfg configuration
echo ""
echo -e "${BLUE}⚙️  Server Configuration${NC}"
echo ""
echo -e "${CYAN}Add this line to your server.cfg:${NC}"
echo -e "${GREEN}ensure notebook_item${NC}"
echo ""

# Phone apps information
echo -e "${BLUE}📱 Phone Apps Integration${NC}"
echo ""
echo -e "${CYAN}For mobile phone integration, install phone apps from:${NC}"
echo -e "${BLUE}https://github.com/Greigh/FiveM-phone${NC}"
echo ""

# Final steps
echo -e "${GREEN}🎉 Installation Complete!${NC}"
echo ""
echo -e "${CYAN}Next Steps:${NC}"
echo -e "1. Add items from items.txt to ox_inventory"
echo -e "2. Add 'ensure notebook_item' to server.cfg"
echo -e "3. Restart your FiveM server"
echo -e "4. Test the notebook functionality in-game"
echo -e "5. Consider installing phone apps for mobile access"
echo ""
echo -e "${GREEN}Happy roleplaying! 📓✨${NC}"