# Workspace Rename Plugin - Usage Guide

## Current Status

The plugin is installed and functional via **command-line interface (CLI)**:

### Rename a workspace
```bash
omarchy-workspace-rename 1 dev
omarchy-workspace-rename 2 browser
omarchy-workspace-rename 3 terminal
```

### List all renamed workspaces
```bash
omarchy-workspace-rename --list
```

### Reset a workspace to default
```bash
omarchy-workspace-rename --reset 1
```

## Known Limitation

**GUI panel (right-click) is not functional** due to Omarchy's WidgetButton component limitations with custom mouse event handling. The workspaces display correctly and left-click to switch works as expected.

## Workaround

Use the CLI tool to rename workspaces. The custom names will appear in the bar automatically.

## Technical Notes

- Custom names are stored in: `~/.local/share/omarchy-workspace-rename/workspace-names.json`
- Names persist across reboots and Omarchy updates
- Left-click on workspace numbers switches to that workspace (default behavior preserved)
- The bar widget displays custom workspace names in the format: `{id}_{name}` (e.g., `1_dev`, `2_browser`)

## Workspace 5 Grayed Out

Workspace 5 appears grayed out because it has no windows open and is not the currently focused workspace. This is normal Hyprland/Omarchy behavior - workspaces dim when empty and not active.

