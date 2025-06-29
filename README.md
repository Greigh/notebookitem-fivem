# 📓 Enhanced Notebook Item FiveM Resource

A focused FiveM resource for qbox/qbx_core servers that provides advanced notebook functionality for four specific item types. This resource offers rich metadata tracking, modern UI, and seamless integration with ox_inventory and ox_lib.

## 📓 **Notebook Items Only**

This resource is specifically designed for notebook-related items and strictly validates that only supported notebook items are processed:

- **📔 notebook** - Personal notes and thoughts
- **📖 journal** - Extended diary entries  
- **💼 businesscard** - Professional contact information
- **📷 photo** - Photo descriptions and memories

**Note**: Phone apps and other item types are handled in separate repositories for better modularity and focused functionality.-Item FiveM Resource

A comprehensive FiveM resource for qbox/qbx_core servers that provides advanced notebook functionality with support for multiple item types. This resource offers rich metadata tracking, modern UI, and seamless integration with ox_inventory and ox_lib.

## 📱 **Phone Apps Available Separately**

**� Phone Apps Repository**: [FiveM-phone](https://github.com/Greigh/FiveM-phone)

The phone apps have been moved to a separate repository for better modularity:

- **📱 notebook_phone_app**: Access and edit notebooks via phone
- **💰 invoice_phone_app**: Professional invoice management system  
- **🚀 unified_phone_app**: Combined notebook + invoice interface

## 📓 **Core Resource Features**

### **Main Resource**

- **📓 notebook_item**: Advanced notebook resource with 4 item types

## 🆕 **Key Features**

### **Supported Notebook Items**

- **📔 notebook**: Personal notes and quick thoughts (500 characters)
- **📖 journal**: Extended diary entries for detailed experiences (1000 characters)
- **💼 businesscard**: Professional contact information (300 characters)
- **📷 photo**: Photo descriptions and memories (250 characters)

### **Advanced Functionality**

- **Strict Validation**: Only processes the 4 supported notebook item types
- **Smart UI**: Each item type has custom icons and placeholders
- **Character Limits**: Different limits per item type for appropriate usage
- **Metadata Tracking**: Stores author, timestamp, and item type
- **Admin Tools**: `/checkitem [slot]` command for administrators
- **Error Handling**: Clear feedback for unsupported items

## 🎯 **Use Cases**

### **Roleplay Scenarios**

- **Journalists** can use journals for article drafts and notes
- **Business owners** can create and exchange business cards
- **Photographers** can catalog their work with photo descriptions
- **Students** can take notes during classes using notebooks
- **Investigators** can document evidence and observations
- **Citizens** can maintain personal diaries and journals

### **Supported Items Only**

This resource strictly processes only the four supported notebook item types. Any other item types will be rejected with clear error messages, ensuring focused functionality and preventing conflicts with other systems.

## 📋 **Dependencies**

- [qbx_core](https://github.com/Qbox-project/qbx_core) - Core framework
- [ox_inventory](https://github.com/overextended/ox_inventory) - Inventory system
- [ox_lib](https://github.com/overextended/ox_lib) - UI library and utilities

## 🚀 **Installation**

### **Automated Installation (Recommended)**

1. **Download the Resource**

   ```bash
   git clone https://github.com/yourusername/enhanced-notebook-item.git
   cd enhanced-notebook-item
   ```

2. **Run Installation Script**

   ```bash
   chmod +x install.sh
   ./install.sh
   ```

### **Manual Installation**

1. **Copy Resource to Server**

   ```bash
   cp -r notebook_item /path/to/your/server/resources/
   ```

2. **Add to server.cfg**

   ```cfg
   ensure notebook_item
   ```

3. **Add Items to ox_inventory**
   - Copy items from `items.txt` to your ox_inventory items.lua
   - Or use the automated script to add them

## 📝 **Item Definitions**

```lua
-- All four item types with different characteristics
['notebook'] = { /* 500 char limit, general notes */ },
['journal'] = { /* 1000 char limit, detailed entries */ },
['businesscard'] = { /* 300 char limit, contact info */ },
['photo'] = { /* 250 char limit, photo descriptions */ }
```

## 🎮 **Usage Examples**

### **For Players**

1. **Taking Meeting Notes**
   - Use notebook for quick bullet points
   - Use journal for detailed meeting summaries

2. **Business Networking**
   - Create business cards with contact information
   - Share professional details with other players

3. **Photography Documentation**
   - Add descriptions to memorable photos
   - Document special moments and locations

### **For Administrators**

```bash
# Give items to players
/give [player_id] notebook 1
/give [player_id] journal 1
/give [player_id] businesscard 1
/give [player_id] photo 1

# Check item content (admin only)
/checkitem [slot_number]
```

## ⚙️ **Configuration**

### **Item Limits (shared/config.lua)**

```lua
config.items = {
    notebook = { maxLength = 500 },
    journal = { maxLength = 1000 },
    businesscard = { maxLength = 300 },
    photo = { maxLength = 250 }
}
```

### **Advanced Features (shared/advanced.lua)**

- Content sharing between players (future)
- Password protection for sensitive items (future)
- Content categorization system (future)
- Job-based restrictions
- Usage statistics tracking

## 🔧 **Development Tools**

### **Validation & Testing**

```bash
./validate.sh          # Validate resource structure
./notebook.sh test      # Run comprehensive tests
```

### **Build & Deploy**

```bash
./build.sh             # Create distribution packages
./deploy.sh            # Deploy to FiveM server
```

### **Master Control**

```bash
./notebook.sh          # Interactive menu for all operations
```

## 📊 **Technical Features**

### **Security**

- Server-side input validation
- XSS protection through sanitization
- Character limits per item type
- Player verification before updates

### **Performance**

- Efficient metadata storage
- Minimal network overhead
- Optimized UI interactions
- Smart caching of configurations

### **Compatibility**

- **Notebook-focused**: Designed specifically for the 4 supported notebook item types
- **QBox/QBX Integration**: Full compatibility with qbox/qbx_core framework
- **ox_inventory**: Seamless integration with ox_inventory system
- **Server Compatibility**: Works with multiple FiveM server versions

## 🏗️ **File Structure**

``` plaintext
notebook_item/
├── fxmanifest.lua              # Resource manifest
├── shared/
│   ├── config.lua              # Item configurations
│   └── advanced.lua            # Advanced feature settings
├── client/
│   └── main.lua                # Client-side UI and interactions
└── server/
    └── main.lua                # Server-side validation and storage
```

## 🔄 **Changelog**

### **v1.1.0 - Notebook-Only Consolidation**

- ✅ **Strict Validation**: Only processes the 4 supported notebook item types
- ✅ **Enhanced Security**: Rejects unsupported items with clear error messages
- ✅ **Focused Functionality**: Removed all non-notebook logic for better performance
- ✅ **Improved Validation**: Better error handling and user feedback
- ✅ **Code Cleanup**: Consolidated codebase for notebook items only

### **v1.0.1 - Enhanced Multi-Item System**

- ✅ Added journal, business card, and photo items
- ✅ Individual character limits per item type
- ✅ Enhanced UI with custom icons and placeholders
- ✅ Admin inspection tools
- ✅ Improved metadata tracking
- ✅ Advanced configuration options

### **v1.0.0 - Original Notebook System**

- ✅ Basic notebook functionality
- ✅ Metadata storage
- ✅ Server-side validation

## 🧩 **Development Setup**

### **Lua Diagnostics Configuration**

This resource includes proper Lua Language Server configuration for VS Code to eliminate diagnostics warnings during development.

**Key Features:**

- ✅ **FiveM Globals**: All common FiveM functions are recognized (`TriggerEvent`, `RegisterNetEvent`, etc.)
- ✅ **Framework Support**: QBX, ESX, ox_lib globals are included
- ✅ **Server Functions**: Server-side functions like `GetPlayers`, `TriggerClientEvent` are configured
- ✅ **Clean Development**: No false positive errors for valid FiveM code

**Setup Instructions:**

1. Install the Lua Language Server extension in VS Code (`sumneko.lua`)
2. The `.luarc.json` file is already configured for FiveM development
3. Restart the Lua Language Server: `Cmd+Shift+P` → `Lua: Restart Server`

**Files Included:**

- `.luarc.json` - Main Lua configuration
- `.vscode/settings.json` - VS Code workspace settings
- `LUA_DIAGNOSTICS_SETUP.md` - Detailed setup documentation

For more details, see the [Lua Diagnostics Setup Guide](LUA_DIAGNOSTICS_SETUP.md).

## 📞 **Support**

- **Documentation**: Check the project documentation for detailed guides
- **Issues**: Report bugs via GitHub Issues
- **Validation**: Use `./validate.sh` to check your installation

## 📄 **License**

MIT License - see LICENSE file for details

## 🤝 **Contributing**

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run validation tests with `./validate.sh`
5. Submit a pull request

---

### 📓 Enhanced Notebook Item Resource - Focused on notebook functionality only
