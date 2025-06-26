# Enhanced Multi-Item FiveM Resource

A comprehensive FiveM resource for qbox framework that adds multiple usable items with metadata storage capabilities. This enhanced version supports notebooks, journals, business cards, and photo descriptions.

## 🆕 **Enhanced Features**

### **Multiple Item Types**

- **📔 Personal Notebook**: Quick notes and thoughts (500 chars)
- **📖 Daily Journal**: Extended entries for detailed experiences (1000 chars)
- **💼 Business Card**: Professional contact information (300 chars)
- **📷 Personal Photo**: Photo descriptions and memories (250 chars)

### **Advanced Functionality**

- **Smart UI**: Each item type has custom icons and placeholders
- **Character Limits**: Different limits per item type for appropriate usage
- **Metadata Tracking**: Stores author, timestamp, and item type
- **Admin Tools**: `/checkitem [slot]` command for administrators
- **Backwards Compatibility**: Supports old notebook system

## 🎯 **Use Cases**

### **Roleplay Scenarios**

- **Journalists** can use journals for article drafts
- **Business owners** can exchange business cards with contact info
- **Photographers** can catalog their work with descriptions
- **Students** can take notes during classes
- **Investigators** can document evidence and observations

## 📋 **Dependencies**

- [qbx_core](https://github.com/Qbox-project/qbx_core) - Core framework
- [ox_inventory](https://github.com/overextended/ox_inventory) - Inventory system
- [ox_lib](https://github.com/overextended/ox_lib) - UI library and utilities

## 🚀 **Installation**

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

3. **Add to server.cfg**

   ```cfg
   ensure notebook_item
   ```

4. **Add Items to ox_inventory**
   - Copy all item definitions from `items.txt` to your `ox_inventory/data/items.lua`

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

- Backwards compatible with original notebook system
- Works with existing qbox/ox_inventory setups
- Supports multiple FiveM server versions

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

### **v2.0.0 - Enhanced Multi-Item System**

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

## 📞 **Support**

- **Documentation**: Check the `docs/` folder for detailed guides
- **Issues**: Report bugs via GitHub Issues
- **Wiki**: Visit the project wiki for advanced usage examples

## 📄 **License**

MIT License - see LICENSE file for details

## 🤝 **Contributing**

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run validation tests
5. Submit a pull request

---

### Made with ❤️ for the Rebirth FiveM roleplay community
