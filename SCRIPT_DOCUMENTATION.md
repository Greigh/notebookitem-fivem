# Script Documentation - Notebook Item Resource

This document explains all the scripts included in the notebook item resource project and how to use them.

## Master Control Script

### `notebook.sh` - Interactive Master Control

The main script that provides a unified interface for all operations.

```bash
./notebook.sh                    # Interactive menu
./notebook.sh validate          # Run validation
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

## Individual Scripts

### `validate.sh` - Resource Validation

Validates the resource structure and checks for common issues.

```bash
./validate.sh                   # Full validation
./validate.sh --quiet           # Quiet mode (minimal output)
```

**Checks:**

- Required files exist
- Lua syntax validation
- fxmanifest.lua configuration
- Export function presence

### `build.sh` - Build and Package

Creates distribution packages and release archives.

```bash
./build.sh                      # Full build process
./build.sh --clean              # Clean build directories only
```

**Creates:**

- Complete installation package (ZIP)
- Resource-only release archive (ZIP)
- SHA256 checksums
- Build manifest (JSON)

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
- Installation testing
- Detailed reporting

### `install.sh` - Simple Installation

Basic installation script for copying resource to server.

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
   # Make changes to code
   ./notebook.sh validate        # Validate changes
   ./notebook.sh build           # Build package
   ./notebook.sh test            # Test installation
   ```

2. **Release Workflow:**

   ```bash
   ./notebook.sh validate        # Final validation
   ./notebook.sh build           # Create distribution
   # Upload dist/*.zip to GitHub releases
   ```

### For Server Administrators

1. **First Time Installation:**

   ```bash
   ./notebook.sh install         # Quick install
   # OR
   ./deploy.sh                   # Full deployment
   ```

2. **Testing Installation:**

   ```bash
   ./notebook.sh test            # Test current installation
   ```

3. **Updating Resource:**

   ```bash
   ./deploy.sh                   # Handles backup automatically
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

### Version Control

- Commit scripts with the resource
- Tag releases after successful builds
- Include script changes in changelog

### Documentation

- Update this document when adding features
- Include usage examples for new options
- Document any external dependencies

This script ecosystem provides a complete solution for developing, building, testing, and deploying the notebook item resource efficiently and reliably.
