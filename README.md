# Workspace Rename

Rename Hyprland workspaces with custom short names via an interactive GUI panel. Names persist across system restarts and Omarchy updates.

[View Workspace Rename on the Omarchy Plugin Marketplace](https://omarchyplugins.com/plugin.html?id=omarchy.workspace-rename)

![Workspace Rename Demo](preview.png)

## Features

- 🖱️ Click-to-rename: Click any workspace number to open the rename panel
- ⌨️ Interactive GUI: Type your custom name in a text field
- 💾 Persistent: Names survive restarts and Omarchy updates
- 🔄 Easy reset: Reset any workspace to its default name
- 🎨 Theme-aware: Panel follows your Omarchy theme
- 🚀 No dependencies: Uses only Omarchy-included tools

## Install

```bash
omarchy plugin add https://github.com/MBhalkar/omarchy-workspace-rename.git --enable
```

After installation, the workspace numbers in your bar will be clickable.

### Dependencies

The plugin uses standard tools included with Omarchy:
- `bash`
- `jq` (for JSON state management)
- `hyprctl` (for Hyprland integration)
- Quickshell (Omarchy's shell framework)

## Usage

### GUI Method (Recommended)

1. **Left-click** any workspace number to switch to that workspace (normal behavior)
2. **Right-click** any workspace number to open the rename panel
3. A rename panel appears below with a text field
4. **Type** your custom name (spaces will be converted to underscores)
5. **Press Enter** or click **Save** to apply
6. Click **Reset** to restore the default name
7. Click **Cancel** or **Esc** to close without saving

### CLI Method

The plugin also provides a command-line tool:

```bash
# Rename a workspace
omarchy-workspace-rename <workspace_id> <new_name>

# Reset a workspace to original number (just provide the ID)
omarchy-workspace-rename <workspace_id>

# List all workspace names
omarchy-workspace-rename --list

# Reset a workspace to default
omarchy-workspace-rename --reset <workspace_id>
```

Examples:
```bash
omarchy-workspace-rename 1 dev
omarchy-workspace-rename 2 web
omarchy-workspace-rename 3 terminal
omarchy-workspace-rename 1          # Resets workspace 1 to just "1"
omarchy-workspace-rename --list
omarchy-workspace-rename --reset 1
```

### Naming Rules

- Workspace IDs must be between 1-10
- Names are limited to 30 characters
- Spaces are automatically converted to underscores
- Empty names are not allowed

## How it works

The plugin:
1. Displays workspace numbers as clickable buttons in your bar
2. When clicked, shows an overlay panel with a text field
3. Stores your custom names in `~/.local/share/omarchy-workspace-rename/workspace-names.json`
4. Updates workspace rules in `~/.config/hypr/hyprland.lua`
5. Creates automatic backups before modifying Hyprland config
6. Reloads Hyprland to apply changes immediately

Workspace names are formatted as `{id}_{custom_name}` (e.g., `1_dev`, `2_web`), preserving the numeric ID for keyboard navigation while displaying your custom label.

## Data Storage

- **Workspace names**: `~/.local/share/omarchy-workspace-rename/workspace-names.json`
- **Hyprland config**: `~/.config/hypr/hyprland.lua` (automatically backed up)
- **Backups**: `~/.config/hypr/hyprland.lua.bak.<timestamp>`

## Remove

```bash
omarchy plugin remove omarchy.workspace-rename
```

Your workspace names will remain in `~/.local/share/omarchy-workspace-rename/` so reinstalling restores them. To completely remove all data:

```bash
rm -rf ~/.local/share/omarchy-workspace-rename/
```

## Examples

### Quick rename workflow

1. Click workspace "1" in the bar
2. Type "dev" and press Enter
3. Click workspace "2" in the bar  
4. Type "browser" and press Enter
5. Done! Your workspaces are now labeled "1_dev" and "2_browser"

### Using the CLI

```bash
# Batch rename multiple workspaces
omarchy-workspace-rename 1 code
omarchy-workspace-rename 2 browser
omarchy-workspace-rename 3 terminal
omarchy-workspace-rename 4 music
omarchy-workspace-rename 5 chat

# Check your changes
omarchy-workspace-rename --list
```

Output:
```
Current workspace names:

  Workspace 1: code
  Workspace 2: browser
  Workspace 3: terminal
  Workspace 4: music
  Workspace 5: chat
```

## Troubleshooting

### Panel doesn't appear

Make sure the plugin is enabled and loaded:
```bash
omarchy plugin list
omarchy restart shell
```

### Config backups

Every rename creates a timestamped backup:
```
~/.config/hypr/hyprland.lua.bak.1726158386
```

Restore a backup manually if needed:
```bash
cp ~/.config/hypr/hyprland.lua.bak.<timestamp> ~/.config/hypr/hyprland.lua
hyprctl reload
```

### State file format

The state file uses plain JSON:
```json
{
  "1": "code",
  "2": "browser",
  "3": "terminal"
}
```

You can edit it manually, then reload the shell to apply.

## License

MIT License - see [LICENSE](LICENSE) for details.

## How it works

The plugin:
1. Stores your custom workspace names in `~/.local/share/omarchy-workspace-rename/workspace-names.json`
2. Updates the workspace rules in `~/.config/hypr/hyprland.lua`
3. Creates automatic backups of your Hyprland config before each change
4. Reloads Hyprland to apply changes immediately

Your workspace names are formatted as `{id}_{custom_name}` (e.g., `1_dev`, `2_web`), preserving the numeric ID for easy keyboard navigation while showing your custom label.

## Data Storage

- **Workspace names**: `~/.local/share/omarchy-workspace-rename/workspace-names.json`
- **Hyprland config**: `~/.config/hypr/hyprland.lua` (automatically backed up before changes)
- **Backups**: `~/.config/hypr/hyprland.lua.bak.<timestamp>`

## Remove

```bash
omarchy plugin remove omarchy.workspace-rename
```

Your workspace names will remain in `~/.local/share/omarchy-workspace-rename/` so reinstalling restores them. To completely remove all data:

```bash
rm -rf ~/.local/share/omarchy-workspace-rename/
```

## Examples

### Rename multiple workspaces

```bash
omarchy-workspace-rename 1 code
omarchy-workspace-rename 2 browser
omarchy-workspace-rename 3 terminal
omarchy-workspace-rename 4 music
omarchy-workspace-rename 5 chat
```

### Check current workspace names

```bash
omarchy-workspace-rename --list
```

Output:
```
Current workspace names:

  Workspace 1: code
  Workspace 2: browser
  Workspace 3: terminal
  Workspace 4: music
  Workspace 5: chat
```

### Reset a workspace

```bash
omarchy-workspace-rename --reset 3
```

## Troubleshooting

### Config backups

Every time you rename a workspace, the plugin creates a timestamped backup:
```
~/.config/hypr/hyprland.lua.bak.1726158386
```

You can restore a backup manually if needed:
```bash
cp ~/.config/hypr/hyprland.lua.bak.<timestamp> ~/.config/hypr/hyprland.lua
hyprctl reload
```

### State file format

The state file is plain JSON:
```json
{
  "1": "code",
  "2": "browser",
  "3": "terminal"
}
```

You can edit it manually if needed, then re-run the command to apply changes.

## License

MIT License - see [LICENSE](LICENSE) for details.
