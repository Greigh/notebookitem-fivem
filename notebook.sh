#!/bin/bash

# FiveM Resource Suite - Master Control Script
# This script provides a unified interface for all operations on the complete resource suite:
# - notebook_item (main resource)
# - notebook_phone_app (phone app for notebooks)
# - invoice_phone_app (phone app for invoices)
# - unified_phone_app (combined phone app)

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
    echo -e "${PURPLE}║                    📚 FiveM Resource Suite                     ║${NC}"
    echo -e "${PURPLE}║                      Master Control v${SCRIPT_VERSION}                     ║${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}📓 notebook_item • 📱 notebook_phone_app • 💰 invoice_phone_app • 🎯 unified_phone_app${NC}"
    echo ""
}

print_menu() {
    echo -e "${BLUE}Main Menu:${NC}"
    echo -e "  ${GREEN}1)${NC} 🔍 Validate Resources"
    echo -e "  ${GREEN}2)${NC} 🏗️  Build Distribution"
    echo -e "  ${GREEN}3)${NC} 🚀 Deploy to Server"
    echo -e "  ${GREEN}4)${NC} ⚡ Quick Install"
    echo -e "  ${GREEN}5)${NC} 🧪 Test Installation"
    echo -e "  ${GREEN}6)${NC} 📊 Show Status"
    echo -e "  ${GREEN}7)${NC} 🔧 Developer Tools"
    echo -e "  ${GREEN}8)${NC} 📖 Documentation"
    echo -e "  ${GREEN}9)${NC} 🧹 Clean Build"
    echo -e "  ${GREEN}0)${NC} 👋 Exit"
    echo ""
}

# Function to validate resource
validate_resource() {
    echo -e "${BLUE}🔍 Running Complete Resource Suite Validation...${NC}"
    echo ""
    if [ -f "validate.sh" ]; then
        ./validate.sh
    else
        echo -e "${RED}❌ validate.sh script not found${NC}"
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
    echo -e "${BLUE}⚡ Quick Install Process...${NC}"
    echo ""
    if [ -f "install.sh" ]; then
        ./install.sh
    else
        echo -e "${RED}❌ install.sh not found${NC}"
        return 1
    fi
    echo ""
    read -p "Press Enter to continue..."
}

# Function to test installation
test_installation() {
    echo -e "${BLUE}🧪 Testing Installation...${NC}"
    echo ""
    
    # Check if main resource exists
    echo -e "${CYAN}📓 Checking notebook_item resource...${NC}"
    if [ -d "notebook_item" ]; then
        echo -e "${GREEN}✅ notebook_item found${NC}"
    else
        echo -e "${RED}❌ notebook_item not found${NC}"
        return 1
    fi
    
    # Check phone apps
    echo -e "${CYAN}📱 Checking phone apps...${NC}"
    if [ -d "phone_apps" ]; then
        echo -e "${GREEN}✅ phone_apps directory found${NC}"
        
        # Check individual phone apps
        for app in "notebook_phone_app" "invoice_phone_app" "unified_phone_app"; do
            if [ -d "phone_apps/$app" ]; then
                echo -e "${GREEN}✅ $app found${NC}"
            else
                echo -e "${YELLOW}⚠️  $app not found (optional)${NC}"
            fi
        done
    else
        echo -e "${YELLOW}⚠️  phone_apps directory not found (optional)${NC}"
    fi
    
    # Run validation
    echo ""
    echo -e "${CYAN}🔍 Running validation...${NC}"
    if validate_resource > /dev/null 2>&1; then
        echo -e "${GREEN}✅ All validation checks passed!${NC}"
    else
        echo -e "${RED}❌ Validation failed${NC}"
        return 1
    fi
    
    echo ""
    echo -e "${GREEN}🎉 Test completed successfully!${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

# Function to show status
show_status() {
    echo -e "${BLUE}📊 FiveM Resource Suite Status${NC}"
    echo ""
    
    # Basic project info
    echo -e "${PURPLE}📋 Project Information:${NC}"
    echo -e "  Version: $SCRIPT_VERSION"
    echo -e "  Date: $(date)"
    echo ""
    
    # Resource structure
    echo -e "${PURPLE}📁 Resource Structure:${NC}"
    
    # Main resource
    if [ -d "notebook_item" ]; then
        echo -e "${GREEN}✅ notebook_item/${NC} - Main notebook functionality"
        
        # Count files in notebook_item
        lua_files=$(find notebook_item -name "*.lua" 2>/dev/null | wc -l)
        echo -e "     📄 Lua files: $lua_files"
    else
        echo -e "${RED}❌ notebook_item/${NC} - Missing"
    fi
    
    # Phone apps
    if [ -d "phone_apps" ]; then
        echo -e "${GREEN}✅ phone_apps/${NC} - Phone application suite"
        
        for app in "notebook_phone_app" "invoice_phone_app" "unified_phone_app"; do
            if [ -d "phone_apps/$app" ]; then
                echo -e "${GREEN}  ✅ $app/${NC}"
                
                # Check web files
                if [ -d "phone_apps/$app/web" ]; then
                    web_files=$(find "phone_apps/$app/web" -name "*.html" -o -name "*.css" -o -name "*.js" 2>/dev/null | wc -l)
                    echo -e "     🌐 Web files: $web_files"
                fi
            else
                echo -e "${YELLOW}  ⚠️  $app/${NC} - Not installed"
            fi
        done
    else
        echo -e "${YELLOW}⚠️  phone_apps/${NC} - Not installed"
    fi
    
    echo ""
    
    # Scripts status
    echo -e "${PURPLE}🔧 Available Scripts:${NC}"
    scripts=("validate.sh" "build.sh" "deploy.sh" "install.sh")
    for script in "${scripts[@]}"; do
        if [ -f "$script" ] && [ -x "$script" ]; then
            echo -e "${GREEN}✅ $script${NC}"
        elif [ -f "$script" ]; then
            echo -e "${YELLOW}⚠️  $script (not executable)${NC}"
        else
            echo -e "${RED}❌ $script${NC}"
        fi
    done
    
    echo ""
    
    # Documentation status
    echo -e "${PURPLE}📖 Documentation:${NC}"
    docs=("README.md" "HOW_IT_WORKS.md" "TECHNICAL_OVERVIEW.md" "INTEGRATION_GUIDE.md")
    for doc in "${docs[@]}"; do
        if [ -f "$doc" ]; then
            echo -e "${GREEN}✅ $doc${NC}"
        else
            echo -e "${RED}❌ $doc${NC}"
        fi
    done
    
    echo ""
    echo -e "${CYAN}💡 Quick Actions:${NC}"
    echo -e "  📋 Run ./validate.sh to check resource integrity"
    echo -e "  🏗️  Run ./build.sh to create distribution packages"
    echo -e "  🚀 Run ./deploy.sh to deploy to your server"
    
    echo ""
    read -p "Press Enter to continue..."
}

# Developer tools submenu
developer_tools() {
    while true; do
        print_header
        echo -e "${BLUE}🔧 Developer Tools:${NC}"
        echo -e "  ${GREEN}1)${NC} 🔍 Detailed Validation"
        echo -e "  ${GREEN}2)${NC} 📁 Show File Structure"
        echo -e "  ${GREEN}3)${NC} 🔧 Check Dependencies"
        echo -e "  ${GREEN}4)${NC} 📊 Code Statistics"
        echo -e "  ${GREEN}5)${NC} 🧹 Clean All"
        echo -e "  ${GREEN}0)${NC} ⬅️  Back to Main Menu"
        echo ""
        read -p "Select option [0-5]: " choice
        
        case $choice in
            1)
                echo -e "${BLUE}🔍 Running Detailed Validation...${NC}"
                echo ""
                if [ -f "validate.sh" ]; then
                    ./validate.sh --verbose 2>/dev/null || ./validate.sh
                else
                    echo -e "${RED}❌ validate.sh not found${NC}"
                fi
                echo ""
                read -p "Press Enter to continue..."
                ;;
            2)
                echo -e "${BLUE}📁 Project Structure:${NC}"
                echo ""
                if command -v tree >/dev/null 2>&1; then
                    tree -I 'node_modules|dist|build|*.zip' -a
                else
                    find . -type f -name "*.lua" -o -name "*.md" -o -name "*.sh" -o -name "*.html" -o -name "*.css" -o -name "*.js" | sort
                fi
                echo ""
                read -p "Press Enter to continue..."
                ;;
            3)
                echo -e "${BLUE}🔧 Checking Dependencies...${NC}"
                echo ""
                
                # Check for required tools
                tools=("lua" "curl" "git")
                echo -e "${CYAN}Required tools:${NC}"
                for tool in "${tools[@]}"; do
                    if command -v "$tool" >/dev/null 2>&1; then
                        echo -e "${GREEN}✅ $tool${NC}"
                    else
                        echo -e "${RED}❌ $tool${NC}"
                    fi
                done
                
                echo ""
                echo -e "${CYAN}Optional tools:${NC}"
                optional_tools=("tree" "zip" "sha256sum")
                for tool in "${optional_tools[@]}"; do
                    if command -v "$tool" >/dev/null 2>&1; then
                        echo -e "${GREEN}✅ $tool${NC}"
                    else
                        echo -e "${YELLOW}⚠️  $tool (optional)${NC}"
                    fi
                done
                
                echo ""
                read -p "Press Enter to continue..."
                ;;
            4)
                echo -e "${BLUE}📊 Code Statistics:${NC}"
                echo ""
                
                # Count different file types
                lua_count=$(find . -name "*.lua" | wc -l)
                html_count=$(find . -name "*.html" | wc -l)
                css_count=$(find . -name "*.css" | wc -l)
                js_count=$(find . -name "*.js" | wc -l)
                md_count=$(find . -name "*.md" | wc -l)
                sh_count=$(find . -name "*.sh" | wc -l)
                
                echo -e "${CYAN}File counts:${NC}"
                echo -e "  📄 Lua files: $lua_count"
                echo -e "  🌐 HTML files: $html_count"
                echo -e "  🎨 CSS files: $css_count"
                echo -e "  ⚡ JavaScript files: $js_count"
                echo -e "  📖 Markdown files: $md_count"
                echo -e "  🔧 Shell scripts: $sh_count"
                
                echo ""
                
                # Calculate total lines
                if command -v wc >/dev/null 2>&1; then
                    total_lines=$(find . -name "*.lua" -o -name "*.html" -o -name "*.css" -o -name "*.js" -o -name "*.md" | xargs wc -l 2>/dev/null | tail -1 | awk '{print $1}' || echo "0")
                    echo -e "${CYAN}Total lines of code: $total_lines${NC}"
                fi
                
                echo ""
                read -p "Press Enter to continue..."
                ;;
            5)
                echo -e "${BLUE}🧹 Cleaning All Build Files...${NC}"
                echo ""
                
                # Remove build directories
                dirs_to_clean=("build" "dist" "temp")
                for dir in "${dirs_to_clean[@]}"; do
                    if [ -d "$dir" ]; then
                        echo -e "${YELLOW}🗑️  Removing $dir/${NC}"
                        rm -rf "$dir"
                    fi
                done
                
                # Remove build artifacts
                find . -name "*.zip" -type f -delete 2>/dev/null || true
                find . -name "*.tar.gz" -type f -delete 2>/dev/null || true
                find . -name "build_manifest.json" -type f -delete 2>/dev/null || true
                
                echo -e "${GREEN}✅ Cleanup completed!${NC}"
                echo ""
                read -p "Press Enter to continue..."
                ;;
            0)
                break
                ;;
            *)
                echo -e "${RED}❌ Invalid option. Please select 0-5.${NC}"
                sleep 1
                ;;
        esac
    done
}

# Function to show documentation
show_documentation() {
    while true; do
        print_header
        echo -e "${BLUE}📖 Documentation Viewer:${NC}"
        echo -e "  ${GREEN}1)${NC} 📋 README.md"
        echo -e "  ${GREEN}2)${NC} 🔧 HOW_IT_WORKS.md"
        echo -e "  ${GREEN}3)${NC} 🏗️  TECHNICAL_OVERVIEW.md"
        echo -e "  ${GREEN}4)${NC} 🔌 INTEGRATION_GUIDE.md"
        echo -e "  ${GREEN}5)${NC} 📱 Phone Apps README"
        echo -e "  ${GREEN}6)${NC} 📚 SCRIPT_DOCUMENTATION.md"
        echo -e "  ${GREEN}0)${NC} ⬅️  Back to Main Menu"
        echo ""
        read -p "Select document [0-6]: " choice
        
        case $choice in
            1) [ -f "README.md" ] && less "README.md" || echo -e "${RED}❌ README.md not found${NC}" ;;
            2) [ -f "HOW_IT_WORKS.md" ] && less "HOW_IT_WORKS.md" || echo -e "${RED}❌ HOW_IT_WORKS.md not found${NC}" ;;
            3) [ -f "TECHNICAL_OVERVIEW.md" ] && less "TECHNICAL_OVERVIEW.md" || echo -e "${RED}❌ TECHNICAL_OVERVIEW.md not found${NC}" ;;
            4) [ -f "INTEGRATION_GUIDE.md" ] && less "INTEGRATION_GUIDE.md" || echo -e "${RED}❌ INTEGRATION_GUIDE.md not found${NC}" ;;
            5) [ -f "phone_apps/README.md" ] && less "phone_apps/README.md" || echo -e "${RED}❌ phone_apps/README.md not found${NC}" ;;
            6) [ -f "SCRIPT_DOCUMENTATION.md" ] && less "SCRIPT_DOCUMENTATION.md" || echo -e "${RED}❌ SCRIPT_DOCUMENTATION.md not found${NC}" ;;
            0) break ;;
            *) echo -e "${RED}❌ Invalid option. Please select 0-6.${NC}"; sleep 1 ;;
        esac
    done
}

# Function to clean build files
clean_build() {
    echo -e "${BLUE}🧹 Cleaning Build Files...${NC}"
    echo ""
    
    # Remove build directories
    dirs_to_clean=("build" "dist" "temp")
    for dir in "${dirs_to_clean[@]}"; do
        if [ -d "$dir" ]; then
            echo -e "${YELLOW}🗑️  Removing $dir/${NC}"
            rm -rf "$dir"
        else
            echo -e "${CYAN}ℹ️  $dir/ not found (already clean)${NC}"
        fi
    done
    
    # Remove build artifacts
    artifacts_removed=0
    if find . -name "*.zip" -type f -delete 2>/dev/null; then
        artifacts_removed=$((artifacts_removed + 1))
    fi
    if find . -name "*.tar.gz" -type f -delete 2>/dev/null; then
        artifacts_removed=$((artifacts_removed + 1))
    fi
    if find . -name "build_manifest.json" -type f -delete 2>/dev/null; then
        artifacts_removed=$((artifacts_removed + 1))
    fi
    
    echo ""
    echo -e "${GREEN}✅ Cleanup completed!${NC}"
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
        echo "FiveM Resource Suite Master Control Script"
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
