#!/usr/bin/env bash
# Installation script for omarchy-workspace-rename plugin

set -euo pipefail

PLUGIN_DIR="$HOME/.config/omarchy/plugins/omarchy.workspace-rename"
STATE_DIR="$HOME/.local/share/omarchy-workspace-rename"
BIN_PATH="$HOME/.local/bin/omarchy-workspace-rename"

echo "Installing omarchy-workspace-rename plugin..."

# Create state directory
mkdir -p "$STATE_DIR"
echo "✓ Created state directory: $STATE_DIR"

# Initialize empty state file if it doesn't exist
if [[ ! -f "$STATE_DIR/workspace-names.json" ]]; then
    echo '{}' > "$STATE_DIR/workspace-names.json"
    echo "✓ Initialized state file"
fi

# Make script executable
chmod +x "$PLUGIN_DIR/omarchy-workspace-rename"
echo "✓ Made script executable"

# Create symlink in ~/.local/bin for CLI access
mkdir -p "$HOME/.local/bin"
ln -sf "$PLUGIN_DIR/omarchy-workspace-rename" "$BIN_PATH"
echo "✓ Created CLI symlink: $BIN_PATH"

echo ""
echo "Installation complete!"
echo ""
echo "Usage:"
echo "  - Click any workspace number in the bar to rename it"
echo "  - Or use CLI: omarchy-workspace-rename <id> <name>"
echo "  - List names: omarchy-workspace-rename --list"
echo ""
echo "Restart Omarchy shell to activate:"
echo "  omarchy restart shell"
