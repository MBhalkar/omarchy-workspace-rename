# Workspace Rename Plugin - Usage Guide

## GUI Rename (Bar Widget)

Click the **currently focused** workspace name in the bar to open a rename panel. Type a new name and press **Enter** to save. Press **Escape** or click outside the panel to cancel.

- Empty or whitespace-only input leaves the current name unchanged
- Names cannot contain spaces (use underscores instead)
- Maximum 30 characters

Left-click on a **non-focused** workspace switches to it (standard behavior).

## Command-Line Interface (CLI)

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

## Technical Notes

- Custom names are stored in: `~/.local/share/omarchy-workspace-rename/workspace-names.json`
- Names persist across reboots and Omarchy updates
- The bar widget displays custom workspace names automatically
- Left-click on workspace numbers switches to that workspace (default behavior preserved)

## Workspace 5 Grayed Out

Workspace 5 appears grayed out because it has no windows open and is not the currently focused workspace. This is normal Hyprland/Omarchy behavior - workspaces dim when empty and not active.
