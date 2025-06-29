# Script Documentation - Notebook Item Resource

This document explains all the scripts included in the notebook item resource project and how to use them.

## Project Structure

The resource is focused on notebook items only:

- **notebook_item/**: Core notebook functionality resource for 4 supported item types
  - **notebook** - Personal notes and thoughts
  - **journal** - Extended diary entries
  - **businesscard** - Professional contact information  
  - **photo** - Photo descriptions and memories

**Note**: Phone apps and other integrations are handled in separate repositories for better modularity.

All scripts have been updated to work with this notebook-only structure.

## Master Control Script

### `notebook.sh` - Interactive Master Control

The main script that provides a unified interface for all notebook resource operations.

```bash
./notebook.sh                    # Interactive menu
./notebook.sh validate          # Run validation for notebook items
./notebook.sh build             # Build package
./notebook.sh deploy            # Deploy to server
./notebook.sh install           # Quick install
./notebook.sh test              # Test installation
./notebook.sh status            # Show project status
./notebook.sh clean             # Clean build files
```

**Features:**

- Interactive menu-driven interface
- Color-coded output for better readability
- Developer tools submenu
- Documentation viewer
- Project status overview
- Notebook-only validation and testing

## Notebook Item Validation

### Supported Items Only

The resource strictly validates and processes only these 4 item types:

- **notebook**: Personal notes and thoughts (500 character limit)
- **journal**: Extended diary entries (1000 character limit)
- **businesscard**: Professional contact information (300 character limit)
- **photo**: Photo descriptions and memories (250 character limit)

### Validation Process

Any item not in the supported list will be rejected with clear error messages, ensuring focused functionality and preventing conflicts.

## Individual Scripts

### `validate.sh` - Resource Validation

Validates the notebook resource structure and checks for common issues.

```bash
./validate.sh                   # Full validation
./validate.sh --quiet           # Quiet mode (minimal output)
```

**Checks:**

- Required files exist for notebook_item resource
- Lua syntax validation
- fxmanifest.lua configuration
- Export function presence
- Notebook item configuration validation
- Item type support verification
- Notebook item limit validation
- Icon and asset verification

### `build.sh` - Build and Package

Creates distribution packages and release archives for the notebook item resource.

```bash
./build.sh                      # Full build process
./build.sh --clean              # Clean build directories only
```

**Creates:**

- Complete installation package (ZIP)
- Resource-only release archive (ZIP)
- Notebook item configuration packages
- SHA256 checksums
- Build manifest (JSON)

### Notebook Item Deployment

The build script focuses on the notebook item resource:

```bash
./build.sh                      # Builds the notebook_item resource
```

**Package Contents:**

- notebook_item resource folder
- Installation scripts
- Configuration files
- Documentation

### `deploy.sh` - Server Deployment

Comprehensive deployment script with validation and configuration.

```bash
./deploy.sh                     # Interactive deployment
./deploy.sh --validate-only     # Validation only
```

**Features:**

- Resource structure validation
- Automatic backup of existing installations
- server.cfg configuration
- ox_inventory integration check
- Notebook item configuration validation
- Item type support verification
- Installation testing
- Detailed reporting

### Deployment Options

The deployment script focuses on notebook items only:

```bash
./deploy.sh                     # Interactive deployment with notebook validation
./deploy.sh --notebook-only     # Deploy only the notebook_item resource
```

**Resource Integration:**

- **qbox/qbx_core**: Framework compatibility validation
- **ox_inventory**: Item definition setup
- **ox_lib**: UI library integration
- Notebook item validation and testing

### `install.sh` - Simple Installation

Basic installation script for copying the notebook resource to server.

```bash
./install.sh                    # Interactive installation
```

**Features:**

- Simple path-based installation
- Basic validation
- Next steps guidance

## Usage Workflows

### For Developers

1. **Development Workflow:**

   ```bash
   # Make changes to code (notebook_item or phone_apps)
   ./notebook.sh validate        # Validate all resources
   ./notebook.sh build           # Build complete suite
   ./notebook.sh test            # Test installation
   ```

2. **Phone App Development:**

   ```bash
   # Working on phone apps specifically
   ./validate.sh                 # Validate phone app structure
   # Test individual phone apps
   # Modify web UI files in phone_apps/*/web/
   ./build.sh                    # Build updated packages
   ```

3. **Release Workflow:**

   ```bash
   ./notebook.sh validate        # Final validation of all resources
   ./notebook.sh build           # Create distribution packages
   # Upload dist/*.zip to GitHub releases
   ```

### For Server Administrators

1. **Complete Suite Installation:**

   ```bash
   ./notebook.sh install         # Install all resources
   # OR
   ./deploy.sh                   # Full deployment with phone apps
   ```

2. **Phone Apps Only:**

   ```bash
   ./deploy.sh --phone-apps-only # Install only phone applications
   ```

3. **Selective Installation:**

   ```bash
   # Copy individual resources as needed:
   # - notebook_item/ (core functionality)
   # - phone_apps/notebook_phone_app/
   # - phone_apps/invoice_phone_app/
   # - phone_apps/unified_phone_app/
   ```

## Script Features

### Color Coding

- 🔵 **Blue**: Steps and actions
- 🟢 **Green**: Success messages
- 🟡 **Yellow**: Warnings
- 🔴 **Red**: Errors
- 🟣 **Purple**: Headers
- 🔷 **Cyan**: Information

### Error Handling

- All scripts use `set -e` for immediate error exit
- Comprehensive error messages
- Graceful failure handling
- Backup creation before destructive operations

### Interactive Features

- Menu-driven interfaces
- Progress indicators
- User confirmation prompts
- Clear next-step guidance

## File Outputs

### Build Artifacts (`build.sh`)

``` plaintext
dist/
├── notebook_item_v1.0.0_YYYYMMDD_HHMMSS.zip      # Complete package
├── notebook_item_v1.0.0_YYYYMMDD_HHMMSS.zip.sha256
├── notebook_item_release_v1.0.0.zip               # Resource only
├── notebook_item_release_v1.0.0.zip.sha256
└── build_manifest.json                            # Build metadata
```

### Deployment Reports (`deploy.sh`)

``` plaintext
installation_report_YYYYMMDD_HHMMSS.txt           # Installation details
```

### Backup Files (`deploy.sh`)

``` plaintext
server/resources/notebook_item_backup_YYYYMMDD_HHMMSS/  # Automatic backups
```

## Dependencies

### Required Tools

- **bash**: Shell interpreter
- **zip**: Archive creation (for build.sh)
- **find**: File searching
- **grep**: Text searching
- **cp/mv/rm**: File operations

### Optional Tools

- **lua**: Syntax validation (recommended)
- **tree**: Directory structure display
- **less**: Document viewer

### System Compatibility

- ✅ macOS (tested)
- ✅ Linux (should work)
- ❓ Windows (via WSL/Git Bash)

## Advanced Usage

### Custom Validation

```bash
# Add custom checks to validate.sh
if ! custom_check; then
    print_error "Custom validation failed"
    ((errors++))
fi
```

### Build Customization

```bash
# Modify build.sh to include additional files
additional_files=("custom_config.lua" "extra_docs.md")
for file in "${additional_files[@]}"; do
    [ -f "$file" ] && cp "$file" "$BUILD_DIR/"
done
```

### Deployment Hooks

```bash
# Add pre/post deployment hooks to deploy.sh
pre_deploy_hook() {
    # Custom pre-deployment actions
}

post_deploy_hook() {
    # Custom post-deployment actions
}
```

## Troubleshooting

### Common Issues

1. **Permission Denied**

   ```bash
   chmod +x *.sh              # Make scripts executable
   ```

2. **Lua Not Found**

   ```bash
   # Install Lua (macOS)
   brew install lua
   
   # Install Lua (Ubuntu/Debian)
   sudo apt-get install lua5.4
   ```

3. **Script Not Found**

   ```bash
   ls -la *.sh                # Check script existence
   pwd                        # Verify current directory
   ```

### Phone App Issues

1. **Phone App Not Showing**

   ```bash
   # Check phone system compatibility
   # Verify phone_apps folder structure
   # Check fxmanifest.lua client_scripts
   ```

2. **Web UI Not Loading**

   ```bash
   # Verify web/ folder exists in phone app
   # Check HTML/CSS/JS files are present
   # Validate NUI callbacks registration
   ```

3. **Icons Missing (lb-phone)**

   ```bash
   # Check if icon.png exists in phone app root
   # Verify icon path in fxmanifest.lua
   # Follow lb-phone icon setup guide
   ```

### Phone System Specific

1. **qb-phone Integration**

   ```bash
   # Ensure qb-phone is running
   # Check exports are correctly configured
   # Verify phone app registration
   ```

2. **lb-phone Integration**

   ```bash
   # Verify lb-phone app registration
   # Check icon file placement
   # Validate app manifest format
   ```

3. **qs-smartphone Integration**

   ```bash
   # Check qs-smartphone configuration
   # Verify app registration method
   # Validate callback structure
   ```

### Debug Mode

Most scripts support verbose output:

```bash
# Enable debug output
set -x                       # Add to script for debugging
```

## Integration with GitHub

### GitHub Actions

The included `.github/workflows/validate.yml` uses these scripts:

```yaml
- name: Validate resource structure
  run: ./validate.sh

- name: Check Lua syntax
  run: find notebook_item -name "*.lua" -exec lua -l {} \;
```

### Release Process

1. Run `./build.sh` to create distribution packages
2. Upload `dist/*.zip` files to GitHub releases
3. Include `build_manifest.json` in release notes

## Best Practices

### Script Maintenance

- Keep scripts executable: `chmod +x *.sh`
- Use consistent error handling
- Maintain color coding standards
- Update version numbers when modifying

### Phone App Development

- Test on all supported phone systems
- Maintain responsive web UI design
- Follow phone system specific guidelines:
  - **qb-phone**: Use qb-phone app structure
  - **lb-phone**: Include proper icon files and registration
  - **qs-smartphone**: Follow qs app manifest format
- Keep web assets optimized for mobile view
- Use consistent UI/UX patterns across apps

### Resource Structure

- Keep phone apps in the `phone_apps/` directory
- Maintain consistent folder structure across apps
- Use modular code organization (client/server/shared)
- Document phone system compatibility clearly

### Version Control

- Commit scripts with the resource
- Tag releases after successful builds
- Include script changes in changelog

### Documentation

- Update this document when adding features
- Include usage examples for new options
- Document any external dependencies

This script ecosystem provides a complete solution for developing, building, testing, and deploying the entire notebook resource suite efficiently and reliably. The suite includes the core notebook_item resource and comprehensive phone app integrations for all major FiveM phone systems.
