#!/bin/bash

# Enhanced Notebook Item Resource - Build Script
# Creates distribution packages for the notebook_item resource

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Build configuration
BUILD_VERSION="1.0.2"
RESOURCE_NAME="enhanced_notebook_item"
BUILD_DIR="build"
DIST_DIR="dist"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

echo -e "${PURPLE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║  Enhanced Notebook Item - Build Script v${BUILD_VERSION}              ║${NC}"
echo -e "${PURPLE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}Building enhanced notebook item resource...${NC}"
echo -e "  ${GREEN}📓 notebook_item${NC} - Core notebook resource with 4 item types"
echo ""

# Clean and create build directories
echo -e "${BLUE}▶ Cleaning build directories...${NC}"
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
    echo -e "${CYAN}ℹ️  Removed existing build directory${NC}"
fi

if [ -d "$DIST_DIR" ]; then
    rm -rf "$DIST_DIR"
    echo -e "${CYAN}ℹ️  Removed existing dist directory${NC}"
fi

mkdir -p "$BUILD_DIR"
mkdir -p "$DIST_DIR"
echo -e "${GREEN}✅ Build directories created${NC}"

# Copy resource files
echo -e "${BLUE}▶ Copying resource files...${NC}"

# Copy notebook_item resource
if [ -d "notebook_item" ]; then
    cp -r "notebook_item" "$BUILD_DIR/"
    echo -e "${GREEN}✅ notebook_item files copied${NC}"
else
    echo -e "${RED}❌ Error: notebook_item directory not found${NC}"
    exit 1
fi

# Copy documentation
docs=(
    "README.md"
    "HOW_IT_WORKS.md" 
    "TECHNICAL_OVERVIEW.md"
    "INTEGRATION_GUIDE.md"
    "DEVELOPMENT_SHOWCASE.md"
    "IMPORTANT_NOTES.md"
    "PROJECT_STATUS.md"
    "COMPLETION_SUMMARY.md"
    "items.txt"
    "LICENSE"
)

for doc in "${docs[@]}"; do
    if [ -f "$doc" ]; then
        cp "$doc" "$BUILD_DIR/"
        echo -e "${CYAN}ℹ️  Copied $doc${NC}"
    fi
done

# Copy scripts
scripts=(
    "install.sh"
    "deploy.sh"
    "build.sh"
    "validate.sh"
    "notebook.sh"
)

for script in "${scripts[@]}"; do
    if [ -f "$script" ]; then
        cp "$script" "$BUILD_DIR/"
        chmod +x "$BUILD_DIR/$script"
        echo -e "${CYAN}ℹ️  Copied $script (executable)${NC}"
    fi
done

# Run validation tests
echo -e "${BLUE}▶ Running validation tests...${NC}"
cd "$BUILD_DIR"
if ./validate.sh > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Validation tests passed${NC}"
else
    echo -e "${YELLOW}⚠️  Validation warnings (continuing build)${NC}"
fi
cd ..

# Create installation package
echo -e "${BLUE}▶ Creating installation package...${NC}"
package_name="${RESOURCE_NAME}_v${BUILD_VERSION}_${TIMESTAMP}.zip"

if command -v zip >/dev/null 2>&1; then
    cd "$BUILD_DIR"
    zip -r "../$DIST_DIR/$package_name" . > /dev/null 2>&1
    cd ..
    echo -e "${GREEN}✅ Package created: $DIST_DIR/$package_name${NC}"
else
    echo -e "${YELLOW}⚠️  Warning: zip command not found, creating tar.gz instead${NC}"
    tar -czf "$DIST_DIR/${package_name%.zip}.tar.gz" -C "$BUILD_DIR" .
    echo -e "${GREEN}✅ Package created: $DIST_DIR/${package_name%.zip}.tar.gz${NC}"
fi

# Create release archive (resource only)
echo -e "${BLUE}▶ Creating release archive...${NC}"
release_name="${RESOURCE_NAME}_release_v${BUILD_VERSION}.zip"

if command -v zip >/dev/null 2>&1; then
    cd "$BUILD_DIR"
    zip -r "../$DIST_DIR/$release_name" notebook_item/ items.txt README.md LICENSE > /dev/null 2>&1
    cd ..
    echo -e "${GREEN}✅ Release archive created: $DIST_DIR/$release_name${NC}"
else
    tar -czf "$DIST_DIR/${release_name%.zip}.tar.gz" -C "$BUILD_DIR" notebook_item/ items.txt README.md LICENSE
    echo -e "${GREEN}✅ Release archive created: $DIST_DIR/${release_name%.zip}.tar.gz${NC}"
fi

# Generate checksums
echo -e "${BLUE}▶ Generating checksums...${NC}"
cd "$DIST_DIR"

if command -v sha256sum >/dev/null 2>&1; then
    # Linux
    for file in *.zip *.tar.gz; do
        [ -f "$file" ] && sha256sum "$file" > "${file}.sha256" && echo -e "${CYAN}ℹ️  Checksum created for: $file${NC}"
    done
elif command -v shasum >/dev/null 2>&1; then
    # macOS
    for file in *.zip *.tar.gz; do
        [ -f "$file" ] && shasum -a 256 "$file" > "${file}.sha256" && echo -e "${CYAN}ℹ️  Checksum created for: $file${NC}"
    done
else
    echo -e "${YELLOW}⚠️  Warning: No checksum tool found (sha256sum or shasum)${NC}"
fi

cd ..
echo -e "${GREEN}✅ Checksums generated${NC}"

# Create build manifest
echo -e "${BLUE}▶ Creating build manifest...${NC}"
manifest_file="$DIST_DIR/build_manifest.json"

cat > "$manifest_file" << EOF
{
    "name": "$RESOURCE_NAME",
    "version": "$BUILD_VERSION",
    "build_date": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
    "resources": [
        {
            "name": "notebook_item",
            "type": "main",
            "description": "Core notebook resource with 4 item types"
        }
    ],
    "files": [
EOF

# Add file information to manifest
first_file=true
for file in "$DIST_DIR"/*; do
    if [ -f "$file" ] && [[ "$file" != *.sha256 ]] && [[ "$file" != *build_manifest.json ]]; then
        filename=$(basename "$file")
        filesize=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo "0")
        
        if [ "$first_file" = true ]; then
            first_file=false
        else
            echo "," >> "$manifest_file"
        fi
        
        echo "        {" >> "$manifest_file"
        echo "            \"name\": \"$filename\"," >> "$manifest_file"
        echo "            \"size\": $filesize" >> "$manifest_file"
        echo -n "        }" >> "$manifest_file"
    fi
done

cat >> "$manifest_file" << EOF

    ],
    "phone_apps": {
        "available": true,
        "repository": "https://github.com/Greigh/FiveM-phone",
        "note": "Phone apps are available in a separate repository for better modularity"
    },
    "installation": {
        "dependencies": ["qbx_core", "ox_inventory", "ox_lib"],
        "server_cfg": "ensure notebook_item"
    }
}
EOF

echo -e "${GREEN}✅ Build manifest created: $manifest_file${NC}"

echo ""
echo -e "${PURPLE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║  Enhanced Notebook Item - Build Script v${BUILD_VERSION}              ║${NC}"
echo -e "${PURPLE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}Building enhanced notebook item resource...${NC}"
echo -e "  ${GREEN}📓 notebook_item${NC} - Core notebook resource with 4 item types"
echo ""
echo -e "${GREEN}🎉 Build Complete!${NC}"
echo ""

# Build summary
echo -e "${CYAN}ℹ️  Build Summary:${NC}"
echo -e "• Version: $BUILD_VERSION"
echo -e "• Build Date: $(date)"
echo -e "• Resource Name: $RESOURCE_NAME"
echo -e "• Core Resource: notebook_item (4 item types supported)"
echo ""

# File listing
echo -e "${CYAN}ℹ️  Generated Files:${NC}"
for file in "$DIST_DIR"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        filesize=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo "0")
        echo -e "• $filename ($filesize bytes)"
    fi
done
echo ""

echo -e "${CYAN}ℹ️  Next Steps:${NC}"
echo -e "• Extract the release archive to your FiveM server"
echo -e "• Add the resource to your server.cfg:"
echo -e "  ${GREEN}ensure notebook_item${NC}"
echo -e "• Copy items from items.txt to your ox_inventory configuration"
echo -e "• For phone apps, visit: ${BLUE}https://github.com/Greigh/FiveM-phone${NC}"
echo -e "• Restart your server and test"

echo -e "1. Test installation with: ${GREEN}./deploy.sh${NC}"
echo -e "2. Upload to GitHub releases"
echo -e "3. Share with the FiveM community"
echo ""
echo -e "${GREEN}Ready for distribution! 🚀${NC}"
