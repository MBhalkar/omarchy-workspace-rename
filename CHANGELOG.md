# Changelog

## 1.0.1

### Fixed

- **Uninstall fallback**: Added `clonedFrom` metadata so uninstalling the plugin automatically restores the default `omarchy.workspaces` widget in your bar. Previously, removing the plugin left a broken reference and the workspace numbers disappeared.

### Changed

- Lowercased plugin ID from `io.github.MBhalkar.workspace-rename` to `io.github.mbhalkar.workspace-rename` for consistency.
- Removed unused manifest fields (`homepage`, `repository`, `keywords`, `keepLoaded`, `permissions`) that are not used by the omarchy plugin system.

### Migration

If you installed this plugin before v1.0.1, run:

```bash
omarchy plugin update io.github.mbhalkar.workspace-rename
```

This pulls the fix so uninstalling will correctly restore `omarchy.workspaces`.

## 1.0.0

Initial release.

- Click-to-rename workspace widget for the omarchy bar
- Interactive GUI panel with text input
- CLI tool (`omarchy-workspace-rename`) for renaming via terminal
- Persistent names stored in `~/.local/share/omarchy-workspace-rename/`
- Hyprland config auto-update with backup
