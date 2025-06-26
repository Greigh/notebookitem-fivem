#!/bin/bash

# Notebook Item Resource - Build and Package Script
# This script creates a complete distribution package

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuration
BUILD_VERSION="1.0.1"
RESOURCE_NAME="notebook_item"
BUILD_DIR="build"
DIST_DIR="dist"
DATE=$(date +%Y%m%d_%H%M%S)

print_header() {
    echo -e "${PURPLE}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC}${CYAN}  Notebook Item Resource - Build Script v${BUILD_VERSION}${NC}${PURPLE}           ║${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_step() {
    echo -e "${BLUE}▶${NC} $1"
}

print_success() {
    echo -e "${GREEN}✅${NC} $1"
}

print_error() {
    echo -e "${RED}❌${NC} $1"
}

print_info() {
    echo -e "${CYAN}ℹ️${NC}  $1"
}

# Function to clean build directories
clean_build() {
    print_step "Cleaning build directories..."
    
    if [ -d "$BUILD_DIR" ]; then
        rm -rf "$BUILD_DIR"
        print_info "Removed existing build directory"
    fi
    
    if [ -d "$DIST_DIR" ]; then
        rm -rf "$DIST_DIR"
        print_info "Removed existing dist directory"
    fi
    
    mkdir -p "$BUILD_DIR"
    mkdir -p "$DIST_DIR"
    print_success "Build directories created"
}

# Function to copy resource files
copy_resource() {
    print_step "Copying resource files..."
    
    # Copy main resource
    cp -r "$RESOURCE_NAME" "$BUILD_DIR/"
    print_success "Resource files copied"
    
    # Copy documentation
    local docs=(
        "README.md"
        "HOW_IT_WORKS.md"
        "TECHNICAL_OVERVIEW.md"
        "INTEGRATION_GUIDE.md"
        "PROJECT_SUMMARY.md"
        "LICENSE"
        "items.txt"
    )
    
    for doc in "${docs[@]}"; do
        if [ -f "$doc" ]; then
            cp "$doc" "$BUILD_DIR/"
            print_info "Copied: $doc"
        fi
    done
    
    # Copy scripts
    local scripts=(
        "deploy.sh"
        "validate.sh"
        "install.sh"
    )
    
    for script in "${scripts[@]}"; do
        if [ -f "$script" ]; then
            cp "$script" "$BUILD_DIR/"
            chmod +x "$BUILD_DIR/$script"
            print_info "Copied: $script"
        fi
    done
}

# Function to create installation package
create_package() {
    print_step "Creating installation package..."
    
    local package_name="${RESOURCE_NAME}_v${BUILD_VERSION}_${DATE}"
    local package_dir="$BUILD_DIR/$package_name"
    
    # Create package directory structure
    mkdir -p "$package_dir"
    
    # Copy all files to package
    cp -r "$BUILD_DIR/$RESOURCE_NAME" "$package_dir/"
    cp "$BUILD_DIR"/*.md "$package_dir/" 2>/dev/null || true
    cp "$BUILD_DIR"/*.txt "$package_dir/" 2>/dev/null || true
    cp "$BUILD_DIR/LICENSE" "$package_dir/" 2>/dev/null || true
    cp "$BUILD_DIR"/*.sh "$package_dir/" 2>/dev/null || true
    
    # Create ZIP archive
    cd "$BUILD_DIR"
    zip -r "../$DIST_DIR/${package_name}.zip" "$package_name" >/dev/null
    cd ..
    
    print_success "Package created: $DIST_DIR/${package_name}.zip"
}

# Function to create release archive (resource only)
create_release() {
    print_step "Creating release archive..."
    
    local release_name="${RESOURCE_NAME}_release_v${BUILD_VERSION}"
    
    cd "$BUILD_DIR"
    zip -r "../$DIST_DIR/${release_name}.zip" "$RESOURCE_NAME" >/dev/null
    cd ..
    
    print_success "Release archive created: $DIST_DIR/${release_name}.zip"
}

# Function to generate checksums
generate_checksums() {
    print_step "Generating checksums..."
    
    cd "$DIST_DIR"
    
    for file in *.zip; do
        if [ -f "$file" ]; then
            sha256sum "$file" > "${file}.sha256"
            print_info "Checksum created for: $file"
        fi
    done
    
    cd ..
    print_success "Checksums generated"
}

# Function to create build manifest
create_manifest() {
    print_step "Creating build manifest..."
    
    local manifest_file="$DIST_DIR/build_manifest.json"
    
    cat > "$manifest_file" << EOF
{
    "resource_name": "$RESOURCE_NAME",
    "version": "$BUILD_VERSION",
    "build_date": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "build_timestamp": "$DATE",
    "files": [
EOF
    
    local first=true
    for file in "$DIST_DIR"/*.zip; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo "unknown")
            
            if [ "$first" = true ]; then
                first=false
            else
                echo "," >> "$manifest_file"
            fi
            
            cat >> "$manifest_file" << EOF
        {
            "name": "$filename",
            "size": $size,
            "sha256": "$(cat "$DIST_DIR/${filename}.sha256" | cut -d' ' -f1)"
        }
EOF
        fi
    done
    
    cat >> "$manifest_file" << EOF

    ],
    "dependencies": [
        {
            "name": "qbx_core",
            "version": ">=1.0.0",
            "required": true
        },
        {
            "name": "ox_inventory",
            "version": ">=2.44.0",
            "required": true
        },
        {
            "name": "ox_lib",
            "version": ">=3.27.0",
            "required": true
        }
    ],
    "installation": {
        "steps": [
            "Extract resource to server resources directory",
            "Add item definition to ox_inventory/data/items.lua",
            "Add 'ensure notebook_item' to server.cfg",
            "Restart server"
        ]
    }
EOF
    
    print_success "Build manifest created: $manifest_file"
}

# Function to run tests
run_tests() {
    print_step "Running validation tests..."
    
    cd "$BUILD_DIR"
    
    if [ -f "validate.sh" ]; then
        if ./validate.sh --quiet 2>/dev/null; then
            print_success "Validation tests passed"
        else
            print_error "Validation tests failed"
            return 1
        fi
    else
        print_error "Validation script not found"
        return 1
    fi
    
    cd ..
}

# Function to display build summary
show_summary() {
    echo ""
    print_header
    echo -e "${GREEN}🎉 Build Complete!${NC}"
    echo ""
    print_info "Build Summary:"
    echo -e "${CYAN}•${NC} Version: $BUILD_VERSION"
    echo -e "${CYAN}•${NC} Build Date: $(date)"
    echo -e "${CYAN}•${NC} Resource Name: $RESOURCE_NAME"
    echo ""
    print_info "Generated Files:"
    
    if [ -d "$DIST_DIR" ]; then
        for file in "$DIST_DIR"/*; do
            if [ -f "$file" ]; then
                filename=$(basename "$file")
                size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo "unknown")
                echo -e "${CYAN}•${NC} $filename (${size} bytes)"
            fi
        done
    fi
    
    echo ""
    print_info "Next Steps:"
    echo -e "${CYAN}1.${NC} Test installation with: ./deploy.sh"
    echo -e "${CYAN}2.${NC} Upload to GitHub releases"
    echo -e "${CYAN}3.${NC} Share with the FiveM community"
    echo ""
    echo -e "${GREEN}Ready for distribution! 🚀${NC}"
}

# Main build function
main() {
    print_header
    
    # Clean and prepare
    clean_build
    
    # Copy files
    copy_resource
    
    # Run tests
    if ! run_tests; then
        print_error "Build failed due to validation errors"
        exit 1
    fi
    
    # Create packages
    create_package
    create_release
    
    # Generate checksums
    generate_checksums
    
    # Create manifest
    create_manifest
    
    # Show summary
    show_summary
}

# Handle command line arguments
case "${1:-}" in
    --clean)
        print_header
        clean_build
        print_success "Build directories cleaned"
        exit 0
        ;;
    --help|-h)
        print_header
        echo "Usage: $0 [OPTIONS]"
        echo ""
        echo "Options:"
        echo "  --clean            Clean build directories only"
        echo "  --help, -h         Show this help message"
        echo ""
        echo "Without options, runs complete build process."
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
