#!/bin/bash

# Notebook Item Resource Installation Script
# This script helps install the notebook_item resource to your FiveM server

echo "🔧 Notebook Item Resource Installation Script"
echo "=============================================="

# Function to check if directory exists
check_directory() {
    if [ -d "$1" ]; then
        return 0
    else
        return 1
    fi
}

# Get FiveM server path
echo ""
echo "📁 Please enter the path to your FiveM server's resources directory:"
read -r server_path

# Validate the path
if ! check_directory "$server_path"; then
    echo "❌ Error: Directory '$server_path' does not exist."
    echo "Please make sure you've entered the correct path to your FiveM server's resources folder."
    exit 1
fi

# Copy the resource
resource_source="./notebook_item"
resource_dest="$server_path/notebook_item"

echo ""
echo "📦 Copying notebook_item resource..."

if cp -r "$resource_source" "$server_path/"; then
    echo "✅ Resource copied successfully to: $resource_dest"
else
    echo "❌ Error: Failed to copy resource. Please check permissions."
    exit 1
fi

# Show next steps
echo ""
echo "🎉 Installation completed successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Add 'ensure notebook_item' to your server.cfg file"
echo "2. Add the notebook item to your ox_inventory items.lua file"
echo "   (See items.txt for the item definition)"
echo "3. Restart your FiveM server"
echo "4. Give yourself a notebook item: /give [player_id] notebook 1"
echo ""
echo "📖 For detailed instructions, see the README.md file"
echo ""
echo "Happy roleplaying! 🎮"
