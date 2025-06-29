#!/bin/bash

# FiveM Resource Suite - Complete Deployment Script
# This script handles validation, installation, and configuration of all three resources:
# - notebook_item (main resource)
# - notebook_phone_app (phone app for notebooks)
# - invoice_phone_app (phone app for invoices)

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Script configuration
SCRIPT_VERSION="1.0.0"
SUITE_NAME="fivem_resource_suite"
RESOURCES=("notebook_item" "phone_apps/notebook_phone_app" "phone_apps/invoice_phone_app")

# Function to print colored output
print_header() {
    echo -e "${PURPLE}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC}${CYAN}  FiveM Resource Suite - Deployment Script v${SCRIPT_VERSION}${NC}${PURPLE}        ║${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}Deploying complete resource suite:${NC}"
    echo -e "${BLUE}  📓 notebook_item - Main notebook resource${NC}"
    echo -e "${BLUE}  📱 notebook_phone_app - Phone app for notebooks${NC}"
    echo -e "${BLUE}  💰 invoice_phone_app - Phone app for invoices${NC}"
    echo ""
}

print_step() {
    echo -e "${BLUE}▶${NC} $1"
}

print_success() {
    echo -e "${GREEN}✅${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠️${NC}  $1"
}

print_error() {
    echo -e "${RED}❌${NC} $1"
}

print_info() {
    echo -e "${CYAN}ℹ️${NC}  $1"
}

# Function to check if directory exists
check_directory() {
    if [ -d "$1" ]; then
        return 0
    else
        return 1
    fi
}

# Function to check if file exists
check_file() {
    if [ -f "$1" ]; then
        return 0
    else
        return 1
    fi
}

# Function to validate resource structure
validate_resource() {
    print_step "Validating all resource structures..."
    
    local errors=0
    local warnings=0
    
    # Check all resource directories
    for resource in "${RESOURCES[@]}"; do
        if ! check_directory "$resource"; then
            print_error "Resource directory '$resource' not found"
            ((errors++))
        else
            print_success "Resource directory found: $resource"
        fi
    done
    
    # Check main notebook resource files
    local notebook_files=(
        "notebook_item/fxmanifest.lua"
        "notebook_item/client/main.lua"
        "notebook_item/server/main.lua"
        "notebook_item/shared/config.lua"
        "notebook_item/shared/advanced.lua"
    )
    
    print_step "Validating notebook_item files..."
    for file in "${notebook_files[@]}"; do
        if check_file "$file"; then
            print_success "Found: $file"
        else
            print_error "Missing: $file"
            ((errors++))
        fi
    done
    
    # Check notebook phone app files
    local notebook_phone_files=(
        "phone_apps/notebook_phone_app/fxmanifest.lua"
        "phone_apps/notebook_phone_app/client/main.lua"
        "phone_apps/notebook_phone_app/client/phone.lua"
        "phone_apps/notebook_phone_app/server/main.lua"
        "phone_apps/notebook_phone_app/shared/config.lua"
        "phone_apps/notebook_phone_app/web/index.html"
        "phone_apps/notebook_phone_app/web/style.css"
        "phone_apps/notebook_phone_app/web/script.js"
    )
    
    print_step "Validating phone_apps/notebook_phone_app files..."
    for file in "${notebook_phone_files[@]}"; do
        if check_file "$file"; then
            print_success "Found: $file"
        else
            print_error "Missing: $file"
            ((errors++))
        fi
    done
    
    # Check invoice phone app files
    local invoice_phone_files=(
        "phone_apps/invoice_phone_app/fxmanifest.lua"
        "phone_apps/invoice_phone_app/client/main.lua"
        "phone_apps/invoice_phone_app/client/phone.lua"
        "phone_apps/invoice_phone_app/server/main.lua"
        "phone_apps/invoice_phone_app/shared/config.lua"
        "phone_apps/invoice_phone_app/web/index.html"
        "phone_apps/invoice_phone_app/web/style.css"
        "phone_apps/invoice_phone_app/web/script.js"
    )
    
    print_step "Validating invoice_phone_app files..."
    for file in "${invoice_phone_files[@]}"; do
        if check_file "$file"; then
            print_success "Found: $file"
        else
            print_error "Missing: $file"
            ((errors++))
        fi
    done
    
    # Check documentation files
    local doc_files=(
        "items.txt"
        "README.md"
        "HOW_IT_WORKS.md"
        "TECHNICAL_OVERVIEW.md"
        "INTEGRATION_GUIDE.md"
        "PROJECT_STATUS.md"
        "COMPLETION_SUMMARY.md"
    )
    
    print_step "Validating documentation files..."
    for file in "${doc_files[@]}"; do
        if check_file "$file"; then
            print_success "Found: $file"
        else
            print_warning "Missing: $file"
            ((warnings++))
        fi
    done
    
    # Validate fxmanifest.lua content for each resource
    for resource in "${RESOURCES[@]}"; do
        if check_file "${resource}/fxmanifest.lua"; then
            if grep -q "fx_version" "${resource}/fxmanifest.lua"; then
                print_success "${resource} fxmanifest.lua has fx_version"
            else
                print_warning "${resource} fxmanifest.lua missing fx_version"
                ((warnings++))
            fi
        fi
    done
        
        if grep -q "game.*gta5" "${RESOURCE_NAME}/fxmanifest.lua"; then
            print_success "fxmanifest.lua configured for GTA5"
        else
            print_warning "fxmanifest.lua not configured for GTA5"
            ((warnings++))
        fi
    fi
    
    # Check export function
    if check_file "${RESOURCE_NAME}/client/main.lua"; then
        if grep -q "exports(" "${RESOURCE_NAME}/client/main.lua"; then
            print_success "Client script has export function"
        else
            print_error "Client script missing export function"
            ((errors++))
        fi
    fi
    
    # Validate Lua syntax
    print_step "Checking Lua syntax..."
    if command -v lua >/dev/null 2>&1; then
        local lua_errors=0
        while IFS= read -r -d '' file; do
            if ! lua -l "$file" >/dev/null 2>&1; then
                print_error "Lua syntax error in: $file"
                ((lua_errors++))
            fi
        done < <(find "$RESOURCE_NAME" -name "*.lua" -print0)
        
        if [ $lua_errors -eq 0 ]; then
            print_success "All Lua files have valid syntax"
        else
            print_error "$lua_errors Lua syntax errors found"
            ((errors++))
        fi
    else
        print_warning "Lua not found, skipping syntax validation"
        ((warnings++))
    fi
    
    # Return validation results
    echo ""
    print_info "Validation Results: $errors errors, $warnings warnings"
    
    if [ $errors -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

# Function to backup existing installation
backup_existing() {
    local server_path="$1"
    local backup_path="${server_path}/${RESOURCE_NAME}_backup_$(date +%Y%m%d_%H%M%S)"
    
    if check_directory "${server_path}/${RESOURCE_NAME}"; then
        print_step "Backing up existing installation..."
        if cp -r "${server_path}/${RESOURCE_NAME}" "$backup_path"; then
            print_success "Backup created: $backup_path"
            return 0
        else
            print_error "Failed to create backup"
            return 1
        fi
    fi
    return 0
}

# Function to install resource
install_resource() {
    local server_path="$1"
    
    print_step "Installing all resources to server..."
    
    local success_count=0
    local total_count=${#RESOURCES[@]}
    
    for resource in "${RESOURCES[@]}"; do
        print_step "Installing $resource..."
        
        # Create backup if existing installation found
        if check_directory "${server_path}/${resource}"; then
            local backup_path="${server_path}/${resource}_backup_$(date +%Y%m%d_%H%M%S)"
            mv "${server_path}/${resource}" "$backup_path"
            print_info "Backed up existing $resource to: $backup_path"
        fi
        
        # Copy resource
        if cp -r "./${resource}" "$server_path/"; then
            print_success "$resource installed successfully"
            ((success_count++))
        else
            print_error "Failed to install $resource"
        fi
    done
    
    print_info "Installation summary: $success_count/$total_count resources installed"
    
    if [ $success_count -eq $total_count ]; then
        return 0
    else
        return 1
    fi
}

# Function to update server.cfg
update_server_cfg() {
    local server_path="$1"
    local server_cfg="${server_path}/../server.cfg"
    
    print_step "Checking server.cfg configuration..."
    
    if check_file "$server_cfg"; then
        local all_configured=true
        
        for resource in "${RESOURCES[@]}"; do
            if grep -q "ensure ${resource}" "$server_cfg"; then
                print_success "$resource already configured in server.cfg"
            else
                all_configured=false
                break
            fi
        done
        
        if [ "$all_configured" = false ]; then
            print_step "Adding resources to server.cfg..."
            echo "" >> "$server_cfg"
            echo "# FiveM Resource Suite - Notebook and Invoice System" >> "$server_cfg"
            echo "ensure notebook_item" >> "$server_cfg"
            echo "ensure phone_apps/notebook_phone_app" >> "$server_cfg"
            echo "ensure phone_apps/invoice_phone_app" >> "$server_cfg"
            print_success "Added all resources to server.cfg"
        fi
    else
        print_warning "server.cfg not found at expected location: $server_cfg"
        print_info "Please manually add these lines to your server.cfg:"
        print_info "  ensure notebook_item"
        print_info "  ensure phone_apps/notebook_phone_app"
        print_info "  ensure phone_apps/invoice_phone_app"
    fi
}

# Function to check ox_inventory integration
check_ox_inventory() {
    local server_path="$1"
    local items_file="${server_path}/ox_inventory/data/items.lua"
    
    print_step "Checking ox_inventory integration..."
    
    if check_file "$items_file"; then
        if grep -q "notebook.*=" "$items_file"; then
            print_success "Notebook item already configured in ox_inventory"
        else
            print_warning "Notebook item not found in ox_inventory items.lua"
            print_info "Please add the item definition from items.txt to:"
            print_info "  $items_file"
        fi
    else
        print_warning "ox_inventory items.lua not found"
        print_info "Please ensure ox_inventory is installed and configured"
    fi
}

# Function to test installation
test_installation() {
    local server_path="$1"
    
    print_step "Testing installation..."
    
    # Check if resource files are in place
    local test_files=(
        "${server_path}/${RESOURCE_NAME}/fxmanifest.lua"
        "${server_path}/${RESOURCE_NAME}/client/main.lua"
        "${server_path}/${RESOURCE_NAME}/server/main.lua"
    )
    
    local missing_files=0
    for file in "${test_files[@]}"; do
        if ! check_file "$file"; then
            print_error "Missing installed file: $file"
            ((missing_files++))
        fi
    done
    
    if [ $missing_files -eq 0 ]; then
        print_success "All resource files installed correctly"
        return 0
    else
        print_error "$missing_files files missing from installation"
        return 1
    fi
}

# Function to generate installation report
generate_report() {
    local server_path="$1"
    local report_file="installation_report_$(date +%Y%m%d_%H%M%S).txt"
    
    print_step "Generating installation report..."
    
    cat > "$report_file" << EOF
Notebook Item Resource Installation Report
==========================================
Generated: $(date)
Script Version: $SCRIPT_VERSION

Installation Details:
- Resource Name: $RESOURCE_NAME
- Server Path: $server_path
- Installation Time: $(date)

Files Installed:
EOF
    
    find "$server_path/$RESOURCE_NAME" -type f >> "$report_file"
    
    cat >> "$report_file" << EOF

Next Steps:
1. Restart your FiveM server
2. Add notebook item to ox_inventory (see items.txt)
3. Test with: /give [player_id] notebook 1

Support:
- Check README.md for detailed instructions
- Check INTEGRATION_GUIDE.md for ox_inventory setup
- Check TECHNICAL_OVERVIEW.md for technical details

EOF
    
    print_success "Installation report saved: $report_file"
}

# Function to display next steps
show_next_steps() {
    echo ""
    print_header
    echo -e "${GREEN}🎉 Installation Complete!${NC}"
    echo ""
    print_info "Next Steps:"
    echo -e "${CYAN}1.${NC} Add notebook item to ox_inventory/data/items.lua"
    echo -e "   ${YELLOW}(Copy the definition from items.txt)${NC}"
    echo ""
    echo -e "${CYAN}2.${NC} Restart your FiveM server"
    echo ""
    echo -e "${CYAN}3.${NC} Test the installation:"
    echo -e "   ${YELLOW}/give [player_id] notebook 1${NC}"
    echo ""
    print_info "Documentation:"
    echo -e "${CYAN}•${NC} README.md - Complete user guide"
    echo -e "${CYAN}•${NC} INTEGRATION_GUIDE.md - ox_inventory setup"
    echo -e "${CYAN}•${NC} HOW_IT_WORKS.md - User explanation"
    echo -e "${CYAN}•${NC} TECHNICAL_OVERVIEW.md - Developer docs"
    echo ""
    print_info "Support:"
    echo -e "${CYAN}•${NC} Check validation with: ./validate.sh"
    echo -e "${CYAN}•${NC} View logs in FiveM server console"
    echo ""
    echo -e "${GREEN}Happy roleplaying! 🎮${NC}"
}

# Main installation function
main() {
    print_header
    
    # Step 1: Validate resource
    print_step "Step 1: Validating resource structure"
    if ! validate_resource; then
        print_error "Resource validation failed. Please fix errors before continuing."
        exit 1
    fi
    print_success "Resource validation passed"
    echo ""
    
    # Step 2: Get server path
    print_step "Step 2: Server configuration"
    echo -n "Enter the path to your FiveM server's resources directory: "
    read -r server_path
    
    if ! check_directory "$server_path"; then
        print_error "Directory '$server_path' does not exist."
        print_info "Please ensure you've entered the correct path to your resources folder."
        exit 1
    fi
    print_success "Server path validated: $server_path"
    echo ""
    
    # Step 3: Install resource
    print_step "Step 3: Installing resource"
    if ! install_resource "$server_path"; then
        print_error "Resource installation failed"
        exit 1
    fi
    echo ""
    
    # Step 4: Update server.cfg
    print_step "Step 4: Configuring server.cfg"
    update_server_cfg "$server_path"
    echo ""
    
    # Step 5: Check ox_inventory
    print_step "Step 5: Checking ox_inventory integration"
    check_ox_inventory "$server_path"
    echo ""
    
    # Step 6: Test installation
    print_step "Step 6: Testing installation"
    if ! test_installation "$server_path"; then
        print_error "Installation test failed"
        exit 1
    fi
    echo ""
    
    # Step 7: Generate report
    print_step "Step 7: Generating installation report"
    generate_report "$server_path"
    echo ""
    
    # Step 8: Show next steps
    show_next_steps
}

# Handle command line arguments
case "${1:-}" in
    --validate-only)
        print_header
        validate_resource
        exit $?
        ;;
    --help|-h)
        print_header
        echo "Usage: $0 [OPTIONS]"
        echo ""
        echo "Options:"
        echo "  --validate-only    Only validate resource structure"
        echo "  --help, -h         Show this help message"
        echo ""
        echo "Without options, runs complete installation process."
        exit 0
        ;;
    "")
        main
        ;;
    *)
        print_error "Unknown option: $1"
        echo "Use --help for usage information."
        exit 1
        ;;
esac
