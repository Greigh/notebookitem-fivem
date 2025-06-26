#!/bin/bash

# Notebook Item Resource - Master Control Script
# This script provides a unified interface for all operations

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

SCRIPT_VERSION="1.0.0"

print_header() {
    clear
    echo -e "${PURPLE}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC}${CYAN}          Notebook Item Resource - Master Control${NC}${PURPLE}              ║${NC}"
    echo -e "${PURPLE}║${NC}${CYAN}                    Version ${SCRIPT_VERSION}${NC}${PURPLE}                        ║${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_menu() {
    echo -e "${BLUE}Available Operations:${NC}"
    echo ""
    echo -e "${CYAN}1.${NC} 🔍 Validate Resource Structure"
    echo -e "${CYAN}2.${NC} 🏗️  Build Distribution Package"
    echo -e "${CYAN}3.${NC} 🚀 Deploy to FiveM Server"
    echo -e "${CYAN}4.${NC} 📦 Quick Install (Validate + Deploy)"
    echo -e "${CYAN}5.${NC} 🧪 Test Installation"
    echo -e "${CYAN}6.${NC} 📋 View Project Status"
    echo -e "${CYAN}7.${NC} 🔧 Developer Tools"
    echo -e "${CYAN}8.${NC} 📚 Documentation"
    echo -e "${CYAN}9.${NC} 🧹 Clean Build Files"
    echo -e "${CYAN}0.${NC} ❌ Exit"
    echo ""
}

# Function to validate resource
validate_resource() {
    echo -e "${BLUE}🔍 Running Resource Validation...${NC}"
    echo ""
    if [ -f "validate.sh" ]; then
        ./validate.sh
    else
        echo -e "${RED}❌ validate.sh not found${NC}"
        return 1
    fi
    echo ""
    read -p "Press Enter to continue..."
}

# Function to build package
build_package() {
    echo -e "${BLUE}🏗️ Building Distribution Package...${NC}"
    echo ""
    if [ -f "build.sh" ]; then
        ./build.sh
    else
        echo -e "${RED}❌ build.sh not found${NC}"
        return 1
    fi
    echo ""
    read -p "Press Enter to continue..."
}

# Function to deploy to server
deploy_to_server() {
    echo -e "${BLUE}🚀 Deploying to FiveM Server...${NC}"
    echo ""
    if [ -f "deploy.sh" ]; then
        ./deploy.sh
    else
        echo -e "${RED}❌ deploy.sh not found${NC}"
        return 1
    fi
    echo ""
    read -p "Press Enter to continue..."
}

# Function for quick install
quick_install() {
    echo -e "${BLUE}📦 Quick Install - Validate and Deploy${NC}"
    echo ""
    
    # First validate
    echo -e "${CYAN}Step 1: Validating...${NC}"
    if [ -f "validate.sh" ]; then
        if ./validate.sh --quiet; then
            echo -e "${GREEN}✅ Validation passed${NC}"
        else
            echo -e "${RED}❌ Validation failed${NC}"
            read -p "Press Enter to continue..."
            return 1
        fi
    else
        echo -e "${RED}❌ validate.sh not found${NC}"
        return 1
    fi
    
    echo ""
    echo -e "${CYAN}Step 2: Deploying...${NC}"
    if [ -f "deploy.sh" ]; then
        ./deploy.sh
    else
        echo -e "${RED}❌ deploy.sh not found${NC}"
        return 1
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function to test installation
test_installation() {
    echo -e "${BLUE}🧪 Testing Installation${NC}"
    echo ""
    
    # Check if resource exists
    echo -n "Enter path to FiveM server resources directory: "
    read -r server_path
    
    if [ -d "${server_path}/notebook_item" ]; then
        echo -e "${GREEN}✅ Resource found in server${NC}"
        
        # Check files
        local test_files=(
            "${server_path}/notebook_item/fxmanifest.lua"
            "${server_path}/notebook_item/client/main.lua"
            "${server_path}/notebook_item/server/main.lua"
        )
        
        for file in "${test_files[@]}"; do
            if [ -f "$file" ]; then
                echo -e "${GREEN}✅ Found: $(basename "$file")${NC}"
            else
                echo -e "${RED}❌ Missing: $(basename "$file")${NC}"
            fi
        done
        
        # Check server.cfg
        local server_cfg="${server_path}/../server.cfg"
        if [ -f "$server_cfg" ] && grep -q "ensure notebook_item" "$server_cfg"; then
            echo -e "${GREEN}✅ Configured in server.cfg${NC}"
        else
            echo -e "${YELLOW}⚠️ Not configured in server.cfg${NC}"
        fi
        
    else
        echo -e "${RED}❌ Resource not found in server${NC}"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function to show project status
show_status() {
    echo -e "${BLUE}📋 Project Status${NC}"
    echo ""
    
    # Check resource files
    echo -e "${CYAN}Resource Files:${NC}"
    local resource_files=(
        "notebook_item/fxmanifest.lua"
        "notebook_item/client/main.lua"
        "notebook_item/server/main.lua"
        "notebook_item/shared/config.lua"
    )
    
    for file in "${resource_files[@]}"; do
        if [ -f "$file" ]; then
            echo -e "${GREEN}✅ $file${NC}"
        else
            echo -e "${RED}❌ $file${NC}"
        fi
    done
    
    echo ""
    echo -e "${CYAN}Documentation:${NC}"
    local docs=(
        "README.md"
        "HOW_IT_WORKS.md"
        "TECHNICAL_OVERVIEW.md"
        "INTEGRATION_GUIDE.md"
    )
    
    for doc in "${docs[@]}"; do
        if [ -f "$doc" ]; then
            echo -e "${GREEN}✅ $doc${NC}"
        else
            echo -e "${RED}❌ $doc${NC}"
        fi
    done
    
    echo ""
    echo -e "${CYAN}Scripts:${NC}"
    local scripts=("validate.sh" "build.sh" "deploy.sh" "install.sh")
    
    for script in "${scripts[@]}"; do
        if [ -f "$script" ] && [ -x "$script" ]; then
            echo -e "${GREEN}✅ $script (executable)${NC}"
        elif [ -f "$script" ]; then
            echo -e "${YELLOW}⚠️ $script (not executable)${NC}"
        else
            echo -e "${RED}❌ $script${NC}"
        fi
    done
    
    echo ""
    echo -e "${CYAN}Build Artifacts:${NC}"
    if [ -d "dist" ]; then
        local count=$(find dist -name "*.zip" | wc -l)
        echo -e "${GREEN}✅ $count package(s) in dist/${NC}"
    else
        echo -e "${YELLOW}⚠️ No build artifacts found${NC}"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function for developer tools
developer_tools() {
    while true; do
        clear
        print_header
        echo -e "${BLUE}🔧 Developer Tools${NC}"
        echo ""
        echo -e "${CYAN}1.${NC} View Resource Structure"
        echo -e "${CYAN}2.${NC} Check Lua Syntax"
        echo -e "${CYAN}3.${NC} Generate File Tree"
        echo -e "${CYAN}4.${NC} Count Lines of Code"
        echo -e "${CYAN}5.${NC} Check Dependencies"
        echo -e "${CYAN}0.${NC} Back to Main Menu"
        echo ""
        
        read -p "Select option [0-5]: " dev_choice
        
        case $dev_choice in
            1)
                echo -e "${BLUE}📁 Resource Structure:${NC}"
                echo ""
                if [ -d "notebook_item" ]; then
                    find notebook_item -type f | sort
                else
                    echo -e "${RED}❌ Resource directory not found${NC}"
                fi
                echo ""
                read -p "Press Enter to continue..."
                ;;
            2)
                echo -e "${BLUE}🔍 Checking Lua Syntax:${NC}"
                echo ""
                if command -v lua >/dev/null 2>&1; then
                    find notebook_item -name "*.lua" -exec lua -l {} \; 2>/dev/null && echo -e "${GREEN}✅ All Lua files have valid syntax${NC}" || echo -e "${RED}❌ Syntax errors found${NC}"
                else
                    echo -e "${YELLOW}⚠️ Lua not found${NC}"
                fi
                echo ""
                read -p "Press Enter to continue..."
                ;;
            3)
                echo -e "${BLUE}🌳 File Tree:${NC}"
                echo ""
                if command -v tree >/dev/null 2>&1; then
                    tree -I 'ox_inventory|build|dist|.git'
                else
                    find . -type f -not -path "./ox_inventory/*" -not -path "./build/*" -not -path "./dist/*" -not -path "./.git/*" | sort
                fi
                echo ""
                read -p "Press Enter to continue..."
                ;;
            4)
                echo -e "${BLUE}📊 Lines of Code:${NC}"
                echo ""
                local total_lines=0
                for ext in lua md sh txt; do
                    local count=$(find . -name "*.$ext" -not -path "./ox_inventory/*" -not -path "./build/*" -not -path "./dist/*" -exec wc -l {} + 2>/dev/null | tail -1 | awk '{print $1}' || echo 0)
                    echo -e "${CYAN}$ext files:${NC} $count lines"
                    total_lines=$((total_lines + count))
                done
                echo -e "${GREEN}Total:${NC} $total_lines lines"
                echo ""
                read -p "Press Enter to continue..."
                ;;
            5)
                echo -e "${BLUE}📦 Checking Dependencies:${NC}"
                echo ""
                local deps=("qbx_core" "ox_inventory" "ox_lib")
                for dep in "${deps[@]}"; do
                    if [ -d "../$dep" ] || [ -d "../../$dep" ]; then
                        echo -e "${GREEN}✅ $dep found${NC}"
                    else
                        echo -e "${YELLOW}⚠️ $dep not found in common locations${NC}"
                    fi
                done
                echo ""
                read -p "Press Enter to continue..."
                ;;
            0)
                break
                ;;
            *)
                echo -e "${RED}❌ Invalid option${NC}"
                sleep 1
                ;;
        esac
    done
}

# Function to show documentation
show_documentation() {
    while true; do
        clear
        print_header
        echo -e "${BLUE}📚 Documentation${NC}"
        echo ""
        echo -e "${CYAN}1.${NC} README.md - Complete User Guide"
        echo -e "${CYAN}2.${NC} HOW_IT_WORKS.md - Simple Explanation"
        echo -e "${CYAN}3.${NC} TECHNICAL_OVERVIEW.md - Developer Docs"
        echo -e "${CYAN}4.${NC} INTEGRATION_GUIDE.md - ox_inventory Setup"
        echo -e "${CYAN}5.${NC} PROJECT_SUMMARY.md - Project Overview"
        echo -e "${CYAN}6.${NC} items.txt - Item Configuration"
        echo -e "${CYAN}0.${NC} Back to Main Menu"
        echo ""
        
        read -p "Select document to view [0-6]: " doc_choice
        
        case $doc_choice in
            1) [ -f "README.md" ] && less README.md || echo -e "${RED}❌ README.md not found${NC}" ;;
            2) [ -f "HOW_IT_WORKS.md" ] && less HOW_IT_WORKS.md || echo -e "${RED}❌ HOW_IT_WORKS.md not found${NC}" ;;
            3) [ -f "TECHNICAL_OVERVIEW.md" ] && less TECHNICAL_OVERVIEW.md || echo -e "${RED}❌ TECHNICAL_OVERVIEW.md not found${NC}" ;;
            4) [ -f "INTEGRATION_GUIDE.md" ] && less INTEGRATION_GUIDE.md || echo -e "${RED}❌ INTEGRATION_GUIDE.md not found${NC}" ;;
            5) [ -f "PROJECT_SUMMARY.md" ] && less PROJECT_SUMMARY.md || echo -e "${RED}❌ PROJECT_SUMMARY.md not found${NC}" ;;
            6) [ -f "items.txt" ] && less items.txt || echo -e "${RED}❌ items.txt not found${NC}" ;;
            0) break ;;
            *) echo -e "${RED}❌ Invalid option${NC}"; sleep 1 ;;
        esac
    done
}

# Function to clean build files
clean_build() {
    echo -e "${BLUE}🧹 Cleaning Build Files${NC}"
    echo ""
    
    local cleaned=false
    
    if [ -d "build" ]; then
        rm -rf build
        echo -e "${GREEN}✅ Removed build directory${NC}"
        cleaned=true
    fi
    
    if [ -d "dist" ]; then
        rm -rf dist
        echo -e "${GREEN}✅ Removed dist directory${NC}"
        cleaned=true
    fi
    
    # Clean any backup files
    if find . -name "*_backup_*" -type d | grep -q .; then
        find . -name "*_backup_*" -type d -exec rm -rf {} + 2>/dev/null || true
        echo -e "${GREEN}✅ Removed backup directories${NC}"
        cleaned=true
    fi
    
    if [ "$cleaned" = false ]; then
        echo -e "${YELLOW}⚠️ No build files to clean${NC}"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Main menu loop
main() {
    while true; do
        print_header
        print_menu
        
        read -p "Select option [0-9]: " choice
        
        case $choice in
            1) validate_resource ;;
            2) build_package ;;
            3) deploy_to_server ;;
            4) quick_install ;;
            5) test_installation ;;
            6) show_status ;;
            7) developer_tools ;;
            8) show_documentation ;;
            9) clean_build ;;
            0) 
                echo -e "${GREEN}👋 Goodbye!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Invalid option. Please select 0-9.${NC}"
                sleep 1
                ;;
        esac
    done
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        print_header
        echo "Notebook Item Resource Master Control Script"
        echo ""
        echo "Usage: $0 [COMMAND]"
        echo ""
        echo "Commands:"
        echo "  validate    Run resource validation"
        echo "  build       Build distribution package"
        echo "  deploy      Deploy to FiveM server"
        echo "  install     Quick install (validate + deploy)"
        echo "  test        Test installation"
        echo "  status      Show project status"
        echo "  clean       Clean build files"
        echo "  --help, -h  Show this help"
        echo ""
        echo "Without commands, opens interactive menu."
        exit 0
        ;;
    validate) validate_resource; exit $? ;;
    build) build_package; exit $? ;;
    deploy) deploy_to_server; exit $? ;;
    install) quick_install; exit $? ;;
    test) test_installation; exit $? ;;
    status) show_status; exit $? ;;
    clean) clean_build; exit $? ;;
    "") main ;;
    *)
        echo -e "${RED}❌ Unknown command: $1${NC}"
        echo "Use --help for usage information."
        exit 1
        ;;
esac
