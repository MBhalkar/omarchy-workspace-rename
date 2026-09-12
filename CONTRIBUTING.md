# Omarchy Workspace Rename Plugin

A simple plugin to rename Hyprland workspaces with persistent custom names.

## Plugin Files

- `manifest.json` - Plugin metadata for Omarchy
- `omarchy-workspace-rename` - Main executable script
- `README.md` - User documentation
- `LICENSE` - MIT License

## Installation for Development

From this directory:

```bash
# Link to Omarchy plugins directory for testing
ln -sf "$(pwd)" ~/.config/omarchy/plugins/omarchy.workspace-rename

# Make script executable
chmod +x omarchy-workspace-rename

# Test the plugin
./omarchy-workspace-rename --help
```

## Publishing to omarchyplugins.com

This plugin is ready for submission to the Omarchy Plugin Marketplace.

### Requirements Met

✅ Valid `manifest.json` with all required fields  
✅ MIT License included  
✅ Comprehensive README with usage examples  
✅ Persistent storage in `~/.local/share/`  
✅ User config modifications with automatic backups  
✅ No external dependencies (uses Omarchy-included tools)  
✅ Follows Omarchy naming conventions  
✅ Proper error handling and validation  

### GitHub Repository Setup

1. Initialize git repository:
```bash
git init
git add .
git commit -m "Initial commit: Workspace rename plugin"
```

2. Create GitHub repository at `https://github.com/MBhalkar/omarchy-workspace-rename`

3. Push to GitHub:
```bash
git remote add origin https://github.com/MBhalkar/omarchy-workspace-rename.git
git branch -M main
git push -u origin main
```

4. Create a release tag:
```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

### Submit to omarchyplugins.com

Follow the submission guidelines at omarchyplugins.com to submit your plugin.
