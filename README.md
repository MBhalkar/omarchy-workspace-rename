# Workspace Rename

Rename Hyprland workspaces with custom short names that persist across system restarts and Omarchy updates.

[View Workspace Rename on the Omarchy Plugin Marketplace](https://omarchyplugins.com/plugin.html?id=omarchy.workspace-rename)

## Features

- Rename workspaces with custom short text (e.g., "dev", "web", "chat")
- Names persist across system restarts
- Names persist across Omarchy updates
- Automatic Hyprland config backup before changes
- List all custom workspace names
- Reset individual workspaces to defaults

## Install

```bash
omarchy plugin add https://github.com/MBhalkar/omarchy-workspace-rename.git --enable
```

After installation, the `omarchy-workspace-rename` command will be available.

### Dependencies

The plugin uses standard tools included with Omarchy:
- `bash`
- `jq` (for JSON state management)
- `hyprctl` (for Hyprland integration)

## Usage

### Rename a workspace

```bash
omarchy-workspace-rename <workspace_id> <new_name>
```

Examples:
```bash
omarchy-workspace-rename 1 dev
omarchy-workspace-rename 2 web
omarchy-workspace-rename 3 chat
omarchy-workspace-rename 4 music
```

Workspace names:
- Cannot contain spaces (use underscores instead)
- Maximum 30 characters
- Workspace IDs must be between 1-10

### List all workspace names

```bash
omarchy-workspace-rename --list
```

### Reset a workspace to default

```bash
omarchy-workspace-rename --reset <workspace_id>
```

Example:
```bash
omarchy-workspace-rename --reset 1
```

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
