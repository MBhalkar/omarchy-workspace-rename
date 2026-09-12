# New session - 2026-09-12T13:37:47.628Z

**Session ID:** ses_f6a295993ffeRh1QPB6sAiGkAL
**Created:** 9/12/2026, 7:07:47 PM
**Updated:** 9/12/2026, 8:03:54 PM

---

## User

add omarchy skill

---

## Assistant (Build · Muse Spark 1.3 Free · 3.0s)

_Thinking:_



Adding your Omarchy skill — loading it now.

**Tool: skill**

**Input:**
```json
{
  "name": "omarchy"
}
```

**Output:**
```
<skill_content name="omarchy">
# Skill: omarchy

# Omarchy Skill

Manage [Omarchy](https://omarchy.org/) Linux systems - a beautiful, modern, opinionated Arch Linux distribution with Hyprland.

This skill is for end-user customization on installed systems.
It is not for contributing to Omarchy source code.

## When This Skill MUST Be Used

**ALWAYS invoke this skill for end-user requests involving ANY of these:**

- Editing ANY file in `~/.config/hypr/` (window rules, animations, keybindings, monitors, etc.)
- Editing `~/.config/omarchy/shell.json` (status bar layout, widgets)
- Editing terminal configs (alacritty, foot, kitty, ghostty)
- Editing ANY file in `~/.config/omarchy/`
- Window behavior, animations, opacity, blur, gaps, borders
- Layer rules, workspace settings, display/monitor configuration
- Themes, backgrounds, fonts, appearance changes
- User-facing `omarchy` commands (`omarchy theme ...`, `omarchy refresh ...`, `omarchy restart ...`, etc.)
- Screenshots, screen recording, reminders, night light, idle behavior, lock screen

**If you're about to edit a config file in ~/.config/ on this system, STOP and use this skill first.**

**Do NOT use this skill for Omarchy development tasks** (editing the Omarchy source tree, creating migrations, or running `omarchy dev ...` workflows).

## Topic Guides

Deeper instructions for common areas live next to this file. Read the
matching guide before starting:

- [`hyprland.md`](hyprland.md) - keybindings, monitors, window rules, and other Hyprland config
- [`plugins.md`](plugins.md) - the Omarchy shell: bar layout, widgets, plugins, idle behavior
- [`theming.md`](theming.md) - themes, backgrounds, and fonts
- [`hooks.md`](hooks.md) - automation hooks that run on system events
- [`capture.md`](capture.md) - screenshots, screen recordings, OCR text capture, and file sharing
- [`contributing.md`](contributing.md) - reporting Omarchy bugs and submitting fixes upstream

## Critical Safety Rules

For privileged commands, follow the Privilege Escalation rules below: `sudo` when a terminal is available for the password prompt, `pkexec` when it is not. Do not wrap commands that already manage privilege elevation themselves.

**For end-user customization tasks, NEVER modify anything in `/usr/share/omarchy/`** - but READING is safe and encouraged.

This directory is owned by the omarchy package. Any local changes will be
overwritten on the next `omarchy update`.

```
/usr/share/omarchy/     # READ-ONLY - NEVER EDIT (reading is OK)
├── bin/                    # Command source (packaged binaries are on PATH)
├── config/                 # Default config templates
├── themes/                 # Stock themes
├── default/                # System defaults
├── shell/                  # Omarchy shell source and defaults
├── migrations/             # Update migrations
└── install/                # Installation scripts
```

**Reading `/usr/share/omarchy/` is SAFE and useful** - do it freely to:
- Understand how omarchy commands work: `omarchy theme set --help` or `cat $(which omarchy-theme-set)`
- See default configs before customizing: `cat "$OMARCHY_PATH/config/omarchy/shell.json"`
- Check stock theme files to copy for customization
- Reference default hyprland settings: `cat /usr/share/omarchy/default/hypr/*`

**Always use these safe locations instead:**
- `~/.config/` - User configuration (safe to edit)
- `~/.config/omarchy/themes/<custom-name>/` - Custom themes
- `~/.config/omarchy/hooks/` - Custom automation hooks

If the request is to develop Omarchy itself, this skill is out of scope. Follow repository development instructions instead of this skill.

## Privilege Escalation

For an interactive script or command run in a visible terminal, use `sudo` for
privileged work. Omarchy may grant passwordless `sudo` access to particular
commands, and the terminal is the appropriate place to request a password
when one is needed.

Use `pkexec` only when the caller cannot interact with a terminal or cannot
enter a password there, such as a command launched by an agent or a graphical
background process. Do not replace `sudo` with `pkexec` merely because a
command changes system state.

## System Architecture

Omarchy is built on:

| Component | Purpose | Config Location |
|-----------|---------|-----------------|
| **Arch Linux** | Base OS | `/etc/`, `~/.config/` |
| **Hyprland** | Wayland compositor/WM | `~/.config/hypr/` |
| **Omarchy shell** | Status bar + notifications (Quickshell) | `~/.config/omarchy/shell.json` |
| **Launcher/menus** | Quickshell menu | `~/.config/omarchy/extensions/omarchy-menu.jsonc` |
| **Alacritty/Foot/Kitty/Ghostty** | Terminals | `~/.config/<terminal>/` |
| **Omarchy OSD** | On-screen display | Quickshell plugin |

## Command Discovery

Omarchy ships a single `omarchy` CLI that dispatches to all `omarchy-*` binaries via `omarchy <group> <action>`. Always prefer this form — it is self-documenting and stable. The underlying `omarchy-*` binaries still exist on `PATH` and remain safe to read for source.

```bash
# List every documented command and its summary (--all includes hidden commands)
omarchy commands

# Show the commands inside a group
omarchy theme --help
omarchy refresh --help
omarchy restart --help

# Show help for a specific command (does not execute it)
omarchy theme set --help

# Machine-readable listing (binary, route, summary, args, aliases)
omarchy commands --json

# Read a command's source to understand it
cat $(which omarchy-theme-set)
```

### Command Groups

Run `omarchy --help` for the full list. The most common groups:

| Group | Purpose | Example |
|-------|---------|---------|
| `omarchy refresh` | Reset config to defaults (backs up first) | `omarchy refresh shell` |
| `omarchy restart` | Restart a service/app | `omarchy restart shell` |
| `omarchy toggle` | Toggle feature on/off | `omarchy toggle nightlight` |
| `omarchy theme` | Theme management | `omarchy theme set <name>` |
| `omarchy bar` | Bar layout and widgets | `omarchy bar move omarchy.clock --section right` |
| `omarchy plugin` | Manage/clone shell plugins | `omarchy plugin clone omarchy.clock` |
| `omarchy hook` | Install automation hooks | `omarchy hook install theme-set <script>` |
| `omarchy install` | Install optional software / packages | `omarchy install docker dbs` |
| `omarchy launch` | Launch apps | `omarchy launch browser` |
| `omarchy capture` | Screenshots and recordings | `omarchy capture screenshot` |
| `omarchy reminder` | Desktop notification reminders | `omarchy reminder 15 "Pickup Jack"` |
| `omarchy pkg` | Package management | `omarchy pkg add <pkg>` |
| `omarchy setup` | Interactive setup wizards | `omarchy setup security fingerprint` |
| `omarchy update` | System updates | `omarchy update` |

## Configuration Locations

Hyprland config lives in `~/.config/hypr/` — see [`hyprland.md`](hyprland.md).
The Omarchy shell (bar, notifications, plugins, idle) is configured in
`~/.config/omarchy/shell.json` — see [`plugins.md`](plugins.md).

### Terminals

```
~/.config/alacritty/alacritty.toml
~/.config/foot/foot.ini
~/.config/kitty/kitty.conf
~/.config/ghostty/config
```

**Command:** `omarchy restart terminal`

### Other Configs

| App | Location |
|-----|----------|
| btop | `~/.config/btop/btop.conf` |
| fastfetch | `/etc/fastfetch/config.jsonc` default; `~/.config/fastfetch/config.jsonc` user override |
| lazygit | `~/.config/lazygit/config.yml` |
| starship | `~/.config/starship.toml` |
| git | `~/.config/git/config` |

## Safe Customization Patterns

### Edit User Config Directly

For simple changes, edit files in `~/.config/`:

```bash
# 1. Read current config
cat ~/.config/hypr/bindings.lua

# 2. Backup before changes
cp ~/.config/hypr/bindings.lua ~/.config/hypr/bindings.lua.bak.$(date +%s)

# 3. Make changes with Edit tool

# 4. Apply changes
# - Hyprland: auto-reloads on save, but MUST validate with `hyprctl reload` and `hyprctl configerrors`
# - Omarchy shell: shell.json and user plugin code under ~/.config/omarchy/plugins/ hot-reload on save
# - Menus/launcher: ~/.config/omarchy/extensions/omarchy-menu.jsonc hot-reloads on save
# - Terminals: apply with `omarchy restart terminal` (reloads running terminals; foot picks changes up in new windows)
```

### Reset to Defaults -- ALWAYS SEEK USER CONFIRMATION BEFORE RUNNING

When customizations go wrong:

```bash
# Reset specific config (creates backup automatically)
omarchy refresh shell
omarchy refresh hyprland

# The refresh command:
# 1. Backs up current config with timestamp
# 2. Copies default from $OMARCHY_PATH/config/
# 3. Restarts the component where the refresh needs it (e.g. `refresh shell`)
```

## System Commands

```bash
omarchy update                  # Full system update
omarchy version                 # Show Omarchy version
omarchy debug --no-sudo --print # Debug info (ALWAYS use these flags)
omarchy system lock             # Lock screen
omarchy system shutdown         # Shutdown
omarchy system reboot           # Reboot
```

**IMPORTANT:** Always run `omarchy debug` with `--no-sudo --print` flags to avoid interactive sudo prompts that will hang the terminal.

## Troubleshooting

```bash
# Get debug information (ALWAYS use these flags to avoid interactive prompts)
omarchy debug --no-sudo --print

# Reset specific config to defaults
omarchy refresh <app>

# Refresh specific config file
# config-file path is relative to ~/.config/
# eg. `omarchy refresh config hypr/hyprland.lua` will refresh ~/.config/hypr/hyprland.lua
omarchy refresh config <config-file>

# Full reinstall of configs (nuclear option)
omarchy reinstall
```

## Decision Framework

When user requests system changes:

1. **Is it a stock omarchy command?** Use it directly
2. **Is it a config edit?** Edit in `~/.config/`, never `/usr/share/omarchy/`
3. **Is it a theme customization?** Follow [`theming.md`](theming.md); create a NEW custom theme directory
4. **Is it automation?** Follow [`hooks.md`](hooks.md); use `omarchy hook install` and the hook `.d` directories
5. **Is it a package install?** Use `omarchy pkg add <pkgs...>` (or `omarchy pkg aur add <pkgs...>` for AUR-only packages)
6. **Is it built-in shell/plugin code?** Follow [`plugins.md`](plugins.md); clone it with `omarchy plugin clone`, never edit the packaged copy
7. **Unsure if command exists?** Run `omarchy commands` (or `omarchy <group> --help` for one group)

### Reminder Requests

When the user asks to set a reminder, use `omarchy reminder <minutes> [message]` directly. Convert natural language durations to minutes and title-case short reminder labels when appropriate.

```bash
omarchy reminder 15 "Pickup Jack"
omarchy reminder 60 "Check laundry"
omarchy reminder show
omarchy reminder clear
```

## Out of Scope

This skill intentionally does not cover Omarchy source development. Do not use this skill for:
- Editing files in `/usr/share/omarchy/` (`bin/`, `config/`, `default/`, `shell/`, `themes/`, `migrations/`, etc.)
- Creating or editing migrations
- Running `omarchy dev ...` commands

## Example Requests

- "Change my theme to catppuccin" -> `omarchy theme set catppuccin`
- "Add a keybinding for Super+E to open file manager" -> Check existing bindings first, call `hl.unbind` if needed, then `o.bind` in `~/.config/hypr/bindings.lua`
- "Configure my external monitor" -> Edit `~/.config/hypr/monitors.lua`
- "Make the window gaps smaller" -> Edit `~/.config/hypr/looknfeel.lua`
- "Turn on night light" -> `omarchy toggle nightlight` (for time-based schedules, edit `~/.config/hypr/hyprsunset.conf` profiles, then `omarchy restart hyprsunset`)
- "Set a reminder to pickup jack in 15 minutes" -> `omarchy reminder 15 "Pickup Jack"`
- "Show my reminders" -> `omarchy reminder show`
- "Clear all reminders" -> `omarchy reminder clear`
- "Customize the catppuccin theme colors" -> Overlay: put an edited `colors.toml` in `~/.config/omarchy/themes/catppuccin/`, then re-apply the theme (see `theming.md`)
- "Run a script every time I change themes" -> Install it with `omarchy hook install theme-set <script>`
- "Change how workspace labels are rendered" -> Clone `omarchy.workspaces`, which switches the bar to `<username>.workspaces`, then edit the clone
- "Lock after ten minutes" -> Set `idle.lock` to `600` in `~/.config/omarchy/shell.json`
- "Reset shell/bar to defaults" -> `omarchy refresh shell`
- "Record my screen" -> `omarchy screenrecord --fullscreen`, then `omarchy screenrecord --stop-recording` (see `capture.md`)
- "Report this bug to Omarchy" -> Gather diagnostics and a capture of the problem, then file it (see `contributing.md`)

Base directory for this skill: /home/mb/.agents/skills/omarchy
Relative paths in this skill (e.g., scripts/, reference/) are relative to this base directory.
Note: file list is sampled.

<skill_files>
<file>/home/mb/.agents/skills/omarchy/theming.md</file>
<file>/home/mb/.agents/skills/omarchy/plugins.md</file>
<file>/home/mb/.agents/skills/omarchy/hyprland.md</file>
<file>/home/mb/.agents/skills/omarchy/hooks.md</file>
<file>/home/mb/.agents/skills/omarchy/contributing.md</file>
<file>/home/mb/.agents/skills/omarchy/capture.md</file>
</skill_files>
</skill_content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.7s)

_Thinking:_



Skill content loaded — now checking where to install it.

**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb"
}
```

**Output:**
```
<path>/home/mb</path>
<type>directory</type>
<entries>
.agents/
.aitk/
.android/
.antigravity-ide/
.bash_history
.bash_logout
.bash_profile
.bashrc
.bashrc.omarchy-upgrade-to-quattro.20260824204038.bak
.cache/
.cargo/
.claude.json
.claude/
.codex/
.config/
.copilot/
.designer/
.dotnet/
.emacs
.emacs.d/
.emulator_console_auth_token
.fonts/
.gemini/
.gnupg/
.gradle/
.grokbot/
.hermes/
.java/
.kilocode/
.lmstudio-home-pointer
.lmstudio/
.local/
.mozilla/
.mysql/
.net/
.npm/
.omniroute/
.opencode/
.pi/
.pki/
.python_history
.recently-used
.vscode-shared/
.vscode/
.wget-hsts
.wine/
.XCompose
2026-01-31 23-18-45.mp4
Android/
bikes/
chrome-eiaepplfcnhbfhfcjndjbikjdgdckdnp-Default.desktop
chrome-haaibalhhoablandpaahikhdolnkaoga-Default.desktop
chrome-kajebgjangihfbkjfejcanhanjmmbcfd-Default.desktop
chrome-kbdhpemeclgiggljbfcmlnmibnmolaih-Default.desktop
ctl-venv/
desktop/
development/
Documents/
Downloads/
e-voter-id-kb-compressed.pdf
kb-e-voters-card.jpeg
kb-e-voters-card.jpg
kb-e-voters-card.png
kb-photo.jpg
kb-sign.jpg
learnings/
Music/
omarchy-ctl-first-time-loading-message.png
picture-titles-part-1.png
picture-titles-part-2.png
pictures/
Pictures/
Projects/
screenshot-2026-03-22_15-17-42.png
screenshot-2026-03-22_15-24-54.png
screenshot-2026-04-11_19-55-21.png
screenshot-2026-05-18_15-33-56.png
screenshot-2026-06-28_16-12-33.png
screenshot-2026-06-29_13-52-00.png
screenshot-2026-06-30_10-06-44.png
screenshot-2026-07-05_02-16-15.png
screenshot-2026-07-05_02-18-54.png
screenshot-2026-07-05_13-52-39.png
screenshot-2026-07-05_15-47-54.png
screenshot-2026-07-09_23-06-41.png
screenshot-2026-07-14_01-28-08.png
screenshot-2026-07-14_01-37-34.png
screenshot-2026-07-14_01-38-09.png
screenshot-2026-07-14_01-38-32.png
screenshot-2026-07-14_01-38-54.png
screenshot-2026-07-14_01-39-27.png
screenshot-2026-07-14_01-40-04.png
screenshot-2026-07-14_02-29-38.png
screenshot-2026-07-14_03-32-15.png
screenshot-2026-07-14_04-49-10.png
screenshot-2026-07-14_04-52-14.png
screenshot-2026-07-14_13-01-59.png
screenshot-2026-07-19_03-26-05.png
screenshot-2026-07-19_13-09-10.png
screenshot-2026-07-20_03-08-19.png
screenshot-2026-07-20_17-51-17.png
screenshot-2026-07-21_01-56-32.png
screenshot-2026-07-21_02-06-29.png
screenshot-2026-07-21_02-10-21.png
screenshot-2026-07-21_02-27-28.png
screenshot-2026-07-21_03-30-09.png
screenshot-2026-07-29_09-50-06.png
screenshot-2026-08-02_01-15-34.png
screenshot-2026-08-02_01-24-56.png
screenshot-2026-08-02_01-31-08.png
screenshot-2026-08-02_01-53-34.png
screenshot-2026-08-02_03-08-12.png
screenshot-2026-08-02_03-26-21.png
screenshot-2026-08-02_11-57-13.png
screenshot-2026-08-02_11-58-46.png
screenshot-2026-08-02_11-59-51.png
screenshot-2026-08-02_12-58-48.png
screenshot-2026-08-02_13-50-29.png
screenshot-2026-08-02_14-06-34.png
screenshot-2026-08-02_14-18-02.png
screenshot-2026-08-02_14-36-54.png
screenshot-2026-08-02_15-55-44.png
screenshot-2026-08-02_17-43-14.png
screenshot-2026-08-02_20-10-08.png
screenshot-2026-08-04_01-38-31.png
screenshot-2026-08-04_01-41-16.png
screenshot-2026-08-04_02-01-47.png
screenshot-2026-08-26_13-05-05.png
screenshot-2026-08-29_13-55-30.png
screenshot-2026-08-29_13-57-06.png
screenshot-2026-09-05_22-30-51.png
screenshot-2026-09-05_22-47-00.png
screenshot-2026-09-06_12-58-16.png
screenshot-2026-09-06_13-07-20.png
screenshot-2026-09-06_17-49-39.png
screenshot-2026-09-06_17-51-33.png
screenshot-2026-09-06_19-38-43.png
screenshot-2026-09-06_20-57-00.png
screenshot-2026-09-08_10-59-02.png
screenshot-2026-09-08_10-59-53.png
screenshot-2026-09-08_11-00-31.png
screenshot-2026-09-08_11-00-47.png
screenshot-2026-09-08_11-01-07.png
screenshot-2026-09-08_11-04-59.png
screenshot-2026-09-08_11-06-42.png
screenshot-2026-09-08_11-07-21.png
screenshot-2026-09-08_11-09-56.png
screenshot-2026-09-08_11-11-04.png
screenshot-2026-09-08_11-12-30.png
screenshot-2026-09-08_11-53-28.png
screenshot-2026-09-08_12-00-52.png
screenshot-2026-09-08_12-06-14.png
screenshot-2026-09-08_12-11-32.png
screenshot-2026-09-08_12-12-05.png
screenshot-2026-09-08_12-15-06.png
screenshot-2026-09-09_23-06-54.png
screenshot-2026-09-09_23-12-05.png
screenshot-2026-09-12_15-39-22.png
screenshot-2026-09-12_16-10-18.png
screenshot-2026-09-12_16-17-21.png
stable-diffusion/
venvs/
Videos/
Wallpapers/
Work/

(165 entries)
</entries>
```

**Tool: bash**

**Input:**
```json
{
  "command": "ls -la ~/.config/opencode/ 2>&1; echo \"---\"; ls -la ~/.agents/skills/omarchy/ 2>&1; echo \"---\"; ls -la .opencode/ 2>&1 || echo \"no .opencode\"; echo \"---\"; cat ~/.config/opencode/opencode.json 2>&1 || cat ~/.config/opencode/opencode.jsonc 2>&1 || echo \"no opencode config\""
}
```

**Output:**
```
total 56
drwxr-xr-x 1 mb mb   390 Sep 12 12:28 .
drwxr-xr-x 1 mb mb  3042 Sep 12 17:19 ..
-rw-r--r-- 1 mb mb   711 Jan 25  2026 bun.lock
-rw-r--r-- 1 mb mb    45 Jan 24  2026 .gitignore
-rw-r--r-- 1 mb mb  3253 Sep 12 13:14 herdr-tui-session.js
drwxr-xr-x 1 mb mb   584 Jul 13 23:06 node_modules
-rw-r--r-- 1 mb mb   187 Aug  2 02:42 opencode.json
-rw-r--r-- 1 mb mb    72 Feb 27  2026 opencode.json.bak.1772174493
-rw-r--r-- 1 mb mb    50 Aug  1 23:48 opencode.jsonc
-rw-r--r-- 1 mb mb    95 Jul 13 22:58 opencode.json.tui-migration.bak
-rw-r--r-- 1 mb mb    65 Jul 13 23:06 package.json
-rw-r--r-- 1 mb mb 14445 Jul 13 23:06 package-lock.json
drwxr-xr-x 1 mb mb    40 Sep 12 12:28 plugins
drwxr-xr-x 1 mb mb   460 Sep  8 11:31 skills
-rw-r--r-- 1 mb mb    68 Jul 13 22:58 tui.json
-rw-r--r-- 1 mb mb    43 Sep 12 12:28 tui.jsonc
---
total 40
drwxr-xr-x 1 root root   144 Sep 12 17:51 .
drwxr-xr-x 1 root root    42 Aug 24 20:40 ..
-rw-r--r-- 1 root root  2217 Sep  9 00:00 capture.md
-rw-r--r-- 1 root root  2385 Sep  9 00:00 contributing.md
-rw-r--r-- 1 root root  1063 Sep  9 00:00 hooks.md
-rw-r--r-- 1 root root  3376 Sep  9 00:00 hyprland.md
-rw-r--r-- 1 root root  1820 Sep  9 00:00 plugins.md
-rw-r--r-- 1 root root 13248 Sep  9 00:00 SKILL.md
-rw-r--r-- 1 root root  3245 Sep  9 00:00 theming.md
---
total 24
drwxr-xr-x 1 mb mb   118 Jul 19 16:35 .
drwx------ 1 mb mb  7996 Sep 12 17:51 ..
drwxr-xr-x 1 mb mb    16 Jul 13 22:58 bin
-rw-r--r-- 1 mb mb    63 Jul 13 23:00 .gitignore
drwxr-xr-x 1 mb mb   584 Jul 13 23:06 node_modules
-rw-r--r-- 1 mb mb    65 Jul 13 23:06 package.json
-rw-r--r-- 1 mb mb 14632 Jul 13 23:06 package-lock.json
drwxr-xr-x 1 mb mb   128 Jul 19 16:52 plans
---
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "Astro docs": {
      "type": "remote",
      "url": "https://mcp.docs.astro.build/mcp",
      "enabled": true
    }
  }
}
```

---

## Assistant (Build · Muse Spark 1.3 Free · 1.8s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "ls -la ~/.config/opencode/skills/; echo \"---\"; cat ~/.config/opencode/opencode.json; echo \"---\"; cat ~/.config/opencode/skills/*/SKILL.md 2>&1 | head -n 100; echo \"---SKILL LIST---\"; ls -R ~/.config/opencode/skills/ 2>&1; echo \"---\"; ls ~/.config/opencode/plugins/ 2>&1"
}
```

**Output:**
```
total 0
drwxr-xr-x 1 mb mb 460 Sep  8 11:31 .
drwxr-xr-x 1 mb mb 390 Sep 12 12:28 ..
drwxr-xr-x 1 mb mb  36 Jul 19 22:43 agents-sdk
drwxr-xr-x 1 mb mb  36 Jul 19 22:43 cloudflare
drwxr-xr-x 1 mb mb  36 Jul 19 22:43 cloudflare-email-service
drwxr-xr-x 1 mb mb  16 Jul 19 22:43 cloudflare-one
drwxr-xr-x 1 mb mb  16 Jul 19 22:43 cloudflare-one-migrations
drwxr-xr-x 1 mb mb  36 Jul 19 22:43 durable-objects
drwxr-xr-x 1 mb mb  16 Sep  8 11:31 nextjs-on-cloudflare
drwxr-xr-x 1 mb mb  16 Sep  8 11:31 sandbox-migrate-to-next
drwxr-xr-x 1 mb mb  36 Sep  8 11:31 sandbox-next
drwxr-xr-x 1 mb mb  36 Jul 19 22:43 sandbox-sdk
drwxr-xr-x 1 mb mb  16 Sep  8 11:31 sandbox-stable
drwxr-xr-x 1 mb mb  78 Jul 19 22:43 turnstile-spin
drwxr-xr-x 1 mb mb  16 Jul 19 22:43 web-perf
drwxr-xr-x 1 mb mb  36 Jul 19 22:43 workers-best-practices
drwxr-xr-x 1 mb mb  16 Jul 19 22:43 wrangler
---
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "Astro docs": {
      "type": "remote",
      "url": "https://mcp.docs.astro.build/mcp",
      "enabled": true
    }
  }
}---
---
name: agents-sdk
description: Build, debug, or review Cloudflare Agents SDK applications using the agents package.
---

# Cloudflare Agents SDK

Your knowledge of the Agents SDK may be outdated. **Prefer retrieval over pre-training** for any Agents SDK task.

## Retrieval Sources

Cloudflare docs: https://developers.cloudflare.com/agents/

| Topic | Docs URL | Use for |
|-------|----------|---------|
| Getting started | [Quick start](https://developers.cloudflare.com/agents/getting-started/quick-start/) | First agent, project setup |
| Adding to existing project | [Add to existing project](https://developers.cloudflare.com/agents/getting-started/add-to-existing-project/) | Install into existing Workers app |
| Configuration | [Configuration](https://developers.cloudflare.com/agents/api-reference/configuration/) | `wrangler.jsonc`, bindings, assets, deployment |
| Agent class | [Agents API](https://developers.cloudflare.com/agents/api-reference/agents-api/) | Agent lifecycle, patterns, pitfalls |
| State | [Store and sync state](https://developers.cloudflare.com/agents/api-reference/store-and-sync-state/) | `setState`, `validateStateChange`, persistence |
| Routing | [Routing](https://developers.cloudflare.com/agents/api-reference/routing/) | URL patterns, `routeAgentRequest` |
| Callable methods | [Callable methods](https://developers.cloudflare.com/agents/api-reference/callable-methods/) | `@callable`, RPC, streaming, timeouts |
| Scheduling | [Schedule tasks](https://developers.cloudflare.com/agents/api-reference/schedule-tasks/) | `schedule()`, `scheduleEvery()`, cron |
| Workflows | [Run workflows](https://developers.cloudflare.com/agents/api-reference/run-workflows/) | `AgentWorkflow`, durable multi-step tasks |
| HTTP/WebSockets | [WebSockets](https://developers.cloudflare.com/agents/api-reference/websockets/) | Lifecycle hooks, hibernation |
| Chat agents | [Chat agents](https://developers.cloudflare.com/agents/communication-channels/chat/chat-agents/) | `AIChatAgent`, streaming, tools, persistence |
| Client SDK | [Client SDK](https://developers.cloudflare.com/agents/communication-channels/chat/client-sdk/) | `useAgent`, `AgentClient`, state, RPC, HTTP |
| Client tools | [Client tools](https://developers.cloudflare.com/agents/harnesses/think/client-tools/) | Client-side tools, `autoContinueAfterToolResult` |
| Server-driven messages | [Autonomous responses](https://developers.cloudflare.com/agents/communication-channels/chat/autonomous-responses/) | `saveMessages`, `waitUntilStable`, server-initiated turns |
| Resumable streaming | [Chat agents](https://developers.cloudflare.com/agents/communication-channels/chat/chat-agents/#resumable-streaming) | Stream recovery on disconnect |
| Email | [Email](https://developers.cloudflare.com/agents/api-reference/email/) | Email routing, secure reply resolver |
| MCP client | [MCP client](https://developers.cloudflare.com/agents/model-context-protocol/apis/client-api/) | Connecting to MCP servers |
| MCP server | [MCP server](https://developers.cloudflare.com/agents/model-context-protocol/apis/handler-api/) | Building MCP servers with `createMcpHandler` |
| MCP transports | [MCP transports](https://developers.cloudflare.com/agents/model-context-protocol/protocol/transport/) | Streamable HTTP, SSE, RPC transport options |
| Securing MCP servers | [Securing MCP](https://developers.cloudflare.com/agents/model-context-protocol/guides/securing-mcp-server/) | OAuth, proxy MCP, hardening |
| Human-in-the-loop | [Human-in-the-loop](https://developers.cloudflare.com/agents/concepts/agentic-patterns/human-in-the-loop/) | Workflow approvals, elicitation, timeout handling |
| Durable execution | [Durable execution](https://developers.cloudflare.com/agents/api-reference/durable-execution/) | `runFiber()`, `stash()`, surviving DO eviction |
| Queue | [Queue](https://developers.cloudflare.com/agents/api-reference/queue-tasks/) | Built-in FIFO queue, `queue()` |
| Retries | [Retries](https://developers.cloudflare.com/agents/api-reference/retries/) | `this.retry()`, backoff/jitter |
| Observability | [Observability](https://developers.cloudflare.com/agents/api-reference/observability/) | Diagnostics-channel events |
| Push notifications | [Push notifications](https://developers.cloudflare.com/agents/communication-channels/webhooks/push-notifications/) | Web Push + VAPID from agents |
| Webhooks | [Webhooks](https://developers.cloudflare.com/agents/communication-channels/webhooks/) | Receiving external webhooks |
| Cross-domain auth | [Cross-domain auth](https://developers.cloudflare.com/agents/runtime/operations/cross-domain-authentication/) | WebSocket auth, tokens, CORS |
| Readonly connections | [Readonly](https://developers.cloudflare.com/agents/api-reference/readonly-connections/) | `shouldConnectionBeReadonly` |
| Voice | [Voice](https://developers.cloudflare.com/agents/api-reference/voice/) | Experimental STT/TTS, `withVoice` |
| Browse the web | [Browser tools](https://developers.cloudflare.com/agents/api-reference/browse-the-web/) | Experimental CDP browser automation |
| Think | [Think](https://developers.cloudflare.com/agents/api-reference/think/) | Experimental higher-level chat agent class |
| Migrations | [AI SDK v5](https://github.com/cloudflare/agents/blob/main/docs/agents/migration-to-ai-sdk-v5.md), [AI SDK v6](https://github.com/cloudflare/agents/blob/main/docs/agents/migration-to-ai-sdk-v6.md) | Upgrading `@cloudflare/ai-chat` |

## Capabilities

The Agents SDK provides:

- **Persistent state** — SQLite-backed, auto-synced to clients via `setState`
- **Callable RPC** — `@callable()` methods invoked over WebSocket
- **Scheduling** — One-time, recurring (`scheduleEvery`), and cron tasks
- **Workflows** — Durable multi-step background processing via `AgentWorkflow`
- **Durable execution** — `runFiber()` / `stash()` for work that survives DO eviction
- **Queue** — Built-in FIFO queue with retries via `queue()`
- **Retries** — `this.retry()` with exponential backoff and jitter
- **MCP integration** — Connect to MCP servers or build your own with `createMcpHandler`
- **Email handling** — Receive and reply to emails with secure routing
- **Streaming chat** — `AIChatAgent` with resumable streams, message persistence, tools
- **Server-driven messages** — `saveMessages`, `waitUntilStable` for proactive agent turns
- **React hooks** — `useAgent`, `useAgentChat` for client apps
- **Observability** — `diagnostics_channel` events for state, RPC, schedule, lifecycle
- **Push notifications** — Web Push + VAPID delivery from agents
- **Webhooks** — Receive and verify external webhooks
- **Voice** (experimental) — STT/TTS via `@cloudflare/voice`
- **Browser tools** (experimental) — CDP-powered browsing via `agents/browser`
- **Think** (experimental) — Higher-level chat agent via `@cloudflare/think`

## FIRST: Verify Installation

```bash
npm ls agents  # Should show agents package
```

If not installed:
```bash
npm install agents
```

For chat agents:
```bash
npm install agents @cloudflare/ai-chat ai @ai-sdk/react
```

## Wrangler Configuration

```jsonc
{
  "compatibility_flags": ["nodejs_compat"],
  "durable_objects": {
    "bindings": [{ "name": "MyAgent", "class_name": "MyAgent" }]
  },
  "migrations": [{ "tag": "v1", "new_sqlite_classes": ["MyAgent"] }]
}
```

---SKILL LIST---
/home/mb/.config/opencode/skills/:
agents-sdk
cloudflare
cloudflare-email-service
cloudflare-one
cloudflare-one-migrations
durable-objects
nextjs-on-cloudflare
sandbox-migrate-to-next
sandbox-next
sandbox-sdk
sandbox-stable
turnstile-spin
web-perf
workers-best-practices
wrangler

/home/mb/.config/opencode/skills/agents-sdk:
references
SKILL.md

/home/mb/.config/opencode/skills/agents-sdk/references:
browse-the-web.md
callable.md
client-sdk.md
codemode.md
configuration.md
durable-execution.md
email.md
human-in-the-loop.md
mcp.md
observability.md
queue-retries.md
routing.md
server-driven-messages.md
state-scheduling.md
streaming-chat.md
think.md
voice.md
webhooks-push.md
workflows.md

/home/mb/.config/opencode/skills/cloudflare:
references
SKILL.md

/home/mb/.config/opencode/skills/cloudflare/references:
agents-sdk
ai-gateway
ai-search
analytics-engine
api
api-shield
argo-smart-routing
artifacts
bindings
bot-management
browser-rendering
c3
cache-reserve
containers
cron-triggers
d1
ddos
do-storage
durable-objects
email-routing
email-workers
flagship
graphql-api
hyperdrive
images
kv
miniflare
network-interconnect
observability
pages
pages-functions
pipelines
pulumi
queues
r2
r2-data-catalog
r2-sql
realtimekit
realtime-sfu
sandbox
secrets-store
smart-placement
snippets
spectrum
static-assets
stream
tail-workers
terraform
tunnel
turn
turnstile
vectorize
waf
web-analytics
workerd
workers
workers-ai
workers-for-platforms
workers-playground
workers-vpc
workflows
wrangler
zaraz

/home/mb/.config/opencode/skills/cloudflare/references/agents-sdk:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/ai-gateway:
configuration.md
dynamic-routing.md
features.md
README.md
sdk-integration.md
troubleshooting.md

/home/mb/.config/opencode/skills/cloudflare/references/ai-search:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/analytics-engine:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/api:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/api-shield:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/argo-smart-routing:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/artifacts:
api.md
configuration.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/bindings:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/bot-management:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/browser-rendering:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/c3:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/cache-reserve:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/containers:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/cron-triggers:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/d1:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/ddos:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/do-storage:
api.md
configuration.md
gotchas.md
patterns.md
README.md
testing.md

/home/mb/.config/opencode/skills/cloudflare/references/durable-objects:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/email-routing:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/email-workers:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/flagship:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/graphql-api:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/hyperdrive:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/images:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/kv:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/miniflare:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/network-interconnect:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/observability:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/pages:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/pages-functions:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/pipelines:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/pulumi:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/queues:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/r2:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/r2-data-catalog:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/r2-sql:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/realtimekit:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/realtime-sfu:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/sandbox:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/secrets-store:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/smart-placement:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/snippets:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/spectrum:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/static-assets:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/stream:
api-live.md
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/tail-workers:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/terraform:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/tunnel:
api.md
configuration.md
gotchas.md
networking.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/turn:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/turnstile:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/vectorize:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/waf:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/web-analytics:
configuration.md
gotchas.md
integration.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/workerd:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/workers:
api.md
configuration.md
frameworks.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/workers-ai:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/workers-for-platforms:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/workers-playground:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/workers-vpc:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/workflows:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/wrangler:
api.md
configuration.md
gotchas.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare/references/zaraz:
api.md
configuration.md
gotchas.md
IMPLEMENTATION_SUMMARY.md
patterns.md
README.md

/home/mb/.config/opencode/skills/cloudflare-email-service:
references
SKILL.md

/home/mb/.config/opencode/skills/cloudflare-email-service/references:
cli-and-mcp.md
deliverability.md
rest-api.md
routing.md
sending.md

/home/mb/.config/opencode/skills/cloudflare-one:
SKILL.md

/home/mb/.config/opencode/skills/cloudflare-one-migrations:
SKILL.md

/home/mb/.config/opencode/skills/durable-objects:
references
SKILL.md

/home/mb/.config/opencode/skills/durable-objects/references:
rules.md
testing.md
workers.md

/home/mb/.config/opencode/skills/nextjs-on-cloudflare:
SKILL.md

/home/mb/.config/opencode/skills/sandbox-migrate-to-next:
SKILL.md

/home/mb/.config/opencode/skills/sandbox-next:
references
SKILL.md

/home/mb/.config/opencode/skills/sandbox-next/references:
api-quick-ref.md
examples.md

/home/mb/.config/opencode/skills/sandbox-sdk:
references
SKILL.md

/home/mb/.config/opencode/skills/sandbox-sdk/references:
api-quick-ref.md
examples.md

/home/mb/.config/opencode/skills/sandbox-stable:
SKILL.md

/home/mb/.config/opencode/skills/turnstile-spin:
README.md
references
scripts
SKILL.md
tests

/home/mb/.config/opencode/skills/turnstile-spin/references:
astro.md
hugo.md
nextjs-app.md
nextjs-pages.md
sveltekit.md
vanilla-html.md

/home/mb/.config/opencode/skills/turnstile-spin/scripts:
auth-probe.sh
fetch-secret.sh
persist-skill.sh
validate.sh
widget-create.sh

/home/mb/.config/opencode/skills/turnstile-spin/tests:
validation.md

/home/mb/.config/opencode/skills/web-perf:
SKILL.md

/home/mb/.config/opencode/skills/workers-best-practices:
references
SKILL.md

/home/mb/.config/opencode/skills/workers-best-practices/references:
configuration.md
platform-apis.md
review.md
rules.md
runtime-patterns.md

/home/mb/.config/opencode/skills/wrangler:
SKILL.md
---
herdr-agent-state.js

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.9s)

_Thinking:_



Got it — I'll wire the Omarchy skill into OpenCode.

**Tool: skill**

**Input:**
```json
{
  "name": "customize-opencode"
}
```

**Output:**
```
<skill_content name="customize-opencode">
# Skill: customize-opencode

<!--
  Built-in skill. Name and description are registered in code at
  packages/core/src/plugin/skill.ts
  and CUSTOMIZE_OPENCODE_SKILL_DESCRIPTION). The body below becomes the
  skill's content.
-->

# Customizing opencode

opencode validates its own config strictly and refuses to start when a field
is wrong. The shapes below cover the common surface area, but they are a
**summary, not the source of truth**.

## Full schema reference

The authoritative list of every config option — with field types, enums,
defaults, and descriptions — lives in the published JSON Schema:

**<https://opencode.ai/config.json>**

If a field is not documented in this skill, or you need to confirm an exact
shape before writing config, **fetch that URL and read the schema directly**
rather than guessing. opencode hard-fails on invalid config, so the cost of a
wrong shape is a broken startup.

Independently, every `opencode.json` should declare
`"$schema": "https://opencode.ai/config.json"` so the user's editor catches
mistakes as they type.

## Applying changes

Config is loaded once when opencode starts and is not hot-reloaded. After
saving changes to `opencode.json`, an agent file, a skill, a plugin, or any
other config-time file, **tell the user to quit and restart opencode** for
the changes to take effect. The running session will keep using the
already-loaded config until then.

## Where files live

| Scope                         | Path                                                                                                                      |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| Project config                | `./opencode.json`, `./opencode.jsonc`, or `.opencode/opencode.json` (opencode walks up from the cwd to the worktree root) |
| Global config                 | `~/.config/opencode/opencode.json` (NOT `~/.opencode/`)                                                                   |
| Project agents                | `.opencode/agent/<name>.md` or `.opencode/agents/<name>.md`                                                               |
| Global agents                 | `~/.config/opencode/agent(s)/<name>.md`                                                                                   |
| Project commands              | `.opencode/command/<name>.md` or `.opencode/commands/<name>.md`                                                           |
| Global commands               | `~/.config/opencode/command(s)/<name>.md`                                                                                 |
| Project skills                | `.opencode/skill(s)/<name>/SKILL.md`                                                                                      |
| Global skills                 | `~/.config/opencode/skill(s)/<name>/SKILL.md`                                                                             |
| External skills (auto-loaded) | `~/.claude/skills/<name>/SKILL.md`, `~/.agents/skills/<name>/SKILL.md`                                                    |

Configs from each scope are deep-merged. Project overrides global. Unknown
top-level keys in `opencode.json` are rejected with `ConfigInvalidError`.

## opencode.json

Every field is optional.

```json
{
  "$schema": "https://opencode.ai/config.json",
  "username": "string",
  "model": "provider/model-id",
  "small_model": "provider/model-id",
  "default_agent": "agent-name",
  "shell": "/bin/zsh",
  "logLevel": "DEBUG" | "INFO" | "WARN" | "ERROR",
  "share": "manual" | "auto" | "disabled",
  "autoupdate": true | false | "notify",
  "snapshot": true,
  "instructions": ["AGENTS.md", "docs/style.md"],

  "skills": {
    "paths": [".opencode/skills", "/abs/path/to/skills"],
    "urls": ["https://example.com/.well-known/skills/"]
  },

  "references": {
    "docs": {
      "path": "../docs",
      "description": "Use for product behavior and documentation conventions"
    },
    "sdk": {
      "repository": "owner/sdk",
      "branch": "main",
      "description": "Use for SDK implementation details",
      "hidden": true
    }
  },

  "agent": {
    "my-agent": {
      "model": "anthropic/claude-sonnet-4-6",
      "mode": "subagent",
      "description": "...",
      "permission": { "edit": "deny" }
    }
  },

  "command": {
    "deploy": { "description": "...", "template": "..." }
  },

  "provider": {
    "anthropic": { "options": { "apiKey": "..." } }
  },
  "disabled_providers": ["openai"],
  "enabled_providers": ["anthropic"],

  "mcp": {
    "playwright": {
      "type": "local",
      "command": ["npx", "-y", "@playwright/mcp"],
      "enabled": true,
      "env": {}
    },
    "remote-thing": {
      "type": "remote",
      "url": "https://...",
      "headers": { "Authorization": "Bearer ..." }
    }
  },

  "plugin": [
    "opencode-gemini-auth",
    "opencode-foo@1.2.3",
    "./local-plugin.ts",
    ["opencode-bar", { "option": "value" }]
  ],

  "permission": {
    "edit": "deny",
    "bash": { "git *": "allow", "*": "ask" }
  },

  "formatter": false,
  "lsp": false,

  "experimental": {
    "primary_tools": ["edit"],
    "mcp_timeout": 30000
  },

  "tool_output": { "max_lines": 200, "max_bytes": 8192 },

  "compaction": { "auto": true, "tail_turns": 15 }
}
```

Shape notes worth being explicit about:

- `model` always carries a provider prefix: `"anthropic/claude-sonnet-4-6"`.
- `skills` is an object with `paths` and/or `urls`, not an array.
- `references` is an object keyed by alias. Each value is a local path, Git repository, or string shorthand.
- `agent` is an object keyed by agent name, not an array.
- `command` is an object keyed by command name, not an array.
- `plugin` is an array of strings or `[name, options]` tuples, not an object.
- `mcp[name].command` is an array of strings, never a single string. `type` is required.
- `permission` is either a string action or an object keyed by tool name.

## Skills

opencode's skill loader scans for `**/SKILL.md` inside skill directories. The
file is named `SKILL.md` exactly, and lives in its own folder named after the
skill:

```
.opencode/skills/my-skill/SKILL.md
```

Frontmatter:

```markdown
---
name: my-skill
description: One sentence covering what this skill does AND when to trigger it. Front-load the literal keywords or filenames the user is likely to say.
---

# My Skill

(skill body in markdown: instructions, examples, references)
```

- `name` is required, lowercase hyphen-separated, up to 64 chars, and matches the folder name.
- `description` is effectively required: skills without one are filtered out and never surfaced to the model. Cover both _what_ the skill does and _when_ to use it. Write in third person ("Use when...", not "I help with..."). Front-load concrete trigger keywords and filenames; gate with "Use ONLY when..." if the skill should stay quiet on adjacent topics.
- Optional: `license`, `compatibility`, `metadata` (string-string map).

Register skills from non-default locations via `skills.paths` (scanned
recursively for `**/SKILL.md`) and `skills.urls` (each URL serves a list of
skills).

## References

References make local directories and Git repositories outside the active
project available as supporting context. Configure them under `references`,
keyed by the alias used in `@` autocomplete:

```json
{
  "references": {
    "docs": {
      "path": "../product-docs",
      "description": "Use for product behavior and terminology"
    },
    "effect": {
      "repository": "Effect-TS/effect",
      "branch": "main",
      "description": "Use for Effect implementation details"
    }
  }
}
```

Local `path` values may be relative to the declaring config, absolute, or use
`~/`. Git `repository` values accept Git URLs, host/path references, and GitHub
`owner/repo` shorthand; `branch` is optional. Both forms support optional
`description` and `hidden` fields.

- Only references with a `description` are advertised to agents in system context.
- `hidden: true` removes a reference from TUI `@` autocomplete only. It remains available to agents and by direct path.
- Reference directories are automatically allowed through the external-directory boundary; normal read/edit/tool permissions still apply.
- String shorthand is supported: use `"docs": "../docs"` for local paths or `"effect": "Effect-TS/effect"` for Git repositories.

## Agents

Two ways to define an agent. Use the file form for anything non-trivial.

### Inline (in `opencode.json`)

```json
{
  "agent": {
    "my-reviewer": {
      "description": "Reviews PRs for style violations.",
      "mode": "subagent",
      "model": "anthropic/claude-sonnet-4-6",
      "permission": { "edit": "deny", "bash": "ask" },
      "prompt": "You are a strict PR reviewer..."
    }
  }
}
```

### File

```
.opencode/agent/my-reviewer.md      OR     .opencode/agents/my-reviewer.md
```

```markdown
---
description: Reviews PRs for style violations.
mode: subagent
model: anthropic/claude-sonnet-4-6
permission:
  edit: deny
  bash: ask
---

You are a strict PR reviewer. Focus on...
```

The file body becomes the agent's `prompt`. Do not also put `prompt:` in the
frontmatter.

`mode` is one of `"primary"`, `"subagent"`, `"all"`.

Allowed top-level frontmatter fields: `name, model, variant, description, mode,
hidden, color, steps, options, permission, disable, temperature, top_p`. Any
unknown field is silently routed into `options`.

To disable a built-in agent: `agent: { build: { disable: true } }`, or in a
file, `disable: true` in frontmatter.

`default_agent` must point to a non-hidden, primary-mode agent.

### Built-in agents

opencode ships with `build`, `plan`, `general`, `explore`. Hidden internal agents:
`compaction`, `title`, `summary`. To override a built-in's fields, define the
same key in `agent: { <name>: { ... } }`.

## Commands

opencode's command loader scans for `**/*.md` inside command directories. The
file is named after the command, and lives directly inside the `command` folder:

```
.opencode/command/deploy.md
```

Frontmatter:

```markdown
---
description: One sentence describing what the command does.
agent: build
model: anthropic/claude-sonnet-4-6
---

(command body in markdown: the prompt opencode runs, with $ARGUMENTS for the user's input)
```

- `template` is the command body — everything below the frontmatter — and is required: it is the prompt opencode runs when the command is invoked. Do not also put a `template:` key in the frontmatter.
- `$ARGUMENTS` is replaced with everything the user typed after the command; `$1`, `$2`, … pull individual positional arguments.
- Optional: `description`, `agent`, `model`, `variant`, `subtask`.

## Plugins

`plugin:` is an array. Each entry is one of:

```json
"plugin": [
  "opencode-gemini-auth",            // npm spec, latest
  "opencode-foo@1.2.3",              // npm spec, pinned
  "./local-plugin.ts",               // file path, relative to the declaring config
  "file:///abs/path/plugin.js",      // file URL
  ["opencode-bar", { "key": "val" }] // tuple form with options
]
```

Auto-discovered plugins (no config entry needed): any `*.ts` or `*.js` file in
`.opencode/plugin/` or `.opencode/plugins/`.

A plugin module exports `default` (or any named export) of type
`Plugin = (input: PluginInput, options?) => Promise<Hooks>`. The export is a
function, not a plain object literal, and the function returns an object
(return `{}` if there is nothing to register).

```ts
import type { Plugin } from "@opencode-ai/plugin"

export default (async ({ client, project, directory, $ }) => {
  return {
    config: (cfg) => {
      // cfg is the live merged config; mutate fields here.
    },
    "tool.execute.before": async (input, output) => {
      // mutate output.args before the tool runs
    },
  }
}) satisfies Plugin
```

Hook surface (mutate `output` in place; return `void`):

- `event(input)`: every bus event
- `config(cfg)`: once on init with the merged config
- `chat.message`, `chat.params`, `chat.headers`
- `tool.execute.before`, `tool.execute.after`
- `tool.definition`
- `command.execute.before`
- `shell.env`
- `permission.ask`
- `experimental.chat.messages.transform`, `experimental.chat.system.transform`,
  `experimental.session.compacting`, `experimental.compaction.autocontinue`,
  `experimental.text.complete`

Special object-shaped (not callbacks): `tool: { my_tool: { ... } }`,
`auth: { ... }`, `provider: { ... }`.

## MCP servers

`mcp:` is an object keyed by server name. Each server is discriminated by
`type`:

```json
{
  "mcp": {
    "playwright": {
      "type": "local",
      "command": ["npx", "-y", "@playwright/mcp"],
      "enabled": true,
      "env": { "BROWSER": "chromium" }
    },
    "github": {
      "type": "remote",
      "url": "https://...",
      "enabled": true,
      "headers": { "Authorization": "Bearer {env:GITHUB_TOKEN}" }
    },
    "old-server": { "enabled": false }
  }
}
```

`command` is an array of strings. `type` is required. Use `enabled: false` to
disable a server inherited from a parent config. String values such as header
tokens support `{env:VAR}` interpolation (and `{file:path}`); the shell-style
`${VAR}` is not substituted.

## Permissions

```json
"permission": {
  "edit": "deny",
  "bash": { "git *": "allow", "rm *": "deny", "*": "ask" },
  "external_directory": { "~/secrets/**": "deny", "*": "allow" }
}
```

Actions: `"allow"`, `"ask"`, `"deny"`.

Per-tool value forms: `"allow"` shorthand (treated as `{"*": "allow"}`), or an
object `{ pattern: action }`. Within an object, **insertion order matters**.
opencode evaluates the LAST matching rule, so put broad rules first and narrow
rules last.

`permission: "allow"` (a string at the top level) is shorthand for "allow
everything" and is rarely what the user wants.

Known permission keys: `read, edit, glob, grep, list, bash, task,
external_directory, todowrite, question, webfetch, websearch, lsp, doom_loop,
skill`. Some of these (`todowrite,
question, webfetch, websearch, doom_loop`) only accept a flat
action, not a per-pattern object.

`external_directory` patterns are filesystem paths (use `~/`, absolute paths,
or globs like `~/projects/**`).

Per-agent `permission:` overrides top-level `permission:`. Plan Mode lives on
the `plan` agent's permission ruleset (`edit: deny *`).

## Escape hatches

When a user's config is broken and opencode won't start, these env vars help:

- `OPENCODE_DISABLE_PROJECT_CONFIG=1`: skip the project's local `opencode.json`
  and start from globals only. Run from the project directory, opencode loads,
  the user edits the broken file, then they restart without the flag.
- `OPENCODE_CONFIG=/path/to/file.json`: load an additional explicit config.
- `OPENCODE_CONFIG_CONTENT='{"$schema":"https://opencode.ai/config.json"}'`:
  inject inline JSON as a final local-scope merge.
- `OPENCODE_DISABLE_DEFAULT_PLUGINS=1`: skip default plugins.
- `OPENCODE_PURE=1`: skip external plugins entirely.
- `OPENCODE_DISABLE_EXTERNAL_SKILLS=1`,
  `OPENCODE_DISABLE_CLAUDE_CODE_SKILLS=1`: skip the external skill scans under
  `~/.claude/` and `~/.agents/`.

## When proposing edits

- Validate against the schema before writing. If you are unsure of a field's
  exact shape, or the field is not covered in this skill, fetch
  `https://opencode.ai/config.json` and read the schema rather than guessing.
- Preserve `$schema` and any existing fields the user did not ask to change.
- For agent, command, skill, and plugin definitions, prefer creating new files
  in the correct location over inlining everything in `opencode.json`.
- If the user's existing config is malformed, point them at the env-var escape
  hatches above so they can edit from inside opencode without breaking their
  session.
- After saving any config change, remind the user to quit and restart opencode
  — running sessions keep using the already-loaded config.

Base directory for this skill: .
Relative paths in this skill (e.g., scripts/, reference/) are relative to this base directory.
Note: file list is sampled.

<skill_files>
<file>/home/mb/screenshot-2026-09-12_16-17-21.png</file>
<file>/home/mb/screenshot-2026-09-12_16-10-18.png</file>
<file>/home/mb/screenshot-2026-09-12_15-39-22.png</file>
<file>/home/mb/kb-e-voters-card.jpeg</file>
<file>/home/mb/kb-e-voters-card.png</file>
<file>/home/mb/screenshot-2026-03-22_15-24-54.png</file>
<file>/home/mb/screenshot-2026-03-22_15-17-42.png</file>
<file>/home/mb/screenshot-2026-07-29_09-50-06.png</file>
<file>/home/mb/.mozilla/native-messaging-hosts/com.1password.1password.json</file>
<file>/home/mb/screenshot-2026-07-09_23-06-41.png</file>
</skill_files>
</skill_content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 4.8s)

_Thinking:_



**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.agents/skills/omarchy/SKILL.md",
  "limit": 50
}
```

**Output:**
```
<path>/home/mb/.agents/skills/omarchy/SKILL.md</path>
<type>file</type>
<content>
1: ---
2: name: omarchy
3: description: >
4:   REQUIRED for end-user customization of Linux desktop, window manager, or system config.
5:   Use when editing ~/.config/hypr/, ~/.config/omarchy/,
6:   ~/.config/alacritty/, ~/.config/foot/, ~/.config/kitty/, or ~/.config/ghostty/.
7:   Triggers: Hyprland, window rules, animations, keybindings, monitors, gaps, borders,
8:   blur, opacity, omarchy-shell, bar, terminal config, themes, background,
9:   night light, idle, lock screen, screenshots, reminders, layer rules, workspace
10:   settings, display config, and user-facing omarchy commands. Excludes Omarchy
11:   source development through `omarchy dev link` workflows.
12: ---
13: 
14: # Omarchy Skill
15: 
16: Manage [Omarchy](https://omarchy.org/) Linux systems - a beautiful, modern, opinionated Arch Linux distribution with Hyprland.
17: 
18: This skill is for end-user customization on installed systems.
19: It is not for contributing to Omarchy source code.
20: 
21: ## When This Skill MUST Be Used
22: 
23: **ALWAYS invoke this skill for end-user requests involving ANY of these:**
24: 
25: - Editing ANY file in `~/.config/hypr/` (window rules, animations, keybindings, monitors, etc.)
26: - Editing `~/.config/omarchy/shell.json` (status bar layout, widgets)
27: - Editing terminal configs (alacritty, foot, kitty, ghostty)
28: - Editing ANY file in `~/.config/omarchy/`
29: - Window behavior, animations, opacity, blur, gaps, borders
30: - Layer rules, workspace settings, display/monitor configuration
31: - Themes, backgrounds, fonts, appearance changes
32: - User-facing `omarchy` commands (`omarchy theme ...`, `omarchy refresh ...`, `omarchy restart ...`, etc.)
33: - Screenshots, screen recording, reminders, night light, idle behavior, lock screen
34: 
35: **If you're about to edit a config file in ~/.config/ on this system, STOP and use this skill first.**
36: 
37: **Do NOT use this skill for Omarchy development tasks** (editing the Omarchy source tree, creating migrations, or running `omarchy dev ...` workflows).
38: 
39: ## Topic Guides
40: 
41: Deeper instructions for common areas live next to this file. Read the
42: matching guide before starting:
43: 
44: - [`hyprland.md`](hyprland.md) - keybindings, monitors, window rules, and other Hyprland config
45: - [`plugins.md`](plugins.md) - the Omarchy shell: bar layout, widgets, plugins, idle behavior
46: - [`theming.md`](theming.md) - themes, backgrounds, and fonts
47: - [`hooks.md`](hooks.md) - automation hooks that run on system events
48: - [`capture.md`](capture.md) - screenshots, screen recordings, OCR text capture, and file sharing
49: - [`contributing.md`](contributing.md) - reporting Omarchy bugs and submitting fixes upstream
50: 

(Showing lines 1-50 of 294. Use offset=51 to continue.)
</content>
```

**Tool: bash**

**Input:**
```json
{
  "command": "ls -la ~/.agents/skills/; echo \"---\"; ls -la ~/.claude/skills/ 2>&1 || echo \"no claude skills\"; echo \"---opencode check---\"; opencode skill list 2>&1 || opencode --help 2>&1 | head -n 80"
}
```

**Output:**
```
total 8
drwxr-xr-x 1 mb mb 500 Sep  5 22:09 .
drwxr-xr-x 1 mb mb  44 Jun 28 16:19 ..
drwxr-xr-x 1 mb mb  34 Aug  1 22:43 deploy-to-vercel
lrwxrwxrwx 1 mb mb  55 Aug 24 20:42 diagnose-crash -> /usr/share/omarchy/default/agents/skills/diagnose-crash
drwxr-xr-x 1 mb mb  16 Jul 14 00:47 find-skills
drwxr-xr-x 1 mb mb 176 Sep  5 22:09 microsoft-foundry
lrwxrwxrwx 1 mb mb  48 Aug 24 20:41 omarchy -> /usr/share/omarchy/default/agents/skills/omarchy
drwxr-xr-x 1 mb mb  16 Aug  1 22:43 vercel-cli-with-tokens
drwxr-xr-x 1 mb mb  88 Aug  1 22:43 vercel-composition-patterns
drwxr-xr-x 1 mb mb 148 Aug  1 22:43 vercel-optimize
drwxr-xr-x 1 mb mb  88 Aug  1 22:43 vercel-react-best-practices
drwxr-xr-x 1 mb mb  88 Aug  1 22:43 vercel-react-native-skills
drwxr-xr-x 1 mb mb  98 Aug  1 22:43 vercel-react-view-transitions
drwxr-xr-x 1 mb mb  16 Aug  1 22:43 web-design-guidelines
drwxr-xr-x 1 mb mb  16 Aug  1 22:43 writing-guidelines
---
total 12
drwxr-xr-x 1 mb mb 524 Sep  8 11:31 .
drwxr-xr-x 1 mb mb 118 Sep 12 13:18 ..
drwxr-xr-x 1 mb mb  36 Jul 19 22:43 agents-sdk
drwxr-xr-x 1 mb mb  36 Jul 19 22:43 cloudflare
drwxr-xr-x 1 mb mb  36 Jul 19 22:43 cloudflare-email-service
drwxr-xr-x 1 mb mb  16 Jul 19 22:43 cloudflare-one
drwxr-xr-x 1 mb mb  16 Jul 19 22:43 cloudflare-one-migrations
lrwxrwxrwx 1 mb mb  55 Aug 24 20:42 diagnose-crash -> /usr/share/omarchy/default/agents/skills/diagnose-crash
drwxr-xr-x 1 mb mb  36 Jul 19 22:43 durable-objects
lrwxrwxrwx 1 mb mb  32 Jul 14 00:47 find-skills -> ../../.agents/skills/find-skills
drwxr-xr-x 1 mb mb  16 Sep  8 11:31 nextjs-on-cloudflare
lrwxrwxrwx 1 mb mb  48 Aug 24 20:41 omarchy -> /usr/share/omarchy/default/agents/skills/omarchy
drwxr-xr-x 1 mb mb  16 Sep  8 11:31 sandbox-migrate-to-next
drwxr-xr-x 1 mb mb  36 Sep  8 11:31 sandbox-next
drwxr-xr-x 1 mb mb  36 Jul 19 22:43 sandbox-sdk
drwxr-xr-x 1 mb mb  16 Sep  8 11:31 sandbox-stable
drwxr-xr-x 1 mb mb  78 Jul 19 22:43 turnstile-spin
drwxr-xr-x 1 mb mb  16 Jul 19 22:43 web-perf
drwxr-xr-x 1 mb mb  36 Jul 19 22:43 workers-best-practices
drwxr-xr-x 1 mb mb  16 Jul 19 22:43 wrangler
---opencode check---
⠀                                ▄     
█▀▀█ █▀▀█ █▀▀█ █▀▀▄ █▀▀▀ █▀▀█ █▀▀█ █▀▀█
█  █ █  █ █▀▀▀ █  █ █    █  █ █  █ █▀▀▀
▀▀▀▀ █▀▀▀ ▀▀▀▀ ▀  ▀ ▀▀▀▀ ▀▀▀▀ ▀▀▀▀ ▀▀▀▀

Commands:
  opencode completion          generate shell completion script
  opencode acp                 start ACP (Agent Client Protocol) server
  opencode mcp                 manage MCP (Model Context Protocol) servers
  opencode [project]           start opencode tui                                          [default]
  opencode attach <url>        attach to a running opencode server
  opencode run [message..]     run opencode with a message
  opencode debug               debugging and troubleshooting tools
  opencode providers           manage AI providers and credentials                   [aliases: auth]
  opencode agent               manage agents
  opencode upgrade [target]    upgrade opencode to the latest or a specific version
  opencode uninstall           uninstall opencode and remove all related files
  opencode serve               starts a headless opencode server
  opencode web                 start opencode server and open web interface
  opencode models [provider]   list all available models
  opencode stats               show token usage and cost statistics
  opencode export [sessionID]  export session data as JSON
  opencode import <file>       import session data from JSON file or URL
  opencode github              manage GitHub agent
  opencode pr <number>         fetch and checkout a GitHub PR branch, then run opencode
  opencode session             manage sessions
  opencode plugin <module>     install plugin and update config                      [aliases: plug]
  opencode db                  database tools

Positionals:
  project  path to start opencode in                                                        [string]

Options:
  -h, --help          show help                                                            [boolean]
  -v, --version       show version number                                                  [boolean]
      --print-logs    print logs to stderr                                                 [boolean]
      --log-level     log level                 [string] [choices: "DEBUG", "INFO", "WARN", "ERROR"]
      --pure          run without external plugins                                         [boolean]
      --port          port to listen on                                        [number] [default: 0]
      --hostname      hostname to listen on                          [string] [default: "127.0.0.1"]
      --mdns          enable mDNS service discovery (defaults hostname to 0.0.0.0)
                                                                          [boolean] [default: false]
      --mdns-domain   custom domain name for mDNS service (default: opencode.local)
                                                                [string] [default: "opencode.local"]
      --cors          additional domains to allow for CORS                     [array] [default: []]
  -m, --model         model to use in the format of provider/model                          [string]
  -c, --continue      continue the last session                                            [boolean]
  -s, --session       session id to continue                                                [string]
      --fork          fork the session when continuing (use with --continue or --session)  [boolean]
      --prompt        prompt to use                                                         [string]
      --agent         agent to use                                                          [string]
      --auto          auto-approve permissions that are not explicitly denied (dangerous!)
                                                                          [boolean] [default: false]
      --mini          start the minimal interactive interface             [boolean] [default: false]
      --no-replay     disable mini session history replay on resume and after resize       [boolean]
      --replay-limit  cap visible mini replay to the newest N messages                      [number]
⠀                                ▄     
█▀▀█ █▀▀█ █▀▀█ █▀▀▄ █▀▀▀ █▀▀█ █▀▀█ █▀▀█
█  █ █  █ █▀▀▀ █  █ █    █  █ █  █ █▀▀▀
▀▀▀▀ █▀▀▀ ▀▀▀▀ ▀  ▀ ▀▀▀▀ ▀▀▀▀ ▀▀▀▀ ▀▀▀▀

Commands:
  opencode completion          generate shell completion script
  opencode acp                 start ACP (Agent Client Protocol) server
  opencode mcp                 manage MCP (Model Context Protocol) servers
  opencode [project]           start opencode tui                                          [default]
  opencode attach <url>        attach to a running opencode server
  opencode run [message..]     run opencode with a message
  opencode debug               debugging and troubleshooting tools
  opencode providers           manage AI providers and credentials                   [aliases: auth]
  opencode agent               manage agents
  opencode upgrade [target]    upgrade opencode to the latest or a specific version
  opencode uninstall           uninstall opencode and remove all related files
  opencode serve               starts a headless opencode server
  opencode web                 start opencode server and open web interface
  opencode models [provider]   list all available models
  opencode stats               show token usage and cost statistics
  opencode export [sessionID]  export session data as JSON
  opencode import <file>       import session data from JSON file or URL
  opencode github              manage GitHub agent
  opencode pr <number>         fetch and checkout a GitHub PR branch, then run opencode
  opencode session             manage sessions
  opencode plugin <module>     install plugin and update config                      [aliases: plug]
  opencode db                  database tools

Positionals:
  project  path to start opencode in                                                        [string]

Options:
  -h, --help          show help                                                            [boolean]
  -v, --version       show version number                                                  [boolean]
      --print-logs    print logs to stderr                                                 [boolean]
      --log-level     log level                 [string] [choices: "DEBUG", "INFO", "WARN", "ERROR"]
      --pure          run without external plugins                                         [boolean]
      --port          port to listen on                                        [number] [default: 0]
      --hostname      hostname to listen on                          [string] [default: "127.0.0.1"]
      --mdns          enable mDNS service discovery (defaults hostname to 0.0.0.0)
                                                                          [boolean] [default: false]
      --mdns-domain   custom domain name for mDNS service (default: opencode.local)
                                                                [string] [default: "opencode.local"]
      --cors          additional domains to allow for CORS                     [array] [default: []]
  -m, --model         model to use in the format of provider/model                          [string]
  -c, --continue      continue the last session                                            [boolean]
  -s, --session       session id to continue                                                [string]
      --fork          fork the session when continuing (use with --continue or --session)  [boolean]
      --prompt        prompt to use                                                         [string]
      --agent         agent to use                                                          [string]
      --auto          auto-approve permissions that are not explicitly denied (dangerous!)
                                                                          [boolean] [default: false]
      --mini          start the minimal interactive interface             [boolean] [default: false]
      --no-replay     disable mini session history replay on resume and after resize       [boolean]
      --replay-limit  cap visible mini replay to the newest N messages                      [number]

```

---

## Assistant (Build · Muse Spark 1.3 Free · 8.8s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "ls -l ~/.config/opencode/skills/ | head -n 30; echo \"---\"; ls -l /usr/share/omarchy/default/agents/skills/omarchy/; echo \"---\"; cat /usr/share/omarchy/default/agents/skills/omarchy/SKILL.md | head -n 15"
}
```

**Output:**
```
total 0
drwxr-xr-x 1 mb mb 36 Jul 19 22:43 agents-sdk
drwxr-xr-x 1 mb mb 36 Jul 19 22:43 cloudflare
drwxr-xr-x 1 mb mb 36 Jul 19 22:43 cloudflare-email-service
drwxr-xr-x 1 mb mb 16 Jul 19 22:43 cloudflare-one
drwxr-xr-x 1 mb mb 16 Jul 19 22:43 cloudflare-one-migrations
drwxr-xr-x 1 mb mb 36 Jul 19 22:43 durable-objects
drwxr-xr-x 1 mb mb 16 Sep  8 11:31 nextjs-on-cloudflare
drwxr-xr-x 1 mb mb 16 Sep  8 11:31 sandbox-migrate-to-next
drwxr-xr-x 1 mb mb 36 Sep  8 11:31 sandbox-next
drwxr-xr-x 1 mb mb 36 Jul 19 22:43 sandbox-sdk
drwxr-xr-x 1 mb mb 16 Sep  8 11:31 sandbox-stable
drwxr-xr-x 1 mb mb 78 Jul 19 22:43 turnstile-spin
drwxr-xr-x 1 mb mb 16 Jul 19 22:43 web-perf
drwxr-xr-x 1 mb mb 36 Jul 19 22:43 workers-best-practices
drwxr-xr-x 1 mb mb 16 Jul 19 22:43 wrangler
---
total 40
-rw-r--r-- 1 root root  2217 Sep  9 00:00 capture.md
-rw-r--r-- 1 root root  2385 Sep  9 00:00 contributing.md
-rw-r--r-- 1 root root  1063 Sep  9 00:00 hooks.md
-rw-r--r-- 1 root root  3376 Sep  9 00:00 hyprland.md
-rw-r--r-- 1 root root  1820 Sep  9 00:00 plugins.md
-rw-r--r-- 1 root root 13248 Sep  9 00:00 SKILL.md
-rw-r--r-- 1 root root  3245 Sep  9 00:00 theming.md
---
---
name: omarchy
description: >
  REQUIRED for end-user customization of Linux desktop, window manager, or system config.
  Use when editing ~/.config/hypr/, ~/.config/omarchy/,
  ~/.config/alacritty/, ~/.config/foot/, ~/.config/kitty/, or ~/.config/ghostty/.
  Triggers: Hyprland, window rules, animations, keybindings, monitors, gaps, borders,
  blur, opacity, omarchy-shell, bar, terminal config, themes, background,
  night light, idle, lock screen, screenshots, reminders, layer rules, workspace
  settings, display config, and user-facing omarchy commands. Excludes Omarchy
  source development through `omarchy dev link` workflows.
---

# Omarchy Skill


```

---

## Assistant (Build · Muse Spark 1.3 Free · 4.6s)

_Thinking:_



Your Omarchy skill is already auto-loaded via `~/.agents/skills`, but I'll pin it explicitly as a global OpenCode skill so it survives external-skill toggles.

**Tool: bash**

**Input:**
```json
{
  "command": "ln -s /usr/share/omarchy/default/agents/skills/omarchy /home/mb/.config/opencode/skills/omarchy && ls -l /home/mb/.config/opencode/skills/omarchy/ && echo \"SYMLINK OK\""
}
```

**Output:**
```
total 40
-rw-r--r-- 1 root root  2217 Sep  9 00:00 capture.md
-rw-r--r-- 1 root root  2385 Sep  9 00:00 contributing.md
-rw-r--r-- 1 root root  1063 Sep  9 00:00 hooks.md
-rw-r--r-- 1 root root  3376 Sep  9 00:00 hyprland.md
-rw-r--r-- 1 root root  1820 Sep  9 00:00 plugins.md
-rw-r--r-- 1 root root 13248 Sep  9 00:00 SKILL.md
-rw-r--r-- 1 root root  3245 Sep  9 00:00 theming.md
SYMLINK OK

```

---

## Assistant (Build · Muse Spark 1.3 Free · 6.0s)

_Thinking:_



Added `omarchy` skill to OpenCode as a global skill:

**What I did:**
- Symlinked `/usr/share/omarchy/default/agents/skills/omarchy` → `~/.config/opencode/skills/omarchy`
- Used a symlink (not copy) so `omarchy update` changes flow through automatically, same pattern as `~/.agents/skills/omarchy` and `~/.claude/skills/omarchy`

**Why symlink:**
- `/usr/share/omarchy/` is package-owned and overwritten on update — never copy from it, just link/read.
- Opencode auto-loads `~/.agents/skills/` and `~/.claude/skills/` already, so you were technically covered, but now it's explicit in `~/.config/opencode/skills/` and works even with `OPENCODE_DISABLE_EXTERNAL_SKILLS=1`.

**Verify:**
```
ls -l ~/.config/opencode/skills/omarchy/
cat ~/.config/opencode/skills/omarchy/SKILL.md | head
```

Includes `SKILL.md` + `hyprland.md`, `plugins.md`, `theming.md`, `hooks.md`, `capture.md`, `contributing.md`.

Quit and restart `opencode` for the new global skill to load — config/skills are loaded once at startup, not hot-reloaded.


---

## User

using omarchy skills, update the workspace number 1 by name "code" 

---

## Assistant (Build · Muse Spark 1.3 Free · 49.8s)

_Thinking:_



On it — renaming workspace 1 to "code" using the Omarchy workflow.

**Tool: skill**

**Input:**
```json
{
  "name": "omarchy"
}
```

**Output:**
```
<skill_content name="omarchy">
# Skill: omarchy

# Omarchy Skill

Manage [Omarchy](https://omarchy.org/) Linux systems - a beautiful, modern, opinionated Arch Linux distribution with Hyprland.

This skill is for end-user customization on installed systems.
It is not for contributing to Omarchy source code.

## When This Skill MUST Be Used

**ALWAYS invoke this skill for end-user requests involving ANY of these:**

- Editing ANY file in `~/.config/hypr/` (window rules, animations, keybindings, monitors, etc.)
- Editing `~/.config/omarchy/shell.json` (status bar layout, widgets)
- Editing terminal configs (alacritty, foot, kitty, ghostty)
- Editing ANY file in `~/.config/omarchy/`
- Window behavior, animations, opacity, blur, gaps, borders
- Layer rules, workspace settings, display/monitor configuration
- Themes, backgrounds, fonts, appearance changes
- User-facing `omarchy` commands (`omarchy theme ...`, `omarchy refresh ...`, `omarchy restart ...`, etc.)
- Screenshots, screen recording, reminders, night light, idle behavior, lock screen

**If you're about to edit a config file in ~/.config/ on this system, STOP and use this skill first.**

**Do NOT use this skill for Omarchy development tasks** (editing the Omarchy source tree, creating migrations, or running `omarchy dev ...` workflows).

## Topic Guides

Deeper instructions for common areas live next to this file. Read the
matching guide before starting:

- [`hyprland.md`](hyprland.md) - keybindings, monitors, window rules, and other Hyprland config
- [`plugins.md`](plugins.md) - the Omarchy shell: bar layout, widgets, plugins, idle behavior
- [`theming.md`](theming.md) - themes, backgrounds, and fonts
- [`hooks.md`](hooks.md) - automation hooks that run on system events
- [`capture.md`](capture.md) - screenshots, screen recordings, OCR text capture, and file sharing
- [`contributing.md`](contributing.md) - reporting Omarchy bugs and submitting fixes upstream

## Critical Safety Rules

For privileged commands, follow the Privilege Escalation rules below: `sudo` when a terminal is available for the password prompt, `pkexec` when it is not. Do not wrap commands that already manage privilege elevation themselves.

**For end-user customization tasks, NEVER modify anything in `/usr/share/omarchy/`** - but READING is safe and encouraged.

This directory is owned by the omarchy package. Any local changes will be
overwritten on the next `omarchy update`.

```
/usr/share/omarchy/     # READ-ONLY - NEVER EDIT (reading is OK)
├── bin/                    # Command source (packaged binaries are on PATH)
├── config/                 # Default config templates
├── themes/                 # Stock themes
├── default/                # System defaults
├── shell/                  # Omarchy shell source and defaults
├── migrations/             # Update migrations
└── install/                # Installation scripts
```

**Reading `/usr/share/omarchy/` is SAFE and useful** - do it freely to:
- Understand how omarchy commands work: `omarchy theme set --help` or `cat $(which omarchy-theme-set)`
- See default configs before customizing: `cat "$OMARCHY_PATH/config/omarchy/shell.json"`
- Check stock theme files to copy for customization
- Reference default hyprland settings: `cat /usr/share/omarchy/default/hypr/*`

**Always use these safe locations instead:**
- `~/.config/` - User configuration (safe to edit)
- `~/.config/omarchy/themes/<custom-name>/` - Custom themes
- `~/.config/omarchy/hooks/` - Custom automation hooks

If the request is to develop Omarchy itself, this skill is out of scope. Follow repository development instructions instead of this skill.

## Privilege Escalation

For an interactive script or command run in a visible terminal, use `sudo` for
privileged work. Omarchy may grant passwordless `sudo` access to particular
commands, and the terminal is the appropriate place to request a password
when one is needed.

Use `pkexec` only when the caller cannot interact with a terminal or cannot
enter a password there, such as a command launched by an agent or a graphical
background process. Do not replace `sudo` with `pkexec` merely because a
command changes system state.

## System Architecture

Omarchy is built on:

| Component | Purpose | Config Location |
|-----------|---------|-----------------|
| **Arch Linux** | Base OS | `/etc/`, `~/.config/` |
| **Hyprland** | Wayland compositor/WM | `~/.config/hypr/` |
| **Omarchy shell** | Status bar + notifications (Quickshell) | `~/.config/omarchy/shell.json` |
| **Launcher/menus** | Quickshell menu | `~/.config/omarchy/extensions/omarchy-menu.jsonc` |
| **Alacritty/Foot/Kitty/Ghostty** | Terminals | `~/.config/<terminal>/` |
| **Omarchy OSD** | On-screen display | Quickshell plugin |

## Command Discovery

Omarchy ships a single `omarchy` CLI that dispatches to all `omarchy-*` binaries via `omarchy <group> <action>`. Always prefer this form — it is self-documenting and stable. The underlying `omarchy-*` binaries still exist on `PATH` and remain safe to read for source.

```bash
# List every documented command and its summary (--all includes hidden commands)
omarchy commands

# Show the commands inside a group
omarchy theme --help
omarchy refresh --help
omarchy restart --help

# Show help for a specific command (does not execute it)
omarchy theme set --help

# Machine-readable listing (binary, route, summary, args, aliases)
omarchy commands --json

# Read a command's source to understand it
cat $(which omarchy-theme-set)
```

### Command Groups

Run `omarchy --help` for the full list. The most common groups:

| Group | Purpose | Example |
|-------|---------|---------|
| `omarchy refresh` | Reset config to defaults (backs up first) | `omarchy refresh shell` |
| `omarchy restart` | Restart a service/app | `omarchy restart shell` |
| `omarchy toggle` | Toggle feature on/off | `omarchy toggle nightlight` |
| `omarchy theme` | Theme management | `omarchy theme set <name>` |
| `omarchy bar` | Bar layout and widgets | `omarchy bar move omarchy.clock --section right` |
| `omarchy plugin` | Manage/clone shell plugins | `omarchy plugin clone omarchy.clock` |
| `omarchy hook` | Install automation hooks | `omarchy hook install theme-set <script>` |
| `omarchy install` | Install optional software / packages | `omarchy install docker dbs` |
| `omarchy launch` | Launch apps | `omarchy launch browser` |
| `omarchy capture` | Screenshots and recordings | `omarchy capture screenshot` |
| `omarchy reminder` | Desktop notification reminders | `omarchy reminder 15 "Pickup Jack"` |
| `omarchy pkg` | Package management | `omarchy pkg add <pkg>` |
| `omarchy setup` | Interactive setup wizards | `omarchy setup security fingerprint` |
| `omarchy update` | System updates | `omarchy update` |

## Configuration Locations

Hyprland config lives in `~/.config/hypr/` — see [`hyprland.md`](hyprland.md).
The Omarchy shell (bar, notifications, plugins, idle) is configured in
`~/.config/omarchy/shell.json` — see [`plugins.md`](plugins.md).

### Terminals

```
~/.config/alacritty/alacritty.toml
~/.config/foot/foot.ini
~/.config/kitty/kitty.conf
~/.config/ghostty/config
```

**Command:** `omarchy restart terminal`

### Other Configs

| App | Location |
|-----|----------|
| btop | `~/.config/btop/btop.conf` |
| fastfetch | `/etc/fastfetch/config.jsonc` default; `~/.config/fastfetch/config.jsonc` user override |
| lazygit | `~/.config/lazygit/config.yml` |
| starship | `~/.config/starship.toml` |
| git | `~/.config/git/config` |

## Safe Customization Patterns

### Edit User Config Directly

For simple changes, edit files in `~/.config/`:

```bash
# 1. Read current config
cat ~/.config/hypr/bindings.lua

# 2. Backup before changes
cp ~/.config/hypr/bindings.lua ~/.config/hypr/bindings.lua.bak.$(date +%s)

# 3. Make changes with Edit tool

# 4. Apply changes
# - Hyprland: auto-reloads on save, but MUST validate with `hyprctl reload` and `hyprctl configerrors`
# - Omarchy shell: shell.json and user plugin code under ~/.config/omarchy/plugins/ hot-reload on save
# - Menus/launcher: ~/.config/omarchy/extensions/omarchy-menu.jsonc hot-reloads on save
# - Terminals: apply with `omarchy restart terminal` (reloads running terminals; foot picks changes up in new windows)
```

### Reset to Defaults -- ALWAYS SEEK USER CONFIRMATION BEFORE RUNNING

When customizations go wrong:

```bash
# Reset specific config (creates backup automatically)
omarchy refresh shell
omarchy refresh hyprland

# The refresh command:
# 1. Backs up current config with timestamp
# 2. Copies default from $OMARCHY_PATH/config/
# 3. Restarts the component where the refresh needs it (e.g. `refresh shell`)
```

## System Commands

```bash
omarchy update                  # Full system update
omarchy version                 # Show Omarchy version
omarchy debug --no-sudo --print # Debug info (ALWAYS use these flags)
omarchy system lock             # Lock screen
omarchy system shutdown         # Shutdown
omarchy system reboot           # Reboot
```

**IMPORTANT:** Always run `omarchy debug` with `--no-sudo --print` flags to avoid interactive sudo prompts that will hang the terminal.

## Troubleshooting

```bash
# Get debug information (ALWAYS use these flags to avoid interactive prompts)
omarchy debug --no-sudo --print

# Reset specific config to defaults
omarchy refresh <app>

# Refresh specific config file
# config-file path is relative to ~/.config/
# eg. `omarchy refresh config hypr/hyprland.lua` will refresh ~/.config/hypr/hyprland.lua
omarchy refresh config <config-file>

# Full reinstall of configs (nuclear option)
omarchy reinstall
```

## Decision Framework

When user requests system changes:

1. **Is it a stock omarchy command?** Use it directly
2. **Is it a config edit?** Edit in `~/.config/`, never `/usr/share/omarchy/`
3. **Is it a theme customization?** Follow [`theming.md`](theming.md); create a NEW custom theme directory
4. **Is it automation?** Follow [`hooks.md`](hooks.md); use `omarchy hook install` and the hook `.d` directories
5. **Is it a package install?** Use `omarchy pkg add <pkgs...>` (or `omarchy pkg aur add <pkgs...>` for AUR-only packages)
6. **Is it built-in shell/plugin code?** Follow [`plugins.md`](plugins.md); clone it with `omarchy plugin clone`, never edit the packaged copy
7. **Unsure if command exists?** Run `omarchy commands` (or `omarchy <group> --help` for one group)

### Reminder Requests

When the user asks to set a reminder, use `omarchy reminder <minutes> [message]` directly. Convert natural language durations to minutes and title-case short reminder labels when appropriate.

```bash
omarchy reminder 15 "Pickup Jack"
omarchy reminder 60 "Check laundry"
omarchy reminder show
omarchy reminder clear
```

## Out of Scope

This skill intentionally does not cover Omarchy source development. Do not use this skill for:
- Editing files in `/usr/share/omarchy/` (`bin/`, `config/`, `default/`, `shell/`, `themes/`, `migrations/`, etc.)
- Creating or editing migrations
- Running `omarchy dev ...` commands

## Example Requests

- "Change my theme to catppuccin" -> `omarchy theme set catppuccin`
- "Add a keybinding for Super+E to open file manager" -> Check existing bindings first, call `hl.unbind` if needed, then `o.bind` in `~/.config/hypr/bindings.lua`
- "Configure my external monitor" -> Edit `~/.config/hypr/monitors.lua`
- "Make the window gaps smaller" -> Edit `~/.config/hypr/looknfeel.lua`
- "Turn on night light" -> `omarchy toggle nightlight` (for time-based schedules, edit `~/.config/hypr/hyprsunset.conf` profiles, then `omarchy restart hyprsunset`)
- "Set a reminder to pickup jack in 15 minutes" -> `omarchy reminder 15 "Pickup Jack"`
- "Show my reminders" -> `omarchy reminder show`
- "Clear all reminders" -> `omarchy reminder clear`
- "Customize the catppuccin theme colors" -> Overlay: put an edited `colors.toml` in `~/.config/omarchy/themes/catppuccin/`, then re-apply the theme (see `theming.md`)
- "Run a script every time I change themes" -> Install it with `omarchy hook install theme-set <script>`
- "Change how workspace labels are rendered" -> Clone `omarchy.workspaces`, which switches the bar to `<username>.workspaces`, then edit the clone
- "Lock after ten minutes" -> Set `idle.lock` to `600` in `~/.config/omarchy/shell.json`
- "Reset shell/bar to defaults" -> `omarchy refresh shell`
- "Record my screen" -> `omarchy screenrecord --fullscreen`, then `omarchy screenrecord --stop-recording` (see `capture.md`)
- "Report this bug to Omarchy" -> Gather diagnostics and a capture of the problem, then file it (see `contributing.md`)

Base directory for this skill: /home/mb/.agents/skills/omarchy
Relative paths in this skill (e.g., scripts/, reference/) are relative to this base directory.
Note: file list is sampled.

<skill_files>
<file>/home/mb/.agents/skills/omarchy/theming.md</file>
<file>/home/mb/.agents/skills/omarchy/hooks.md</file>
<file>/home/mb/.agents/skills/omarchy/capture.md</file>
<file>/home/mb/.agents/skills/omarchy/plugins.md</file>
<file>/home/mb/.agents/skills/omarchy/contributing.md</file>
<file>/home/mb/.agents/skills/omarchy/hyprland.md</file>
</skill_files>
</skill_content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 1.6s)

_Thinking:_



**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.agents/skills/omarchy/hyprland.md"
}
```

**Output:**
```
<path>/home/mb/.agents/skills/omarchy/hyprland.md</path>
<type>file</type>
<content>
1: # Hyprland Configuration
2: 
3: Read this before changing keybindings, monitors, window rules, or any other
4: Hyprland (window manager) configuration.
5: 
6: Omarchy configures Hyprland in Lua. User files are loaded after Omarchy's
7: defaults, so overrides go here:
8: 
9: ```
10: ~/.config/hypr/
11: ├── hyprland.lua       # Main config (loads Omarchy defaults, then user files)
12: ├── bindings.lua       # Keybindings
13: ├── monitors.lua       # Display configuration
14: ├── input.lua          # Keyboard/mouse settings
15: ├── looknfeel.lua      # Appearance (gaps, borders, animations)
16: ├── autostart.lua      # Startup applications
17: ├── hyprsunset.conf    # Night light / blue light filter
18: └── xdph.conf          # Screen sharing / desktop portal
19: ```
20: 
21: **Key behaviors (the `.lua` files):**
22: - Hyprland auto-reloads on config save (no restart needed for most changes)
23: - Use `hyprctl reload` to force reload
24: - After ANY Hyprland Lua config change, validate with `hyprctl reload` followed by `hyprctl configerrors`
25: - If `hyprctl configerrors` reports errors, address them and rerun validation until clean or until a real blocker is identified
26: - Use `omarchy refresh hyprland` to reset the Lua config files to defaults
27: 
28: The two `.conf` files are read by separate processes, so `hyprctl` neither
29: applies nor validates them:
30: - `hyprsunset.conf` (night light): apply changes with `omarchy restart hyprsunset`; reset with `omarchy refresh hyprsunset`
31: - `xdph.conf` (screen-sharing portal): applies when the portal restarts, e.g. on next login
32: 
33: ## Keybindings
34: 
35: Edit `~/.config/hypr/bindings.lua`. Format:
36: ```lua
37: o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")
38: o.bind("SUPER + B", "Browser", { launch = "chromium" })  -- launch wraps with uwsm-app
39: ```
40: 
41: View current bindings: `omarchy menu keybindings --print`
42: 
43: **IMPORTANT: When re-binding an existing key:**
44: 
45: 1. First check existing bindings: `omarchy menu keybindings --print`
46: 2. If the key is already bound, you MUST call `hl.unbind(...)` BEFORE the new `o.bind(...)`
47: 3. Inform the user what the key was previously bound to
48: 
49: Example - rebinding SUPER+F (which is bound to fullscreen by default):
50: ```lua
51: -- Unbind existing SUPER+F (was: fullscreen)
52: hl.unbind("SUPER + F")
53: -- New binding for file manager
54: o.bind("SUPER + F", "File manager", { launch = "nautilus" })
55: ```
56: 
57: Always tell the user: "Note: SUPER+F was previously bound to fullscreen. I've added an unbind to override it."
58: 
59: ## Display/Monitors
60: 
61: Edit `~/.config/hypr/monitors.lua`. Format:
62: ```lua
63: hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
64: hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@144", position = "1920x0", scale = 1 })
65: ```
66: 
67: List monitors and supported modes: `hyprctl monitors all`
68: 
69: ## Window Rules
70: 
71: **CRITICAL: Hyprland window rules syntax changes frequently between versions.**
72: 
73: Before writing ANY window rules, you MUST fetch the current documentation from the official Hyprland wiki:
74: - https://wiki.hypr.land/Configuring/Basics/Window-Rules/
75: 
76: DO NOT rely on cached or memorized window rule syntax. The format has changed multiple times and using outdated syntax will cause errors or unexpected behavior.
77: 
78: Window rules go in `~/.config/hypr/hyprland.lua` or a required Lua module. Prefer Omarchy's `o.window(match, rules)` helper — see examples in `$OMARCHY_PATH/default/hypr/windows.lua`.

(End of file - total 78 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/hypr"
}
```

**Output:**
```
<path>/home/mb/.config/hypr</path>
<type>directory</type>
<entries>
.luarc.json
#bindings.conf#
#hyprland.conf#
autostart.conf
autostart.conf.bak.1782634586
autostart.lua
bindings.conf
bindings.conf.bak.1782634586
bindings.lua
hypridle.conf
hypridle.conf.bak.1778436179
hyprland.conf
hyprland.conf.bak.1782634586
hyprland.lua
hyprlock.conf
hyprsunset.conf
input.conf
input.conf.bak.1782634586
input.lua
input.lua.bak.1789216721
looknfeel.conf
looknfeel.conf.bak.1782634586
looknfeel.lua
looknfeel.lua.bak.1789216721
monitors.conf
monitors.conf.bak.1782634586
monitors.lua
monitors.lua.bak.1789216721
shaders/
xdph.conf

(30 entries)
</entries>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 29.3s)

_Thinking:_



**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/hypr/hyprland.lua"
}
```

**Output:**
```
<path>/home/mb/.config/hypr/hyprland.lua</path>
<type>file</type>
<content>
1: -- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/
2: 
3: -- Omarchy's bootstrap keeps path setup out of this user config.
4: dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")
5: 
6: -- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
7: -- omarchy_default_bindings = false
8: --
9: -- Or disable only bindings for Omarchy's preinstalled apps/web apps while
10: -- keeping core window-manager bindings:
11: -- omarchy_preinstalled_bindings = false
12: 
13: -- Load Omarchy defaults.
14: require("default.hypr.omarchy")
15: 
16: -- Put your personal overrides in these files. They're loaded after Omarchy's
17: -- defaults so package updates can improve the defaults without rewriting your
18: -- ~/.config/hypr files.
19: require("hypr.monitors")
20: require("hypr.input")
21: require("hypr.bindings")
22: require("hypr.looknfeel")
23: require("hypr.autostart")
24: 
25: -- Toggle config flags dynamically.
26: require("default.hypr.toggles")
27: 
28: -- Add any other personal Hyprland configuration below.
29: o.window("qemu", { workspace = "5" })

(End of file - total 29 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/hypr/bindings.lua"
}
```

**Output:**
```
<path>/home/mb/.config/hypr/bindings.lua</path>
<type>file</type>
<content>
1: -- Keep only your personal keybinding overrides here. Add new bindings or
2: -- unbind defaults before replacing them.
3: 
4: -- See current bindings and descriptions:
5: --   omarchy menu keybindings --print
6: 
7: -- To disable every Omarchy default binding, set this in
8: -- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
9: -- only the bindings you want below:
10: --   omarchy_default_bindings = false
11: 
12: -- To disable all preinstalled app/webapp bindings, set:
13: --   omarchy_preinstalled_bindings = false
14: 
15: -- Add a new binding.
16: -- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")
17: -- o.bind = "SUPER 1, movetoworkspace, name:code"
18: 
19: -- Change an existing binding by unbinding it first, then binding the key again.
20: -- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
21: -- hl.unbind("SUPER + SPACE")
22: -- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")
23: 
24: -- Disable a default binding without replacing it.
25: -- hl.unbind("SUPER + SHIFT + B")
26: 
27: -- Logitech MX Keys examples:
28: -- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
29: -- o.bind("SUPER + H", nil, "voxtype record toggle")
30: -- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

(End of file - total 30 lines)
</content>
```

**Tool: bash**

**Input:**
```json
{
  "command": "hyprctl workspaces 2>&1; echo \"---\"; hyprctl monitors 2>&1 | head -n 40; echo \"---\"; cat /usr/share/omarchy/default/hypr/*.lua 2>&1 | head -n 200"
}
```

**Output:**
```
workspace ID 10 (10) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b1823c1e60
	lastwindowtitle: 5 MCP servers every Claude Code user needs right now. - YouTube
	ispersistent: 0
	tiledLayout: dwindle

workspace ID 1 (1) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b183e478e0
	lastwindowtitle: omarchy: ~
	ispersistent: 0
	tiledLayout: dwindle


---
Monitor eDP-1 (ID 0):
	3840x2160@60.00000 at 0x0
	description: BOE 0x097E
	make: BOE
	model: 0x097E
	physical size (mm): 310x170
	serial: 
	active workspace: 1 (1)
	special workspace: 0 ()
	reserved: 0 24 0 0
	scale: 3
	transform: 0
	focused: yes
	dpmsStatus: 1
	vrr: false
	solitary: 0
	solitaryBlockedBy: windowed mode,missing candidate
	activelyTearing: false
	tearingBlockedBy: next frame is not torn,user settings,missing candidate
	directScanoutTo: 0
	directScanoutBlockedBy: user settings,missing candidate
	disabled: false
	currentFormat: XRGB8888
	mirrorOf: none
	availableModes: 3840x2160@60.00Hz 
	colorManagementPreset: srgb
	sdrBrightness: 1
	sdrSaturation: 1
	sdrMinLuminance: 0.2
	sdrMaxLuminance: 80
	hardwareCursorsInUse: true


---
-- App-specific tweaks.
local paths = require("default.hypr.paths")
local require_all = require("default.hypr.require_all")

require_all.files(paths.omarchy_path .. "/default/hypr/apps", "default.hypr.apps")
hl.on("hyprland.start", function()
  -- Slow app launch fix -- set systemd vars before starting session services.
  hl.exec_cmd("systemctl --user import-environment $(env | cut -d'=' -f 1)")
  hl.exec_cmd("dbus-update-activation-environment --systemd --all")

  hl.exec_cmd("omarchy-launch-shell")
  hl.exec_cmd("omarchy-provision-first-run")
  hl.exec_cmd("omarchy-powerprofiles-init")
  hl.exec_cmd(o.launch("omarchy-hyprland-monitor-watch"))
  hl.exec_cmd(o.launch("udiskie --automount --no-notify --no-tray"))

  -- Run post-boot hooks after startup config has loaded.
  hl.exec_cmd("sleep 2 && omarchy-hook post-boot")
end)
local paths = require("default.hypr.paths")
local require_all = require("default.hypr.require_all")

require_all.files(paths.omarchy_path .. "/default/hypr/bindings", "default.hypr.bindings")
-- Hyprland bootstrap for Omarchy's Lua module path.

local home = os.getenv("HOME")
local reload_prefixes = {
  "default.hypr",
  "hypr",
  "omarchy.current.theme",
}

local function should_reload_module(module)
  for _, prefix in ipairs(reload_prefixes) do
    if module == prefix or module:sub(1, #prefix + 1) == prefix .. "." then
      return true
    end
  end

  return false
end

local modules_to_reload = {}
for module in pairs(package.loaded) do
  if should_reload_module(module) then
    table.insert(modules_to_reload, module)
  end
end

for _, module in ipairs(modules_to_reload) do
  package.loaded[module] = nil
end

-- Load generated state from ~/.local/state, user modules from ~/.config, and
-- Omarchy defaults from $OMARCHY_PATH.
package.path = home
  .. "/.local/state/?.lua;"
  .. home
  .. "/.config/?.lua;"
  .. (os.getenv("OMARCHY_PATH") or "/usr/share/omarchy")
  .. "/?.lua;"
  .. package.path
-- Disable a Hyprland input device whose name was stored as data, not Lua.
-- Device names come from USB descriptors and must never be loaded as code.

local paths = require("default.hypr.paths")

return function(kind)
  -- Hardcoded to ~/.local/state to match omarchy-toggle-input-device and the
  -- sibling bash toggle tools, which all write there regardless of
  -- XDG_STATE_HOME.
  local file = io.open(paths.home .. "/.local/state/omarchy/toggles/hypr/" .. kind .. "-disabled-name", "r")
  if not file then
    return
  end

  local name = file:read("*l")
  file:close()

  if name and name ~= "" then
    hl.device({ name = name, enabled = false })
  end
end
local paths = require("default.hypr.paths")
local require_optional = require("default.hypr.require_optional")

-- GUM environment variables for styling purposes.
require_optional.module("omarchy.current.theme.gum_env")

-- Cursor size.
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Force all apps to use Wayland.
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Allow better support for screen sharing (Google Meet, Discord, etc).
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Use XCompose file.
hl.env("XCOMPOSEFILE", paths.home .. "/.XCompose")

-- hyprctl setenv doesn't reach keybind dispatcher env; use hl.env.
hl.env("OMARCHY_PATH", paths.omarchy_path)

local bin_dir = paths.omarchy_path .. "/bin"
local kept = {}
for entry in (os.getenv("PATH") or "/usr/local/bin:/usr/bin"):gmatch("[^:]+") do
  if entry ~= bin_dir then table.insert(kept, entry) end
end
table.insert(kept, 1, bin_dir)
hl.env("PATH", table.concat(kept, ":"))

-- Hardware-specific environment.
require("default.hypr.nvidia")

hl.config({
  xwayland = {
    force_zero_scaling = true,
  },

  ecosystem = {
    no_update_news = true,
  },
})
-- Shared helpers for Hyprland Lua configuration.

o = o or {}

local function shell_quote(value)
  return "'" .. tostring(value):gsub("'", "'\\''") .. "'"
end

o.shell_quote = shell_quote

local function file_exists(path)
  local file = io.open(path, "r")
  if file then
    file:close()
    return true
  end

  return false
end

-- Hyprland reaps its own children, so os.execute() can't retrieve an exit status
-- from inside the compositor. Read a marker off stdout instead.
function o.shell_succeeds(command)
  -- Subshell, so the redirection covers every command rather than binding to
  -- the last one and letting an earlier one write its own OK into the pipe.
  local pipe = io.popen("( " .. command .. " ) >/dev/null 2>&1 && echo OK")
  if not pipe then
    return false
  end

  local output = pipe:read("*a") or ""
  pipe:close()

  return output:find("OK", 1, true) ~= nil
end

function o.cmd_present(command)
  if command:find("/", 1, true) then
    return file_exists(command)
  end

  local path = os.getenv("PATH") or "/usr/local/bin:/usr/bin"
  for directory in (path .. ":"):gmatch("([^:]*):") do
    if file_exists((directory ~= "" and directory or ".") .. "/" .. command) then
      return true
    end
  end

  return false
end

function o.cmd_missing(command)
  return not o.cmd_present(command)
end

local function command_from(value, description)
  if type(value) ~= "table" then
    return value
  end

  if value.omarchy then
    return "omarchy-launch-" .. value.omarchy
  elseif value.focus and value.launch then
    return o.launch_sole(value.focus, value.launch)
  elseif value.launch then
    return o.launch(value.launch)
  elseif value.webapp then
    if value.focus then

```

---

## Assistant (Build · Muse Spark 1.3 Free · 1.9s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "grep -r \"workspace\" /usr/share/omarchy/default/hypr/ 2>&1 | head -n 60; echo \"===\"; grep -r \"workspace\" ~/.config/hypr/ 2>&1 | head -n 60; echo \"===\"; ls /usr/share/omarchy/default/hypr/"
}
```

**Output:**
```
/usr/share/omarchy/default/hypr/apps/browser.lua:o.window({ title = ".*is sharing.*" }, { workspace = "special silent" })
/usr/share/omarchy/default/hypr/apps/omarchy-shell.lua:-- SUPER+ALT+F so component previews have the whole workspace.
/usr/share/omarchy/default/hypr/bindings/tiling.lua:o.bind("SUPER + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")
/usr/share/omarchy/default/hypr/bindings/tiling.lua:for workspace = 1, 10 do
/usr/share/omarchy/default/hypr/bindings/tiling.lua:  local key = "code:" .. tostring(workspace + 9)
/usr/share/omarchy/default/hypr/bindings/tiling.lua:  o.bind("SUPER + " .. key, "Switch to workspace " .. workspace, hl.dsp.focus({ workspace = tostring(workspace) }))
/usr/share/omarchy/default/hypr/bindings/tiling.lua:  o.bind("SUPER + SHIFT + " .. key, "Move window to workspace " .. workspace, hl.dsp.window.move({ workspace = tostring(workspace) }))
/usr/share/omarchy/default/hypr/bindings/tiling.lua:  o.bind("SUPER + SHIFT + ALT + " .. key, "Move window silently to workspace " .. workspace, hl.dsp.window.move({ workspace = tostring(workspace), follow = false }))
/usr/share/omarchy/default/hypr/bindings/tiling.lua:o.bind("SUPER + S", "Toggle scratchpad", hl.dsp.workspace.toggle_special("scratchpad"))
/usr/share/omarchy/default/hypr/bindings/tiling.lua:o.bind("SUPER + ALT + S", "Move window to scratchpad", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))
/usr/share/omarchy/default/hypr/bindings/tiling.lua:o.bind("SUPER + TAB", "Next workspace", hl.dsp.focus({ workspace = "e+1" }))
/usr/share/omarchy/default/hypr/bindings/tiling.lua:o.bind("SUPER + SHIFT + TAB", "Previous workspace", hl.dsp.focus({ workspace = "e-1" }))
/usr/share/omarchy/default/hypr/bindings/tiling.lua:o.bind("SUPER + CTRL + TAB", "Former workspace", hl.dsp.focus({ workspace = "previous" }))
/usr/share/omarchy/default/hypr/bindings/tiling.lua:o.bind("SUPER + SHIFT + ALT + LEFT", "Move workspace to left monitor", hl.dsp.workspace.move({ monitor = "l" }))
/usr/share/omarchy/default/hypr/bindings/tiling.lua:o.bind("SUPER + SHIFT + ALT + RIGHT", "Move workspace to right monitor", hl.dsp.workspace.move({ monitor = "r" }))
/usr/share/omarchy/default/hypr/bindings/tiling.lua:o.bind("SUPER + SHIFT + ALT + UP", "Move workspace to up monitor", hl.dsp.workspace.move({ monitor = "u" }))
/usr/share/omarchy/default/hypr/bindings/tiling.lua:o.bind("SUPER + SHIFT + ALT + DOWN", "Move workspace to down monitor", hl.dsp.workspace.move({ monitor = "d" }))
/usr/share/omarchy/default/hypr/bindings/tiling.lua:o.bind("SUPER + mouse_down", "Scroll active workspace forward", hl.dsp.focus({ workspace = "e+1" }))
/usr/share/omarchy/default/hypr/bindings/tiling.lua:o.bind("SUPER + mouse_up", "Scroll active workspace backward", hl.dsp.focus({ workspace = "e-1" }))
/usr/share/omarchy/default/hypr/looknfeel.lua:hl.animation({ leaf = "workspaces", enabled = false })
/usr/share/omarchy/default/hypr/looknfeel.lua:    initial_workspace_tracking = 0,
/usr/share/omarchy/default/hypr/looknfeel.lua:    warp_on_change_workspace = 1,
/usr/share/omarchy/default/hypr/looknfeel.lua:    hide_special_on_workspace_change = true,
/usr/share/omarchy/default/hypr/toggles.lua:require("default.hypr.workspace-layouts")
/usr/share/omarchy/default/hypr/workspace-layouts.lua:-- Restore workspace layouts saved by omarchy-hyprland-workspace-layout-toggle.
/usr/share/omarchy/default/hypr/workspace-layouts.lua:local layouts_dir = paths.state_home .. "/omarchy/workspace-layouts"
/usr/share/omarchy/default/hypr/workspace-layouts.lua:require_all.files(layouts_dir, "omarchy.workspace-layouts", { reload = true })
===
/home/mb/.config/hypr/hyprland.conf:windowrule = workspace 20, match:class qemu
/home/mb/.config/hypr/input.conf.bak.1782634586:# Enable touchpad gestures for changing workspaces
/home/mb/.config/hypr/input.conf.bak.1782634586:# gesture = 3, horizontal, workspace
/home/mb/.config/hypr/hyprland.conf.bak.1782634586:# windowrule = workspace 5, class:qemu
/home/mb/.config/hypr/#hyprland.conf#:# windowrule = workspace 5, match:class qemu
/home/mb/.config/hypr/.luarc.json:  "workspace": {
/home/mb/.config/hypr/input.conf:# Enable touchpad gestures for changing workspaces
/home/mb/.config/hypr/input.conf:# gesture = 3, horizontal, workspace
/home/mb/.config/hypr/input.lua.bak.1789216721:-- Enable touchpad gestures for changing workspaces.
/home/mb/.config/hypr/input.lua.bak.1789216721:-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
/home/mb/.config/hypr/input.lua:-- Enable touchpad gestures for changing workspaces.
/home/mb/.config/hypr/input.lua:-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
/home/mb/.config/hypr/hyprland.lua:o.window("qemu", { workspace = "5" })
/home/mb/.config/hypr/bindings.lua:-- o.bind = "SUPER 1, movetoworkspace, name:code"
===
apps
apps.lua
autostart.lua
bindings
bindings.lua
bootstrap.lua
disabled-input-device.lua
envs.lua
helpers.lua
input.lua
looknfeel.lua
nvidia.lua
omarchy.lua
paths.lua
require_all.lua
require_optional.lua
toggles
toggles.lua
windows.lua
workspace-layouts.lua

```

---

## Assistant (Build · Muse Spark 1.3 Free · 6.4s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "grep -rn \"hl\\.\\|o\\.window\\|workspace\\|rename\" /usr/share/omarchy/default/hypr/helpers.lua 2>&1 | head -n 100; echo \"===\"; cat /usr/share/omarchy/default/hypr/helpers.lua 2>&1 | head -n 300; echo \"===\"; cat /usr/share/omarchy/default/hypr/windows.lua 2>&1 | head -n 100"
}
```

**Output:**
```
102:    dispatcher = hl.dsp.exec_cmd(dispatcher)
105:  hl.bind(keys, dispatcher, opts)
113:  hl.on("hyprland.start", function()
114:    hl.exec_cmd(command)
142:function o.window(match, rules)
153:  hl.window_rule(rules)
===
-- Shared helpers for Hyprland Lua configuration.

o = o or {}

local function shell_quote(value)
  return "'" .. tostring(value):gsub("'", "'\\''") .. "'"
end

o.shell_quote = shell_quote

local function file_exists(path)
  local file = io.open(path, "r")
  if file then
    file:close()
    return true
  end

  return false
end

-- Hyprland reaps its own children, so os.execute() can't retrieve an exit status
-- from inside the compositor. Read a marker off stdout instead.
function o.shell_succeeds(command)
  -- Subshell, so the redirection covers every command rather than binding to
  -- the last one and letting an earlier one write its own OK into the pipe.
  local pipe = io.popen("( " .. command .. " ) >/dev/null 2>&1 && echo OK")
  if not pipe then
    return false
  end

  local output = pipe:read("*a") or ""
  pipe:close()

  return output:find("OK", 1, true) ~= nil
end

function o.cmd_present(command)
  if command:find("/", 1, true) then
    return file_exists(command)
  end

  local path = os.getenv("PATH") or "/usr/local/bin:/usr/bin"
  for directory in (path .. ":"):gmatch("([^:]*):") do
    if file_exists((directory ~= "" and directory or ".") .. "/" .. command) then
      return true
    end
  end

  return false
end

function o.cmd_missing(command)
  return not o.cmd_present(command)
end

local function command_from(value, description)
  if type(value) ~= "table" then
    return value
  end

  if value.omarchy then
    return "omarchy-launch-" .. value.omarchy
  elseif value.focus and value.launch then
    return o.launch_sole(value.focus, value.launch)
  elseif value.launch then
    return o.launch(value.launch)
  elseif value.webapp then
    if value.focus then
      return o.launch_webapp_sole(description, value.webapp)
    else
      return o.launch_webapp(value.webapp)
    end
  elseif value.tui then
    if value.focus then
      return "omarchy-launch-or-focus-tui " .. shell_quote(value.tui)
    else
      return "omarchy-launch-tui " .. shell_quote(value.tui)
    end
  end

  return value
end

function o.preinstalled_bindings_enabled()
  if _G.omarchy_preinstalled_bindings ~= nil then
    return _G.omarchy_preinstalled_bindings == true
  end

  return not file_exists((os.getenv("HOME") or "") .. "/.local/state/omarchy/preinstalls-removed")
end

function o.bind(keys, description, dispatcher, options)
  local opts = options or {}

  if description then
    opts.description = description
  end

  dispatcher = command_from(dispatcher, description)

  if type(dispatcher) == "string" then
    dispatcher = hl.dsp.exec_cmd(dispatcher)
  end

  hl.bind(keys, dispatcher, opts)
end

function o.launch(command)
  return "uwsm-app -- " .. command
end

function o.exec_on_start(command)
  hl.on("hyprland.start", function()
    hl.exec_cmd(command)
  end)
end

function o.launch_on_start(command)
  o.exec_on_start(o.launch(command))
end

function o.launch_webapp(url)
  return "omarchy-launch-webapp " .. shell_quote(url)
end

function o.launch_webapp_sole(name, url)
  return "omarchy-launch-or-focus-webapp " .. shell_quote(name) .. " " .. shell_quote(url)
end

function o.launch_sole(match, command)
  return "omarchy-launch-or-focus " .. shell_quote(match) .. " " .. shell_quote(o.launch(command))
end

function o.bind_toggle(keys, description, toggle, options)
  o.bind(keys, description, "omarchy-toggle-" .. toggle, options)
end

function o.notify(message)
  return "omarchy-notification-send -u low " .. shell_quote(message)
end

function o.window(match, rules)
  rules.match = rules.match or {}

  if type(match) == "string" then
    rules.match.class = match
  else
    for key, value in pairs(match) do
      rules.match[key] = value
    end
  end

  hl.window_rule(rules)
end
===
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

o.window(".*", { suppress_event = "maximize" })

-- Tag all windows for default opacity (apps can override with -default-opacity tag).
o.window(".*", { tag = "+default-opacity" })

-- Fix some dragging issues with XWayland.
o.window(
  {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  { no_focus = true }
)

-- App-specific tweaks (may remove default-opacity tag).
require("default.hypr.apps")

-- Apply default opacity after apps have had a chance to opt out.
o.window({ tag = "default-opacity" }, { opacity = "0.985 0.96" })

```

---

## Assistant (Build · Muse Spark 1.3 Free · 4.4s)

_Thinking:_



**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/hypr/.luarc.json"
}
```

**Output:**
```
<path>/home/mb/.config/hypr/.luarc.json</path>
<type>file</type>
<content>
1: {
2:   "workspace": {
3:     "library": [
4:       "/usr/share/hypr/stubs"
5:     ],
6:     "checkThirdParty": false
7:   },
8:   "diagnostics": {
9:     "globals": ["hl", "o"]
10:   }
11: }

(End of file - total 11 lines)
</content>
```

**Tool: bash**

**Input:**
```json
{
  "command": "hyprctl dispatch renameworkspace --help 2>&1 || hyprctl dispatch --help 2>&1 | head -n 100; echo \"===\"; hyprctl --help 2>&1 | head -n 60"
}
```

**Output:**
```
usage: hyprctl [flags] <command> [args...|--help]

commands:
    activewindow        → Gets the active window name and its properties
    activeworkspace     → Gets the active workspace and its properties
    animations          → Gets the current config'd info about animations
                          and beziers
    binds               → Lists all registered binds
    clients             → Lists all windows with their properties
    configerrors        → Lists all current config parsing errors
    cursorpos           → Gets the current cursor position in global layout
                          coordinates
    decorations <window_regex> → Lists all decorations and their info
    devices             → Lists all connected keyboards and mice
    dismissnotify [amount] → Dismisses all or up to AMOUNT notifications
    dispatch <dispatcher> [args] → Issue a dispatch to call a keybind
                          dispatcher with arguments
    eval <code>         → Issue a Lua string to execute
    getoption <option>  → Gets the config option status (values)
    globalshortcuts     → Lists all global shortcuts
    hyprpaper ...       → Issue a hyprpaper request
    hyprsunset ...      → Issue a hyprsunset request
    instances           → Lists all running instances of Hyprland with
                          their info
    keyword <name> <value> → Issue a keyword to call a config keyword
                          dynamically
    kill                → Issue a kill to get into a kill mode, where you can
                          kill an app by clicking on it. You can exit it
                          with ESCAPE
    layers              → Lists all the surface layers
    layouts             → Lists all layouts available (including plugin'd ones)
    monitors            → Lists active outputs with their properties,
                          'monitors all' lists active and inactive outputs
    notify ...          → Sends a notification using the built-in Hyprland
                          notification system
    output ...          → Allows you to add and remove fake outputs to your
                          preferred backend
    plugin ...          → Issue a plugin request
    reload [config-only] → Issue a reload to force reload the config. Pass
                          'config-only' to disable monitor reload
    repl [code]         → Enter interactive Lua REPL mode (^D to exit)
                          or issue a Lua string and print the result
    rollinglog          → Prints tail of the log. Also supports -f/--follow
                          option
    setcursor <theme> <size> → Sets the cursor theme and reloads the cursor
                          manager
    seterror <color> <message...> → Sets the hyprctl error string. Color has
                          the same format as in colors in config. Will reset
                          when Hyprland's config is reloaded
    setprop ...         → Sets a window property
    getprop ...         → Gets a window property
    splash              → Get the current splash
    status              → Get internal status information
    switchxkblayout ... → Sets the xkb layout index for a keyboard
    systeminfo          → Get system info
    version             → Prints the hyprland version, meaning flags, commit
                          and branch of build.
    workspacerules      → Lists all workspace rules
    workspaces          → Lists all workspaces with their properties

flags:
    -j                  → Output in JSON
    -r                  → Refresh state after issuing command (e.g. for
                          updating variables)
    --batch             → Execute a batch of commands, separated by ';'
    --instance (-i)     → use a specific instance. Can be either signature or
                          index in hyprctl instances (0, 1, etc)
    --quiet (-q)        → Disable the output of hyprctl

--help:
    Can be used to print command's arguments that did not fit into this page
    (three dots)
usage: hyprctl [flags] <command> [args...|--help]

commands:
    activewindow        → Gets the active window name and its properties
    activeworkspace     → Gets the active workspace and its properties
    animations          → Gets the current config'd info about animations
                          and beziers
    binds               → Lists all registered binds
    clients             → Lists all windows with their properties
    configerrors        → Lists all current config parsing errors
    cursorpos           → Gets the current cursor position in global layout
                          coordinates
    decorations <window_regex> → Lists all decorations and their info
    devices             → Lists all connected keyboards and mice
    dismissnotify [amount] → Dismisses all or up to AMOUNT notifications
    dispatch <dispatcher> [args] → Issue a dispatch to call a keybind
                          dispatcher with arguments
    eval <code>         → Issue a Lua string to execute
    getoption <option>  → Gets the config option status (values)
    globalshortcuts     → Lists all global shortcuts
    hyprpaper ...       → Issue a hyprpaper request
    hyprsunset ...      → Issue a hyprsunset request
    instances           → Lists all running instances of Hyprland with
                          their info
    keyword <name> <value> → Issue a keyword to call a config keyword
                          dynamically
    kill                → Issue a kill to get into a kill mode, where you can
                          kill an app by clicking on it. You can exit it
                          with ESCAPE
    layers              → Lists all the surface layers
    layouts             → Lists all layouts available (including plugin'd ones)
    monitors            → Lists active outputs with their properties,
                          'monitors all' lists active and inactive outputs
    notify ...          → Sends a notification using the built-in Hyprland
                          notification system
    output ...          → Allows you to add and remove fake outputs to your
                          preferred backend
    plugin ...          → Issue a plugin request
    reload [config-only] → Issue a reload to force reload the config. Pass
                          'config-only' to disable monitor reload
    repl [code]         → Enter interactive Lua REPL mode (^D to exit)
                          or issue a Lua string and print the result
    rollinglog          → Prints tail of the log. Also supports -f/--follow
                          option
    setcursor <theme> <size> → Sets the cursor theme and reloads the cursor
                          manager
    seterror <color> <message...> → Sets the hyprctl error string. Color has
                          the same format as in colors in config. Will reset
                          when Hyprland's config is reloaded
    setprop ...         → Sets a window property
    getprop ...         → Gets a window property
    splash              → Get the current splash
    status              → Get internal status information
    switchxkblayout ... → Sets the xkb layout index for a keyboard
    systeminfo          → Get system info
    version             → Prints the hyprland version, meaning flags, commit
                          and branch of build.
    workspacerules      → Lists all workspace rules
    workspaces          → Lists all workspaces with their properties

flags:
    -j                  → Output in JSON
    -r                  → Refresh state after issuing command (e.g. for
                          updating variables)
    --batch             → Execute a batch of commands, separated by ';'
    --instance (-i)     → use a specific instance. Can be either signature or
                          index in hyprctl instances (0, 1, etc)
    --quiet (-q)        → Disable the output of hyprctl

--help:
    Can be used to print command's arguments that did not fit into this page
    (three dots)
===
usage: hyprctl [flags] <command> [args...|--help]

commands:
    activewindow        → Gets the active window name and its properties
    activeworkspace     → Gets the active workspace and its properties
    animations          → Gets the current config'd info about animations
                          and beziers
    binds               → Lists all registered binds
    clients             → Lists all windows with their properties
    configerrors        → Lists all current config parsing errors
    cursorpos           → Gets the current cursor position in global layout
                          coordinates
    decorations <window_regex> → Lists all decorations and their info
    devices             → Lists all connected keyboards and mice
    dismissnotify [amount] → Dismisses all or up to AMOUNT notifications
    dispatch <dispatcher> [args] → Issue a dispatch to call a keybind
                          dispatcher with arguments
    eval <code>         → Issue a Lua string to execute
    getoption <option>  → Gets the config option status (values)
    globalshortcuts     → Lists all global shortcuts
    hyprpaper ...       → Issue a hyprpaper request
    hyprsunset ...      → Issue a hyprsunset request
    instances           → Lists all running instances of Hyprland with
                          their info
    keyword <name> <value> → Issue a keyword to call a config keyword
                          dynamically
    kill                → Issue a kill to get into a kill mode, where you can
                          kill an app by clicking on it. You can exit it
                          with ESCAPE
    layers              → Lists all the surface layers
    layouts             → Lists all layouts available (including plugin'd ones)
    monitors            → Lists active outputs with their properties,
                          'monitors all' lists active and inactive outputs
    notify ...          → Sends a notification using the built-in Hyprland
                          notification system
    output ...          → Allows you to add and remove fake outputs to your
                          preferred backend
    plugin ...          → Issue a plugin request
    reload [config-only] → Issue a reload to force reload the config. Pass
                          'config-only' to disable monitor reload
    repl [code]         → Enter interactive Lua REPL mode (^D to exit)
                          or issue a Lua string and print the result
    rollinglog          → Prints tail of the log. Also supports -f/--follow
                          option
    setcursor <theme> <size> → Sets the cursor theme and reloads the cursor
                          manager
    seterror <color> <message...> → Sets the hyprctl error string. Color has
                          the same format as in colors in config. Will reset
                          when Hyprland's config is reloaded
    setprop ...         → Sets a window property
    getprop ...         → Gets a window property
    splash              → Get the current splash
    status              → Get internal status information
    switchxkblayout ... → Sets the xkb layout index for a keyboard
    systeminfo          → Get system info
    version             → Prints the hyprland version, meaning flags, commit
                          and branch of build.
    workspacerules      → Lists all workspace rules
    workspaces          → Lists all workspaces with their properties


```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.0s)

_Thinking:_



I see what you're after — checking the workspace setup before applying the name.

**Tool: bash**

**Input:**
```json
{
  "command": "ls /usr/share/hypr/stubs/ 2>&1; grep -rn \"workspace\\|rename\" /usr/share/hypr/stubs/ 2>&1 | head -n 100"
}
```

**Output:**
```
hl.meta.lua
/usr/share/hypr/stubs/hl.meta.lua:25:---| "window.move_to_workspace"
/usr/share/hypr/stubs/hl.meta.lua:32:---| "workspace.active"
/usr/share/hypr/stubs/hl.meta.lua:33:---| "workspace.created"
/usr/share/hypr/stubs/hl.meta.lua:34:---| "workspace.move_to_monitor"
/usr/share/hypr/stubs/hl.meta.lua:35:---| "workspace.removed"
/usr/share/hypr/stubs/hl.meta.lua:36:---| "workspace.special_active"
/usr/share/hypr/stubs/hl.meta.lua:40:---| "animations.workspace_wraparound"
/usr/share/hypr/stubs/hl.meta.lua:42:---| "binds.allow_workspace_cycles"
/usr/share/hypr/stubs/hl.meta.lua:46:---| "binds.hide_special_on_workspace_change"
/usr/share/hypr/stubs/hl.meta.lua:53:---| "binds.workspace_back_and_forth"
/usr/share/hypr/stubs/hl.meta.lua:54:---| "binds.workspace_center_on"
/usr/share/hypr/stubs/hl.meta.lua:71:---| "cursor.warp_on_change_workspace"
/usr/share/hypr/stubs/hl.meta.lua:167:---| "general.gaps_workspaces"
/usr/share/hypr/stubs/hl.meta.lua:183:---| "gestures.workspace_swipe_cancel_ratio"
/usr/share/hypr/stubs/hl.meta.lua:184:---| "gestures.workspace_swipe_create_new"
/usr/share/hypr/stubs/hl.meta.lua:185:---| "gestures.workspace_swipe_direction_lock"
/usr/share/hypr/stubs/hl.meta.lua:186:---| "gestures.workspace_swipe_direction_lock_threshold"
/usr/share/hypr/stubs/hl.meta.lua:187:---| "gestures.workspace_swipe_distance"
/usr/share/hypr/stubs/hl.meta.lua:188:---| "gestures.workspace_swipe_forever"
/usr/share/hypr/stubs/hl.meta.lua:189:---| "gestures.workspace_swipe_invert"
/usr/share/hypr/stubs/hl.meta.lua:190:---| "gestures.workspace_swipe_min_speed_to_force"
/usr/share/hypr/stubs/hl.meta.lua:191:---| "gestures.workspace_swipe_touch"
/usr/share/hypr/stubs/hl.meta.lua:192:---| "gestures.workspace_swipe_touch_invert"
/usr/share/hypr/stubs/hl.meta.lua:193:---| "gestures.workspace_swipe_use_r"
/usr/share/hypr/stubs/hl.meta.lua:201:---| "group.group_on_movetoworkspace"
/usr/share/hypr/stubs/hl.meta.lua:340:---| "misc.initial_workspace_token_timeout"
/usr/share/hypr/stubs/hl.meta.lua:341:---| "misc.initial_workspace_tracking"
/usr/share/hypr/stubs/hl.meta.lua:468:---@field workspace_name? string
/usr/share/hypr/stubs/hl.meta.lua:505:---@field workspace? HL.WorkspaceSelector
/usr/share/hypr/stubs/hl.meta.lua:621:---@field workspace string
/usr/share/hypr/stubs/hl.meta.lua:695:---@field set_special_workspace fun(self: HL.Monitor, ...): any
/usr/share/hypr/stubs/hl.meta.lua:696:---@field set_workspace fun(self: HL.Monitor, ...): any
/usr/share/hypr/stubs/hl.meta.lua:697:---@field active_special_workspace HL.Workspace|nil
/usr/share/hypr/stubs/hl.meta.lua:698:---@field active_workspace HL.Workspace|nil
/usr/share/hypr/stubs/hl.meta.lua:782:---@field workspace HL.Workspace|nil
/usr/share/hypr/stubs/hl.meta.lua:834:---@field get_active_special_workspace fun(monitor?: HL.MonitorSelector): HL.Workspace|nil
/usr/share/hypr/stubs/hl.meta.lua:836:---@field get_active_workspace fun(monitor?: HL.MonitorSelector): HL.Workspace|nil
/usr/share/hypr/stubs/hl.meta.lua:841:---@field get_last_workspace fun(monitor?: HL.MonitorSelector): HL.Workspace|nil
/usr/share/hypr/stubs/hl.meta.lua:851:---@field get_workspace fun(selector: HL.WorkspaceSelector): HL.Workspace|nil
/usr/share/hypr/stubs/hl.meta.lua:852:---@field get_workspace_windows fun(workspace: HL.WorkspaceSelector): HL.Window[]
/usr/share/hypr/stubs/hl.meta.lua:853:---@field get_workspaces fun(): HL.Workspace[]
/usr/share/hypr/stubs/hl.meta.lua:863:---@field workspace_rule fun(spec: HL.WorkspaceRuleSpec): HL.WorkspaceRule
/usr/share/hypr/stubs/hl.meta.lua:890:---@field workspace HL.DspWorkspaceNamespace
/usr/share/hypr/stubs/hl.meta.lua:935:---@field rename fun(...): HL.Dispatcher
/usr/share/hypr/stubs/hl.meta.lua:959:---@field ['animations.workspace_wraparound'] boolean
/usr/share/hypr/stubs/hl.meta.lua:961:---@field ['binds.allow_workspace_cycles'] boolean
/usr/share/hypr/stubs/hl.meta.lua:965:---@field ['binds.hide_special_on_workspace_change'] boolean
/usr/share/hypr/stubs/hl.meta.lua:972:---@field ['binds.workspace_back_and_forth'] boolean
/usr/share/hypr/stubs/hl.meta.lua:973:---@field ['binds.workspace_center_on'] integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:990:---@field ['cursor.warp_on_change_workspace'] integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:1086:---@field ['general.gaps_workspaces'] integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:1102:---@field ['gestures.workspace_swipe_cancel_ratio'] number|boolean
/usr/share/hypr/stubs/hl.meta.lua:1103:---@field ['gestures.workspace_swipe_create_new'] boolean
/usr/share/hypr/stubs/hl.meta.lua:1104:---@field ['gestures.workspace_swipe_direction_lock'] boolean
/usr/share/hypr/stubs/hl.meta.lua:1105:---@field ['gestures.workspace_swipe_direction_lock_threshold'] integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:1106:---@field ['gestures.workspace_swipe_distance'] integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:1107:---@field ['gestures.workspace_swipe_forever'] boolean
/usr/share/hypr/stubs/hl.meta.lua:1108:---@field ['gestures.workspace_swipe_invert'] boolean
/usr/share/hypr/stubs/hl.meta.lua:1109:---@field ['gestures.workspace_swipe_min_speed_to_force'] integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:1110:---@field ['gestures.workspace_swipe_touch'] boolean
/usr/share/hypr/stubs/hl.meta.lua:1111:---@field ['gestures.workspace_swipe_touch_invert'] boolean
/usr/share/hypr/stubs/hl.meta.lua:1112:---@field ['gestures.workspace_swipe_use_r'] boolean
/usr/share/hypr/stubs/hl.meta.lua:1120:---@field ['group.group_on_movetoworkspace'] boolean
/usr/share/hypr/stubs/hl.meta.lua:1259:---@field ['misc.initial_workspace_token_timeout'] integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:1260:---@field ['misc.initial_workspace_tracking'] integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:1342:---@field gaps_workspaces? integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:1427:---@field workspace_wraparound? boolean
/usr/share/hypr/stubs/hl.meta.lua:1507:---@field workspace_swipe_distance? integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:1508:---@field workspace_swipe_touch? boolean
/usr/share/hypr/stubs/hl.meta.lua:1509:---@field workspace_swipe_invert? boolean
/usr/share/hypr/stubs/hl.meta.lua:1510:---@field workspace_swipe_touch_invert? boolean
/usr/share/hypr/stubs/hl.meta.lua:1511:---@field workspace_swipe_min_speed_to_force? integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:1512:---@field workspace_swipe_cancel_ratio? number|boolean
/usr/share/hypr/stubs/hl.meta.lua:1513:---@field workspace_swipe_create_new? boolean
/usr/share/hypr/stubs/hl.meta.lua:1514:---@field workspace_swipe_direction_lock? boolean
/usr/share/hypr/stubs/hl.meta.lua:1515:---@field workspace_swipe_direction_lock_threshold? integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:1516:---@field workspace_swipe_forever? boolean
/usr/share/hypr/stubs/hl.meta.lua:1517:---@field workspace_swipe_use_r? boolean
/usr/share/hypr/stubs/hl.meta.lua:1534:---@field group_on_movetoworkspace? boolean
/usr/share/hypr/stubs/hl.meta.lua:1611:---@field initial_workspace_tracking? integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:1612:---@field initial_workspace_token_timeout? integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:1631:---@field workspace_back_and_forth? boolean
/usr/share/hypr/stubs/hl.meta.lua:1632:---@field hide_special_on_workspace_change? boolean
/usr/share/hypr/stubs/hl.meta.lua:1633:---@field allow_workspace_cycles? boolean
/usr/share/hypr/stubs/hl.meta.lua:1634:---@field workspace_center_on? integer|boolean
/usr/share/hypr/stubs/hl.meta.lua:1681:---@field warp_on_change_workspace? integer|boolean

```

---

## Assistant (Build · Muse Spark 1.3 Free · 1.8s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "grep -n \"WorkspaceRule\\|rename\\|workspace_rule\\|WorkspaceSelector\" /usr/share/hypr/stubs/hl.meta.lua | head -n 80; echo \"===\"; sed -n '600,750p' /usr/share/hypr/stubs/hl.meta.lua"
}
```

**Output:**
```
394:---@alias HL.WorkspaceSelector string|integer|HL.Workspace
505:---@field workspace? HL.WorkspaceSelector
603:---@class HL.WorkspaceRuleSpec
622:local __HL_WorkspaceRuleSpec = {}
815:---@class HL.WorkspaceRule
816:---@field is_enabled fun(self: HL.WorkspaceRule, ...): any
817:---@field set_enabled fun(self: HL.WorkspaceRule, ...): any
818:local __HL_WorkspaceRule = {}
851:---@field get_workspace fun(selector: HL.WorkspaceSelector): HL.Workspace|nil
852:---@field get_workspace_windows fun(workspace: HL.WorkspaceSelector): HL.Window[]
863:---@field workspace_rule fun(spec: HL.WorkspaceRuleSpec): HL.WorkspaceRule
935:---@field rename fun(...): HL.Dispatcher
===
---@field name? string
local __HL_WindowRuleSpec = {}

---@class HL.WorkspaceRuleSpec
---@field animation? string
---@field border_size? integer|boolean
---@field decorate? boolean
---@field default? boolean
---@field default_name? string
---@field enabled? boolean
---@field float_gaps? integer|HL.CssGap
---@field gaps_in? integer|HL.CssGap
---@field gaps_out? integer|HL.CssGap
---@field layout? string
---@field layout_opts? table<string, string|number|boolean>
---@field monitor? string
---@field no_border? boolean
---@field no_rounding? boolean
---@field no_shadow? boolean
---@field on_created_empty? string
---@field persistent? boolean
---@field workspace string
local __HL_WorkspaceRuleSpec = {}

---@class HL.EventSubscription
---@field is_active fun(self: HL.EventSubscription, ...): any
---@field remove fun(self: HL.EventSubscription, ...): any
local __HL_EventSubscription = {}

---@class HL.Group
---@field add fun(self: HL.Group, window: HL.Window, index?: integer)
---@field remove fun(self: HL.Group, window_or_index: HL.Window|integer)
---@field current HL.Window|nil
---@field current_index integer
---@field denied boolean
---@field locked boolean
---@field members HL.Window|table|nil
---@field size integer
local __HL_Group = {}

---@class HL.Keybind
---@field is_enabled fun(self: HL.Keybind, ...): any
---@field remove fun(self: HL.Keybind, ...): any
---@field set_enabled fun(self: HL.Keybind, ...): any
---@field unbind fun(self: HL.Keybind, ...): any
---@field allow_input_capture boolean|nil
---@field arg string
---@field auto_consuming boolean
---@field catchall boolean
---@field click boolean
---@field description any
---@field device_inclusive boolean
---@field devices any
---@field display_key string
---@field dont_inhibit boolean
---@field drag boolean
---@field enabled boolean
---@field handler string
---@field has_description boolean
---@field ignore_mods boolean
---@field key string
---@field keycode integer
---@field locked boolean
---@field long_press boolean
---@field modmask integer
---@field mouse boolean
---@field non_consuming boolean
---@field release boolean
---@field repeating boolean
---@field submap string
---@field submap_universal boolean
---@field transparent boolean
local __HL_Keybind = {}

---@class HL.LayerRule
---@field is_enabled fun(self: HL.LayerRule, ...): any
---@field set_enabled fun(self: HL.LayerRule, ...): any
local __HL_LayerRule = {}

---@class HL.LayerSurface
---@field above_fullscreen boolean|nil
---@field address string
---@field h integer
---@field interactivity integer
---@field layer integer
---@field mapped boolean
---@field monitor HL.Monitor|nil
---@field namespace string
---@field pid integer
---@field w integer
---@field x integer
---@field y integer
local __HL_LayerSurface = {}

---@class HL.Monitor
---@field set_special_workspace fun(self: HL.Monitor, ...): any
---@field set_workspace fun(self: HL.Monitor, ...): any
---@field active_special_workspace HL.Workspace|nil
---@field active_workspace HL.Workspace|nil
---@field available_modes boolean|integer|number|table
---@field cm string
---@field description string
---@field dpms_status boolean
---@field focused boolean
---@field height integer
---@field id integer
---@field is_mirror boolean
---@field mirrors HL.Monitor|table
---@field name string
---@field physical_height integer
---@field physical_width integer
---@field position integer|table
---@field refresh_rate number
---@field reserved number|table
---@field scale number
---@field serial string
---@field size integer|table
---@field transform integer
---@field vrr_active boolean
---@field width integer
---@field x integer
---@field y integer
local __HL_Monitor = {}

---@class HL.Notification
---@field dismiss fun(self: HL.Notification, ...): any
---@field get_color fun(self: HL.Notification, ...): any
---@field get_elapsed fun(self: HL.Notification, ...): any
---@field get_elapsed_since_creation fun(self: HL.Notification, ...): any
---@field get_font_size fun(self: HL.Notification, ...): any
---@field get_icon fun(self: HL.Notification, ...): any
---@field get_text fun(self: HL.Notification, ...): any
---@field get_timeout fun(self: HL.Notification, ...): any
---@field is_alive fun(self: HL.Notification, ...): any
---@field is_paused fun(self: HL.Notification, ...): any
---@field pause fun(self: HL.Notification, ...): any
---@field resume fun(self: HL.Notification, ...): any
---@field set_color fun(self: HL.Notification, ...): any
---@field set_font_size fun(self: HL.Notification, ...): any
---@field set_icon fun(self: HL.Notification, ...): any
---@field set_paused fun(self: HL.Notification, ...): any
---@field set_text fun(self: HL.Notification, ...): any
---@field set_timeout fun(self: HL.Notification, ...): any
local __HL_Notification = {}

---@class HL.Timer
---@field is_enabled fun(self: HL.Timer, ...): any
---@field set_enabled fun(self: HL.Timer, ...): any
---@field set_timeout fun(self: HL.Timer, ...): any
local __HL_Timer = {}


```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.6s)

_Thinking:_



**Tool: webfetch**

**Input:**
```json
{
  "format": "markdown",
  "url": "https://wiki.hypr.land/Configuring/Workspace-Rules/"
}
```

**Error:**
```
StatusCode: non 2xx status code (404 GET https://wiki.hypr.land/Configuring/Workspace-Rules/)
```

---

## Assistant (Build · Muse Spark 1.3 Free · 3.9s)

_Thinking:_



**Tool: websearch**

**Input:**
```json
{
  "query": "Hyprland workspace rules default_name persistent 2026"
}
```

**Output:**
```
Title: Workspace Rules - Hyprland Wiki
URL: https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
Published: 2026-08-26T00:00:00.000Z
Author: N/A
Highlights:
Since Hyprland 0.55, hyprlang is deprecated in favor of lua. You can set workspace rules to achieve workspace-specific behaviors. For
...
or gaps. For layout-specific rules, see the specific layout page. For example:
 Master Layout->Workspace Rules. Syntax 
 hl.workspace_rule ( workspace, rule1, rule2,...) WORKSPACE is a valid workspace identifier (see
 Dispatchers->Workspaces). This field is
...
fullscreen state sent to the window. Only matches workspaces with covering FS windows. Rules 
 Rule Description type monitor Binds a workspace to a monitor. See syntax and Monitors. string default Whether this workspace should be the default workspace for the given monitor bool gaps_in Set the gaps between windows (equivalent to General->gaps_in) css_gaps gaps_out Set the gaps between windows and monitor edges (equivalent to General->gaps_out) css_gaps float_gaps Set the gaps for floating windows (equivalent to General->float_gaps) css_gaps border_size Set the border size around windows (equivalent to General->border_size) int no_border Whether to disable borders bool no_shadow Whether to disable shadows bool no_rounding Whether to disable rounded windows bool decorate Whether to draw window decorations or not bool persistent Keep this workspace alive even if empty and inactive bool on_created_empty A command to be executed once a workspace is created empty (i.e. not created by moving a window to it). See the command syntax string default_name A default name for the workspace. string layout The layout to use for this workspace. string animation The animation style to use for this workspace. string layout_opts A table of layout-specific options for this workspace. Keys and values depend on the layout. table Examples 
 hl.workspace_rule ({ workspace = &#34;3", no_rounding = true, decorate = false}) 
 hl.workspace_rule ({ workspace = "name:coding", no_rounding = true, decorate = false, gaps_in = 0, gaps_out = 0, no_border = true, monitor = "DP-1"}) 
 hl.workspace_rule ({ workspace = "8", border_size = 8}) 
 hl.workspace_rule ({ workspace = "name:Hello", monitor = "DP-1", default = true}) 
 hl.workspace_rule ({ workspace = "name:gaming", monitor = "desc:Chimei Innolux Corporation 0x150C", default = true}) 
 hl.workspace_rule ({ workspace = "5", on_created_empty = "[float] firefox"}) 
 hl.workspace_rule ({ workspace = "special:scratchpad", on_created_empty = "foot"}) 
 hl.workspace_rule ({ workspace = "15", animation = "slidevert", default_name = "slider"}) Smart gaps 
 To replicate “smart gaps” / “no gaps when only” from other WMs/Compositors, use this bad boy: hl.workspace_rule ({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0}) 
 hl.workspace_rule ({ workspace = "f[1]", gaps_out = 0, gaps_in = 0}) 
 hl.window_rule ({ match = { float = false, workspace = "w[tv1]"}, border_size = 0}) 
 hl.window_rule ({ match = { float = false, workspace = "w[tv1]"}, rounding = 0}) 
 hl.window_rule ({ match = { float = false, workspace = "f[1]"}, border_size = 0}) 
 hl.window_rule ({ match = { float = false, workspace = "f[1]"}, rounding = 0}) Smart gaps (ignoring special workspaces) 
 You can combine workspace selectors for more fine-grained control, for example, to ignore special workspaces: hl.workspace_rule ({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0}) 
 hl.workspace_rule ({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0}) 
 hl.window_rule ({ match = { float = false, workspace = "w[tv1]s[false]"}, border_size = 0}) 
 hl.window_rule ({ match = { float = false, workspace = "w[tv1]s[false]"}, rounding = 0}) 
 hl.window_rule ({ match = { float = false, workspace = "f[1]s[false]"}, border_size = 0}) 
 hl.window_rule ({ match = { float = false, workspace = "f[1]s[false]"}, rounding = 0}) Per-workspace layouts 
 Use workspace rules to set per-workspace layouts: hl.workspace_rule ({ workspace = "2", layout = "scrolling"}) Last updated on August 26, 2026 Window Rules Autostart

---

Title: Workspace Rules | hyprwm/hyprland-wiki | DeepWiki
URL: https://deepwiki.com/hyprwm/hyprland-wiki/3.5-workspace-rules
Published: 2026-04-28T00:00:00.000Z
Author: N/A
Highlights:
Workspace rules allow you to define specific behaviors, visual properties, and default assignments for workspaces. These rules are configured using the Lua-based configuration system introduced in Hyprland v0.55 via the `hl.workspace_rule()` function.
...
| Rule | Description | Type |
| --- | --- | --- |
| `monitor` | Binds a workspace to a specific monitor. | string |
| `default` | Makes this the default workspace for the assigned monitor. | bool |
| `gaps_in` | Inner gaps between windows. | int |
| `gaps_out` | Outer gaps between windows and monitor edges. | int |
| `border_size` | Size of window borders on this workspace. | int |
| `no_border` | Disables borders for all windows on this workspace. | bool |
| `no_shadow` | Disables shadows for windows on this workspace. | bool |
| `no_rounding` | Disables rounded corners. | bool |
| `decorate` | Whether to draw window decorations (titles, etc). | bool |
| `persistent` | Workspace stays alive even when empty and inactive. | bool |
| `on_created_empty` | Command to execute when the workspace is first created empty. | string |
| `default_name` | Assigns a default name to the workspace. | string |
| `layout` | Sets a specific layout (e.g., "master", "dwindle") for this workspace. | string |
| `animation` | Sets a specific animation style for the workspace. | string |

---

Title: Naming workspaces with rules - General - Hyprland Forum
URL: https://forum.hypr.land/t/naming-workspaces-with-rules/2107
Published: 2026-08-21T00:00:00.000Z
Author: N/A
Highlights:
I am trying to set persistent workspace names in my bar. Here is the Hyprland doc for setting workspace rules. Based on this doc, I made these two attempts of which both don’t change the names of my workspaces:
...
```
hl.workspace_rule({ workspace = "1", default_name = "slider" })
hl.workspace_rule({ workspace = "2", "name:Hello"})

```
...
What should I really be using name a workspace?
...
Why don’t you think it’s working? I just ran a test, created a workspace and window rule:
...
```
hl.workspace_rule({ workspace = "21", monitor = "DP-3", default_name = "testing" })
hl.window_rule({
	name = "testing",
	match = { class = "org.kde.dolphin" },
	workspace = 21,
})

```
...
name = testing
...
`hl.workspace_rule({ workspace = "1", default_name = "slider" })`
...
For me this also doesn’t work. The key seems to be using a`number` for the workspace, rather than a`string` So:
...
```
hl.workspace_rule({ workspace = 1, default_name = "slider" })

```

---

Title: Workspace Rules - Hyprland Wiki
URL: https://wiki.hyprland.org/0.47.0/Configuring/Workspace-Rules/
Published: N/A
Author: N/A
Highlights:
| Rule | Description | type |
| --- | --- | --- |
| monitor:[m] | Binds a workspace to a monitor. See syntax and Monitors. | string |
| default:[b] | Whether this workspace should be the default workspace for the given monitor | bool |
| gapsin:[x] | Set the gaps between windows (equivalent to General->gaps_in) | int |
| gapsout:[x] | Set the gaps between windows and monitor edges (equivalent to General->gaps_out) | int |
| bordersize:[x] | Set the border size around windows (equivalent to General->border_size) | int |
| border:[b] | Whether to draw borders or not | bool |
| shadow:[b] | Whether to draw shadows or not | bool |
| rounding:[b] | Whether to draw rounded windows or not | bool |
| decorate:[b] | Whether to draw window decorations or not | bool |
| persistent:[b] | Keep this workspace alive even if empty and inactive | bool |
| on-created-empty:[c] | A command to be executed once a workspace is created empty (i.e. not created by moving a window to it). See the command syntax | string |
| defaultName:[s] | A default name for the workspace. | string |
...
```
workspace = 3, rounding:false, decorate:false
workspace = name:coding, rounding:false, decorate:false, gapsin:0, gapsout:0, border:false, monitor:DP-1
workspace = 8,bordersize:8
workspace = name:Hello, monitor:DP-1, default:true
workspace = name:gaming, monitor:desc:Chimei Innolux Corporation 0x150C, default:true
workspace = 5, on-created-empty:[float] firefox
workspace = special:scratchpad, on-created-empty:foot

---

Title: src/desktop/Workspace.cpp
URL: https://github.com/hyprwm/Hyprland/blob/b6633c41/src/desktop/Workspace.cpp
Published: N/A
Author: N/A
Highlights:
void CWorkspace::init(PHLWORKSPACE self) {
 m_self = self;

 g_pAnimationManager->createAnimation(
 Vector2D(0, 0), m_renderOffset, Config::animationTree()->getAnimationPropertyConfig(m_isSpecialWorkspace ? "specialWorkspaceIn" : "workspacesIn"), self, AVARDAMAGE_ENTIRE);
 g_pAnimationManager->createAnimation(1.f, m_alpha, Config::animationTree()->getAnimationPropertyConfig(m_isSpecialWorkspace ? "specialWorkspaceIn" : "workspacesIn"), self,
 AVARDAMAGE_ENTIRE);

 const auto RULEFORTHIS = Config::workspaceRuleMgr()->getWorkspaceRuleFor(self).value_or(Config::CWorkspaceRule{});
 if (RULEFORTHIS.m_defaultName.has_value())
 m_name = RULEFORTHIS.m_defaultName.value();
 if (RULEFORTHIS.m_animationStyle.has_value())
 m_animationStyle = RULEFORTHIS.m_animationStyle.value();

 m_focusedWindowHook = Event::bus()->m_events.window.close.listen([this](PHLWINDOW pWindow) {
 if (pWindow == m_lastFocusedWindow.lock())
 m_lastFocusedWindow.reset();
 });

 m_space = Layout::CSpace::create(m_self.lock());
 m_space->setAlgorithmProvider(Layout::Supplementary::algoMatcher()->createAlgorithmForWorkspace(m_self.lock()));

 m_inert = false;

 const auto WORKSPACERULE = Config::workspaceRuleMgr()->getWorkspaceRuleFor(self).value_or(Config::CWorkspaceRule{});
 setPersistent(WORKSPACERULE.m_isPersistent.value_or(false));

 if (self->m_wasCreatedEmpty)
 if (auto cmd = WORKSPACERULE.m_onCreatedEmptyRunCmd)
 Config::Supplementary::executor()->spawnWithRules(*cmd, self);

 g_pEventManager->postEvent({.event = "createworkspace", .data = m_name});
 g_pEventManager->postEvent({.event = "createworkspacev2", .data = std::format("{},{}", m_id, m_name)});
 Event::bus()->m_events.workspace.created.emit(self);
...
return false;
...
;
 }

 prop = prop
...
() -
...
);

 const
...
void CWorkspace::rename(const std::string& name) {
 if (g_pCompositor->isWorkspaceSpecial(m_id))
 return;

 Log::logger->log(Log::DEBUG, "CWorkspace::rename: Renaming workspace {} to '{}'", m_id, name);
 m_name = name;

 const auto WORKSPACERULE = Config::workspaceRuleMgr()->getWorkspaceRuleFor(m_self.lock()).value_or(Config::CWorkspaceRule{});
 setPersistent(WORKSPACERULE.m_isPersistent.value_or(false));

 if (WORKSPACERULE.m_isPersistent.value_or(false))
 g_pCompositor->ensurePersistentWorkspacesPresent(std::vector {WORKSPACERULE}, m_self.lock());

 g_pEventManager->postEvent({.event = "renameworkspace", .data = std::to_string(m_id) + "," + m_name});
 m_events.renamed.emit();
}
...
void CWorkspace::setPersistent(bool persistent) {
 if (m_persistent == persistent)
 return;

 m_persistent = persistent;

 if (persistent)
 m_selfPersistent = m_self.lock();
 else
 m_selfPersistent.reset();
}
...
bool CWorkspace::isPersistent() {
 return m_persistent;
}

---

Title: Duplication of named, persistent and default workspaces · hyprwm Hyprland · Discussion #12084 · GitHub
URL: https://github.com/hyprwm/Hyprland/discussions/12084
Published: N/A
Author: hyprwm
Highlights:
## Describe the bug
...
When a workspace has a`name`, and both`persistent` and`default` are set, the workspace gets duplicated.
...
```
workspace = name:R1, monitor:$MONITOR_R,persistent:true,default:true
workspace = name:R2, monitor:$MONITOR_R,persistent:true

```
...
There are two`R1` workspaces below:
...
```
workspace ID -1339 (R1) on monitor DP-3:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55716e13fc10
	lastwindowtitle: ~
	ispersistent: 0

workspace ID 1 (1) on monitor HDMI-A-1:
	monitorID: 1
	windows: 0
	hasfullscreen: 0
	lastwindow: 0x0
	lastwindowtitle: 
	ispersistent: 0

workspace ID -1337 (R1) on monitor DP-3:
	monitorID: 0
	windows: 0
	hasfullscreen: 0
	lastwindow: 0x0
	lastwindowtitle: 
	ispersistent: 1

workspace ID -1338 (R2) on monitor DP-3:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55716e18cd10
	lastwindowtitle: hyprctl workspaces > /tmp/workspaces
	ispersistent: 1

```
...
I just checked git (da04afa) and it does happen there too. Any ideas?

---

Title: Workspaces and Desktop State | hyprwm/Hyprland | DeepWiki
URL: https://deepwiki.com/hyprwm/Hyprland/5.6-workspaces-and-desktop-state
Published: 2026-08-08T00:00:00.000Z
Author: N/A
Highlights:
2. Applies Rules: Fetches initial rules from `Config::workspaceRuleMgr()` to set default names, animation styles, and persistence. src/desktop/Workspace.cpp 49-53
...
4. Persistence: Sets the persistent flag based on workspace rules. src/desktop/Workspace.cpp 65-66
...
A workspace can be "persistent," meaning it remains in memory even when it has no windows. This is controlled by the `setPersistent(bool)` method and `m_selfPersistent` shared pointer which keeps the reference count above zero. src/desktop/Workspace.hpp 89-90 src/desktop/Workspace.cpp 72-73
...
Hyprland uses a selector system to match workspaces in rules and dispatchers. `CWorkspace::matchesStaticSelector` implements this logic, supporting:
...
- ID/Name: `1`, `name:work`, `special:scratchpad`. src/desktop/Workspace.cpp 126-137
- Properties: `r[1-5]` (range), `s[bool]` (special), `n[name]`, `m[monitor]`, `w[count]` (window count), and `f[state]` (fullscreen state). src/desktop/Workspace.cpp 162-180

---

Title: Persistent workspaces are not always kept on the correct (specified) monitor · Issue #9947 · hyprwm/Hyprland
URL: https://github.com/hyprwm/Hyprland/issues/9947
Published: 2025-04-06T00:00:00.000Z
Author: vaxerski
Highlights:
# Persistent workspaces are
...
kept on the correct (specified) monitor
...
More information in the discussion, but in some specific cases, workspaces marked persistent do not stay on their assigned monitor (provided they have one.
...
handleWorkspaceRules
...
src/config
...
ConfigManager.
...
get the `id
...
[getWorkspaceIDName
...
hyprwm/
...
5e5
...
/src/
...
Because they are named (e.g. `name:L1`) the `id
...
comes from [CCompositor::getNextAvailableNamedWorkspace](https://github.com/hyprwm/Hyprland/blob/e96b8ce4cc5e5856b6da653f1d92af856b5e72c9/src/
...
Functions.cpp#L1
...
5C1
...
-L11
...
> 4. Since no workspace was created yet, they all get the same (`-1337`) id
...
> 5. Then [CCompositor::ensurePersistentWorkspacesPresent](https://github.com/hyprwm/Hyprland/blob/e96b8ce4cc5e5856b6da653f1d92af856b5e72c9/src/Compositor.cpp#L3080) (through `CConfigManager::ensurePersistentWorkspacesPresent`) creates all the workspaces
...
> 6. Since their `id`s are not set to `WORKSPACE_INVALID`, they (`-1337`) are used to fetch the workspace and move it to the correct monitor, but this results in all moves working on the same workspace.
...
> Explicitly setting the `wsRule.workspaceId` to `WORKSPACE_INVALID` in [CConfigManager::handleWorkspaceRules](https://github.com/hyprwm/Hyprland/blob/e96b8ce4cc5e5856b6da653f1d92af856b5e72c9/src/config/ConfigManager.cpp#L2725) solves the problem, but > I have no clue how to fix this correctly.
...
> I just checked `v0.51.0` and it looks like all workspaces are on the correct monitors, but when both `persistent:true` and `default:true` are specified, some workspaces are duplicated.
> 
> Using this config:
> 
> ```
> $MONITOR_L = HDMI-A-1
> $MONITOR_R = DP-3
> 
> monitor = $MONITOR_L, 1280x1024@75, 0x0, 1
> monitor = $MONITOR_R, 1920x1080@60, 1280x0, 1
> 
> workspace = name:L1, monitor:$MONITOR_L,persistent:true,default:true
> workspace = name:L2, monitor:$MONITOR_L,persistent:true,default:true
> 
> workspace = name:R1, monitor:$MONITOR_R,persistent:true,default:true
> workspace = name:R2, monitor:$MONITOR_R,persistent:true,default:true
> 
> bind = SUPER, 1, workspace,name:L1
> bind = SUPER, 2, workspace,name:L2
> 
> bind = SUPER SHIFT, 1, workspace,name:R1
> bind = SUPER SHIFT, 2, workspace,name:R2
> 
> bind = SUPER, M, exit
> bind = SUPER, T, exec,kitty
> ```
> 
> Starting `Hyprland` and going through every workspace opening a terminal on each results in this `hyprctl workspaces` output:
> 
> ```
> workspace ID -1341 (R1) on monitor DP-3:
> monitorID: 0
> windows: 1
> hasfullscreen: 0
> lastwindow: 0x55c28dca5320
> lastwindowtitle: ~/.config/hypr
> ispersistent: 0
> 
> workspace ID -1342 (L1) on monitor HDMI-A-1:
> monitorID: 1
> windows: 1
> hasfullscreen: 0
> lastwindow: 0x55c28dc1cf80
> lastwindowtitle: ~/.config/hypr
> ispersistent: 0
> 
> workspace ID -1337 (L1) on monitor HDMI-A-1:
> monitorID: 1
> windows: 0
> hasfullscreen: 0
> lastwindow: 0x0
> lastwindowtitle: 
> ispersistent: 1
> 
> workspace ID -1338 (L2) on monitor HDMI-A-1:
> monitorID: 1
> windows: 1
> hasfullscreen: 0
> lastwindow: 0x55c28dc672f0
> lastwindowtitle: ~/.config/hypr
> ispersistent: 1
> 
> workspace ID -1339 (R1) on monitor DP-3:
> monitorID: 0
> windows: 0
> hasfullscreen: 0
> lastwindow: 0x0
> lastwindowtitle: 
> ispersistent: 1
> 
> workspace ID -1340 (R2) on monitor DP-3:
> monitorID: 0
> windows: 1
> hasfullscreen: 0
> lastwindow: 0x55c28dcc2700
> lastwindowtitle: hyprctl workspaces > /tmp/workspaces
> ispersistent: 1
> ```
> 
> Both `R1` and `L1` are duplicated. That being said I think this is a different issue, should I open a new discussion?
...
> With IDs instead of names there is no duplication
> 
> ```
> $MONITOR_L = HDMI-A-1
> $MONITOR_R = DP-3
> 
> monitor = $MONITOR_L, 1280x1024@75, 0x0, 1
> monitor = $MONITOR_R, 1920x1080@60, 1280x0, 1
> 
> workspace = 1, monitor:$MONITOR_L,persistent:true,default:true
> workspace = 2, monitor:$MONITOR_L,persistent:true,default:true
> 
> workspace = 11, monitor:$MONITOR_R,persistent:true,default:true
> workspace = 12, monitor:$MONITOR_R,persistent:true,default:true
> 
> bind = SUPER, 1, workspace,1
> bind = SUPER, 2, workspace,2
> 
> bind = SUPER SHIFT, 1, workspace,11
> bind = SUPER SHIFT, 2, workspace,12
> 
> bind = SUPER, M, exit
> bind = SUPER, T, exec,kitty
> ```
> 
> ```
> workspace ID 11 (11) on monitor DP-3:
> monitorID: 0
> windows: 1
> hasfullscreen: 0
> lastwindow: 0x55970d65aa70
> lastwindowtitle: ~/.config/hypr
> ispersistent: 1
> 
> workspace ID 1 (1) on monitor HDMI-A-1:
> monitorID: 1
> windows: 1
> hasfullscreen: 0
> lastwindow: 0x55970d5d2c70
> lastwindowtitle: ~/.config/hypr
> ispersistent: 1
> 
> workspace ID 2 (2) on monitor HDMI-A-1:
> monitorID: 1
> windows: 1
> hasfullscreen: 0
> lastwindow: 0x55970d61ddb0
> lastwindowtitle: ~/.config/hypr
> ispersistent: 1
> 
> workspace ID 12 (12) on monitor DP-3:
> monitorID: 0
> windows: 1
> hasfullscreen: 0
> lastwindow: 0x55970d677cd0
> lastwindowtitle: hyprctl workspaces > /tmp/workspaces
> ispersistent: 1
> ```
...
> I have opened a new discussion about the duplicated workspaces: #12084. The problem from this issue is resolved, so I think it can be closed.
```

---

## Assistant (Build · Muse Spark 1.3 Free · 3.7s)

_Thinking:_



Found the right approach — preparing to set workspace 1's name to "code".

**Tool: bash**

**Input:**
```json
{
  "command": "hyprctl version 2>&1 | head -n 20; echo \"===\"; hyprctl workspacerules 2>&1; echo \"===\"; hyprctl dispatch renameworkspace 1 code 2>&1; hyprctl workspaces 2>&1 | head -n 30"
}
```

**Output:**
```
Hyprland 0.56.2 built from branch v0.56.2 at commit efb50993780079460b0cbed1363e2166a2de1d9f clean ([gha] Nix: update inputs).
Date: Wed Aug 5 14:13:21 2026
Tag: v0.56.2, commits: 7661

Libraries:
Hyprgraphics: built against 0.5.1, system has 0.5.1
Hyprutils: built against 0.14.1, system has 0.14.2
Hyprcursor: built against 0.1.13, system has 0.1.13
Hyprlang: built against 0.6.8, system has 0.6.8
Aquamarine: built against 0.15.0, system has 0.15.0

Version ABI string: efb50993780079460b0cbed1363e2166a2de1d9f_aq_0.15_hu_0.14_hg_0.5_hc_0.1_hlg_0.6
no flags were set

===
Workspace rule 1:
	enabled: true
	monitor: <unset>
	default: <unset>
	persistent: <unset>
	gapsIn: <unset>
	gapsOut: <unset>
	borderSize: <unset>
	border: <unset>
	rounding: <unset>
	decorate: <unset>
	shadow: <unset>
	defaultName: <unset>
	onCreatedEmpty: <unset>

Workspace rule 3:
	enabled: true
	monitor: <unset>
	default: <unset>
	persistent: <unset>
	gapsIn: <unset>
	gapsOut: <unset>
	borderSize: <unset>
	border: <unset>
	rounding: <unset>
	decorate: <unset>
	shadow: <unset>
	defaultName: <unset>
	onCreatedEmpty: <unset>


===
error: [string "return hl.dispatch(renameworkspace 1 code)"]:1: ')' expected near '1'

 → Note: dispatch in lua is a shorthand for hl.dispatch(...), your syntax might need to be updated.
workspace ID 10 (10) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b1823c1e60
	lastwindowtitle: 5 MCP servers every Claude Code user needs right now. - YouTube
	ispersistent: 0
	tiledLayout: dwindle

workspace ID 1 (1) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b183e478e0
	lastwindowtitle: omarchy: ~
	ispersistent: 0
	tiledLayout: dwindle



```

---

## Assistant (Build · Muse Spark 1.3 Free · 4.7s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "grep -rn \"workspace_rule\\|workspace-rule\\|workspacerule\" /usr/share/omarchy/ 2>&1 | head -n 30; echo \"===\"; hyprctl workspacerules -j 2>&1 | head -n 80; echo \"===\"; hyprctl dispatch --help 2>&1 | tr ';' '\\n' | grep -i rename -A2 -B2 || hyprctl dispatch renameworkspace --help 2>&1 | head"
}
```

**Output:**
```
===
[{
    "workspaceString": "1",
    "enabled": true
},{
    "workspaceString": "3",
    "enabled": true
}]
===
usage: hyprctl [flags] <command> [args...|--help]

commands:
    activewindow        → Gets the active window name and its properties
    activeworkspace     → Gets the active workspace and its properties
    animations          → Gets the current config'd info about animations
                          and beziers
    binds               → Lists all registered binds
    clients             → Lists all windows with their properties
    configerrors        → Lists all current config parsing errors

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.2s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "grep -rn \"workspace\" ~/.local/state/omarchy/ 2>&1 | head -n 30; echo \"===\"; ls ~/.local/state/omarchy/ 2>&1; echo \"===\"; cat ~/.config/hypr/hyprland.conf 2>&1 | head -n 100"
}
```

**Output:**
```
/home/mb/.local/state/omarchy/current/theme/obsidian.css:88:.workspace-leaf.mod-active .workspace-leaf-header-title {
/home/mb/.local/state/omarchy/workspace-layouts/3.lua:1:hl.workspace_rule({ workspace = "3", layout = "dwindle" })
/home/mb/.local/state/omarchy/workspace-layouts/1.lua:1:hl.workspace_rule({ workspace = "1", layout = "dwindle" })
/home/mb/.local/state/omarchy/clipboard-history.json:8:    "text": "omarchy-shell workspace-layout json | jq '.workspaces[]'\n"
/home/mb/.local/state/omarchy/clipboard-history.json:12:    "text": "omarchy plugin add https://github.com/jankeesvw/omarchy-workspace-name.git --enable"
===
agents
clipboard-history.json
clipboard-images
current
done
indicators
migrations
monitor-scaling.log
notifications
notifications.json
obsidian-vaults
toggles
windows
workspace-layouts
===
# Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/

# Use defaults Omarchy defaults (but don't edit these directly!)
source = ~/.local/share/omarchy/default/hypr/autostart.conf
source = ~/.local/share/omarchy/default/hypr/bindings/media.conf
source = ~/.local/share/omarchy/default/hypr/bindings/clipboard.conf
source = ~/.local/share/omarchy/default/hypr/bindings/tiling-v2.conf
source = ~/.local/share/omarchy/default/hypr/bindings/utilities.conf
source = ~/.local/share/omarchy/default/hypr/envs.conf
source = ~/.local/share/omarchy/default/hypr/looknfeel.conf
source = ~/.local/share/omarchy/default/hypr/input.conf
source = ~/.local/share/omarchy/default/hypr/windows.conf
source = ~/.local/state/omarchy/current/theme/hyprland.conf

# Change your own setup in these files (and overwrite any settings from defaults!)
source = ~/.config/hypr/monitors.conf
source = ~/.config/hypr/input.conf
source = ~/.config/hypr/bindings.conf
source = ~/.config/hypr/looknfeel.conf
source = ~/.config/hypr/autostart.conf

# Toggle config flags dynamically
source = ~/.local/state/omarchy/toggles/hypr/*.conf

# Add any other personal Hyprland configuration below
windowrule = workspace 20, match:class qemu

```

---

## Assistant (Build · Muse Spark 1.3 Free · 4.3s)

_Thinking:_



**Tool: webfetch**

**Input:**
```json
{
  "format": "markdown",
  "url": "https://wiki.hypr.land/Configuring/Basics/Dispatchers/"
}
```

**Output:**
```
<!doctype html><html lang=en dir=ltr><head><meta charset=utf-8><meta name=viewport content="width=device-width,initial-scale=1"><meta name=robots content="index, follow"><link rel="icon shortcut" href=/favicon.ico sizes=32x32><link rel=icon href=/favicon.svg type=image/svg+xml id=favicon-svg><link rel=icon href=/favicon-16x16.png type=image/png sizes=16x16><link rel=icon href=/favicon-32x32.png type=image/png sizes=32x32><link rel=apple-touch-icon href=/apple-touch-icon.png sizes=180x180><link fetchpriority=low href=/site.webmanifest rel=manifest><title>Dispatchers – Hyprland Wiki</title><meta name=description content=" Note
Looking for the old hyprlang syntax? Check the 0.54 wiki pages. Since Hyprland 0.55, hyprlang is deprecated in favor of lua.
Please keep in mind some layout-specific dispatchers will be listed in the layout pages (See the sidebar)."><link rel=canonical href=https://wiki.hypr.land/Configuring/Basics/Dispatchers/ itemprop=url><meta property="og:title" content="Dispatchers"><meta property="og:description" content="
    
      
  Note

  
    Looking for the old hyprlang syntax? Check the 0.54 wiki pages.
Since Hyprland 0.55, hyprlang is deprecated in favor of lua.
  

Please keep in mind some layout-specific dispatchers will be listed in the
layout pages (See the sidebar).
    
  "><meta property="og:type" content="
    article
  "><meta property="og:url" content="https://wiki.hypr.land/Configuring/Basics/Dispatchers/"><meta property="article:section" content="configuring"><meta property="article:modified_time" content="2026-08-26T14:50:40+02:00"><meta itemprop=name content="Dispatchers"><meta itemprop=description content="Note
Looking for the old hyprlang syntax? Check the 0.54 wiki pages. Since Hyprland 0.55, hyprlang is deprecated in favor of lua.
Please keep in mind some layout-specific dispatchers will be listed in the layout pages (See the sidebar)."><meta itemprop=dateModified content="2026-08-26T14:50:40+02:00"><meta itemprop=wordCount content="1792"><meta name=twitter:card content="summary"><meta name=twitter:title content="Dispatchers"><meta name=twitter:description content="Note
Looking for the old hyprlang syntax? Check the 0.54 wiki pages. Since Hyprland 0.55, hyprlang is deprecated in favor of lua.
Please keep in mind some layout-specific dispatchers will be listed in the layout pages (See the sidebar)."><link rel=preload href=/css/compiled/main.min.48bece43a96beb5f3e4489ccf2c9e4e8a7d124afbab37a432b43ff37ce76524b.css as=style integrity="sha256-SL7OQ6lr618+RInM8snk6KfRJK+6s3pDK0P/N852Uks="><link href=/css/compiled/main.min.48bece43a96beb5f3e4489ccf2c9e4e8a7d124afbab37a432b43ff37ce76524b.css rel=stylesheet integrity="sha256-SL7OQ6lr618+RInM8snk6KfRJK+6s3pDK0P/N852Uks="><script src=/js/main-head.min.94da6f95b126542222dab3a6e07ffefe1aaf63ec3ca555e827b58b80e7d3f0b7.js integrity="sha256-lNpvlbEmVCIi2rOm4H/+/hqvY+w8pVXoJ7WLgOfT8Lc="></script><meta name=keywords content="hyprland,wiki,hypr,land"></head><body><a href=#content class="hx:sr-only hx:focus-visible:not-sr-only hx:focus-visible:fixed hx:focus-visible:z-50 hx:focus-visible:top-2 hx:focus-visible:left-2 hx:focus-visible:bg-primary-500 hx:focus-visible:text-white hx:focus-visible:px-4 hx:focus-visible:py-2 hx:focus-visible:rounded-md hx:focus-visible:text-sm hx:focus-visible:font-medium">Skip to content</a><div class="hextra-nav-container hx:sticky hx:top-0 hx:z-20 hx:w-full hx:bg-transparent hx:print:hidden"><div class="hextra-nav-container-blur hx:pointer-events-none hx:absolute hx:z-[-1] hx:h-full hx:w-full hx:bg-white hx:dark:bg-dark hx:shadow-[0_2px_4px_rgba(0,0,0,.02),0_1px_0_rgba(0,0,0,.06)] hx:contrast-more:shadow-[0_0_0_1px_#000] hx:dark:shadow-[0_-1px_0_rgba(255,255,255,.1)_inset] hx:contrast-more:dark:shadow-[0_0_0_1px_#fff]"></div><nav class="hextra-max-navbar-width hx:mx-auto hx:flex hx:items-center hx:justify-end hx:gap-2 hx:h-16 hx:px-6"><a class="hx:flex hx:items-center hx:hover:opacity-75 hx:rtl:ml-auto" href=/><img class="hx:mr-2 hx:block hx:dark:hidden" src=/favicon.svg alt=Logo height=20 width=20>
<img class="hx:mr-2 hx:hidden hx:dark:block" src=/favicon-dark.svg alt="Dark Logo" height=20 width=20>
<span class="hx:mr-2 hx:font-extrabold hx:inline hx:select-none" title="Hyprland Wiki">Hyprland Wiki</span>
</a><a href=/version-selector/ rel=noreferer class="hx:flex hx:items-center hx:hover:opacity-75 hx:ltr:mr-auto hx:rtl:ml-auto"><span class=hx:text-center>Latest git</span>
</a><a title href=/ class="hx:text-sm hx:contrast-more:text-gray-700 hx:contrast-more:dark:text-gray-100 hx:relative hx:-ml-2 hx:hidden hx:whitespace-nowrap hx:p-2 hx:md:inline-flex hx:items-center hx:gap-1 hx:text-gray-600 hx:hover:text-gray-800 hx:dark:text-gray-400 hx:dark:hover:text-gray-200"><span class=hx:text-center>Wiki</span>
</a><a title href=https://hypr.land/ target=_blank rel=noreferrer class="hx:text-sm hx:contrast-more:text-gray-700 hx:contrast-more:dark:text-gray-100 hx:relative hx:-ml-2 hx:hidden hx:whitespace-nowrap hx:p-2 hx:md:inline-flex hx:items-center hx:gap-1 hx:text-gray-600 hx:hover:text-gray-800 hx:dark:text-gray-400 hx:dark:hover:text-gray-200"><span class=hx:text-center>Home</span>
</a><a title href=https://hypr.land/hall_of_fame target=_blank rel=noreferrer class="hx:text-sm hx:contrast-more:text-gray-700 hx:contrast-more:dark:text-gray-100 hx:relative hx:-ml-2 hx:hidden hx:whitespace-nowrap hx:p-2 hx:md:inline-flex hx:items-center hx:gap-1 hx:text-gray-600 hx:hover:text-gray-800 hx:dark:text-gray-400 hx:dark:hover:text-gray-200"><span class=hx:text-center>Showcase</span>
</a><a title href=https://hypr.land/news target=_blank rel=noreferrer class="hx:text-sm hx:contrast-more:text-gray-700 hx:contrast-more:dark:text-gray-100 hx:relative hx:-ml-2 hx:hidden hx:whitespace-nowrap hx:p-2 hx:md:inline-flex hx:items-center hx:gap-1 hx:text-gray-600 hx:hover:text-gray-800 hx:dark:text-gray-400 hx:dark:hover:text-gray-200"><span class=hx:text-center>News</span></a><div class="hextra-search-wrapper hx:relative hx:md:w-64"><div class="hx:relative hx:flex hx:items-center hx:text-gray-900 hx:contrast-more:text-gray-800 hx:dark:text-gray-300 hx:contrast-more:dark:text-gray-300"><input placeholder=Search... aria-label=Search... class="hextra-search-input hx:hextra-focus-visible hx:block hx:w-full hx:appearance-none hx:rounded-lg hx:px-3 hx:py-2 hx:transition-colors hx:text-base hx:leading-tight hx:md:text-sm hx:bg-black/[.05] hx:dark:bg-gray-50/10 hx:focus-visible:bg-white hx:dark:focus-visible:bg-dark hx:placeholder:text-gray-500 hx:dark:placeholder:text-gray-400 hx:contrast-more:border hx:contrast-more:border-current" type=search autocomplete=off spellcheck=false>
<kbd class="hx:absolute hx:my-1.5 hx:select-none hx:ltr:right-1.5 hx:rtl:left-1.5 hx:h-5 hx:rounded-sm hx:bg-white hx:px-1.5 hx:font-mono hx:text-[10px] hx:font-medium hx:text-gray-500 hx:border hx:border-gray-200 hx:dark:border-gray-100/20 hx:dark:bg-dark/50 hx:contrast-more:border-current hx:contrast-more:text-current hx:contrast-more:dark:border-current hx:items-center hx:gap-1 hx:transition-opacity hx:pointer-events-none hx:hidden hx:sm:flex">CTRL K</kbd></div><div><ul class="hextra-search-results hextra-scrollbar hx:hidden hx:border hx:border-gray-200 hx:bg-white hx:text-gray-100 hx:dark:border-neutral-800 hx:dark:bg-neutral-900 hx:absolute hx:top-full hx:z-20 hx:mt-2 hx:overflow-auto hx:overscroll-contain hx:rounded-xl hx:py-2.5 hx:shadow-xl hx:max-h-[min(calc(50vh-11rem-env(safe-area-inset-bottom)),400px)] hx:md:max-h-[min(calc(100vh-5rem-env(safe-area-inset-bottom)),400px)] hx:inset-x-0 hx:ltr:md:left-auto hx:rtl:md:right-auto hx:contrast-more:border hx:contrast-more:border-gray-900 hx:contrast-more:dark:border-gray-50 hx:w-screen hx:min-h-[100px] hx:max-w-[min(calc(100vw-2rem),calc(100%+20rem))]" aria-label="Search results" style="transition:max-height .2s ease 0s"></ul><div class="hextra-search-status hx:sr-only" aria-live=polite role=status></div></div></div><a class="hx:p-2 hx:text-current" target=_blank rel=noreferrer href=https://github.com/hyprwm/Hyprland title=GitHub><svg height="24" fill="currentColor" viewBox="3 3 18 18"><path d="M12 3C7.0275 3 3 7.12937 3 12.2276c0 4.0833 2.57625 7.5321 6.15374 8.7548C9.60374 21.0631 9.77249 20.7863 9.77249 20.5441 9.77249 20.3249 9.76125 19.5982 9.76125 18.8254 7.5 19.2522 6.915 18.2602 6.735 17.7412 6.63375 17.4759 6.19499 16.6569 5.8125 16.4378 5.4975 16.2647 5.0475 15.838 5.80124 15.8264 6.51 15.8149 7.01625 16.4954 7.18499 16.7723 7.99499 18.1679 9.28875 17.7758 9.80625 17.5335 9.885 16.9337 10.1212 16.53 10.38 16.2993 8.3775 16.0687 6.285 15.2728 6.285 11.7432c0-1.0035.34875-1.834.92249-2.47994C7.1175 9.03257 6.8025 8.08674 7.2975 6.81794c0 0 .753749999999999-.24223 2.47499.94583.72001-.20762 1.48501-.31143 2.25001-.31143C12.7875 7.45234 13.5525 7.55615 14.2725 7.76377c1.7212-1.19959 2.475-.94583 2.475-.94583C17.2424 8.08674 16.9275 9.03257 16.8375 9.26326 17.4113 9.9092 17.76 10.7281 17.76 11.7432c0 3.5411-2.1037 4.3255-4.1063 4.5561C13.98 16.5877 14.2613 17.1414 14.2613 18.0065 14.2613 19.2407 14.25 20.2326 14.25 20.5441 14.25 20.7863 14.4188 21.0746 14.8688 20.9824 16.6554 20.364 18.2079 19.1866 19.3078 17.6162c1.0999-1.5705 1.6917-3.4551 1.6922-5.3886C21 7.12937 16.9725 3 12 3z"/></svg>
<span class=hx:sr-only>GitHub</span>
</a><button type=button aria-label=Menu aria-expanded=false class="hextra-hamburger-menu hx:cursor-pointer hx:-mr-2 hx:rounded-sm hx:p-2 hx:active:bg-gray-400/20 hx:md:hidden hx:hextra-focus-visible-inset"><svg height="24" fill="none" viewBox="0 0 24 24" stroke="currentColor"><g><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 8H20"/></g><g><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16H20"/></g></svg></button></nav></div><div class='hx:mx-auto hx:flex hextra-max-page-width'><aside class="hextra-sidebar-container hx:flex hx:flex-col hx:print:hidden hx:md:top-16 hx:md:shrink-0 hx:md:w-64 hx:md:self-start hx:max-md:[transform:translate3d(0,-100%,0)] hx:md:sticky"><div class="hx:px-4 hx:pt-4 hx:md:hidden"><div class="hextra-search-wrapper hx:relative hx:md:w-64"><div class="hx:relative hx:flex hx:items-center hx:text-gray-900 hx:contrast-more:text-gray-800 hx:dark:text-gray-300 hx:contrast-more:dark:text-gray-300"><input placeholder=Search... aria-label=Search... class="hextra-search-input hx:hextra-focus-visible hx:block hx:w-full hx:appearance-none hx:rounded-lg hx:px-3 hx:py-2 hx:transition-colors hx:text-base hx:leading-tight hx:md:text-sm hx:bg-black/[.05] hx:dark:bg-gray-50/10 hx:focus-visible:bg-white hx:dark:focus-visible:bg-dark hx:placeholder:text-gray-500 hx:dark:placeholder:text-gray-400 hx:contrast-more:border hx:contrast-more:border-current" type=search autocomplete=off spellcheck=false>
<kbd class="hx:absolute hx:my-1.5 hx:select-none hx:ltr:right-1.5 hx:rtl:left-1.5 hx:h-5 hx:rounded-sm hx:bg-white hx:px-1.5 hx:font-mono hx:text-[10px] hx:font-medium hx:text-gray-500 hx:border hx:border-gray-200 hx:dark:border-gray-100/20 hx:dark:bg-dark/50 hx:contrast-more:border-current hx:contrast-more:text-current hx:contrast-more:dark:border-current hx:items-center hx:gap-1 hx:transition-opacity hx:pointer-events-none hx:hidden hx:sm:flex">CTRL K</kbd></div><div><ul class="hextra-search-results hextra-scrollbar hx:hidden hx:border hx:border-gray-200 hx:bg-white hx:text-gray-100 hx:dark:border-neutral-800 hx:dark:bg-neutral-900 hx:absolute hx:top-full hx:z-20 hx:mt-2 hx:overflow-auto hx:overscroll-contain hx:rounded-xl hx:py-2.5 hx:shadow-xl hx:max-h-[min(calc(50vh-11rem-env(safe-area-inset-bottom)),400px)] hx:md:max-h-[min(calc(100vh-5rem-env(safe-area-inset-bottom)),400px)] hx:inset-x-0 hx:ltr:md:left-auto hx:rtl:md:right-auto hx:contrast-more:border hx:contrast-more:border-gray-900 hx:contrast-more:dark:border-gray-50 hx:w-screen hx:min-h-[100px] hx:max-w-[min(calc(100vw-2rem),calc(100%+20rem))]" aria-label="Search results" style="transition:max-height .2s ease 0s"></ul><div class="hextra-search-status hx:sr-only" aria-live=polite role=status></div></div></div></div><div class="hextra-scrollbar hx:overflow-y-auto hx:overflow-x-hidden hx:p-4 hx:grow hx:md:h-[calc(100vh-var(--navbar-height)-var(--menu-height))]"><ul class="hx:flex hx:flex-col hx:gap-1 hx:md:hidden"><li class=open><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none] hx:ltr:pr-8 hx:rtl:pl-8
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/><span class="hx:min-w-0 [word-break:break-word]">Wiki</span>
</a><button type=button class="hextra-sidebar-collapsible-button hx:absolute hx:top-1/2 hx:-translate-y-1/2 hx:ltr:right-2 hx:rtl:left-2 hx:shrink-0 hx:cursor-pointer hx:p-0 hx:text-gray-500 hx:dark:text-neutral-400 hx:group-hover:text-gray-900 hx:dark:group-hover:text-gray-50 hx:group-data-[active=true]:text-primary-800 hx:group-data-[active=true]:dark:text-primary-600 hx:hextra-focus-visible-inset" aria-label="Toggle section" aria-expanded=true><svg fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true" focusable="false" class="hx:h-[18px] hx:min-w-[18px] hx:rounded-xs hx:p-0.5 hx:hover:bg-gray-800/5 hx:dark:hover:bg-gray-100/5"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" class="hx:origin-center hx:transition-transform hx:rtl:-rotate-180"/></svg></button></div><div class="hextra-sidebar-children hx:ltr:pr-0 hx:rtl:pl-0 hx:overflow-hidden"><ul class='hx:relative hx:flex hx:flex-col hx:gap-1 hx:before:absolute hx:before:inset-y-1 hx:before:w-px hx:before:bg-gray-200 hx:before:content-[""] hx:ltr:ml-3 hx:ltr:pl-3 hx:ltr:before:left-0 hx:rtl:mr-3 hx:rtl:pr-3 hx:rtl:before:right-0 hx:dark:before:bg-neutral-800'><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/version-selector/><span class="hx:min-w-0 [word-break:break-word]">Version selector ⚙️</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none] hx:ltr:pr-8 hx:rtl:pl-8
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Getting-Started/><span class="hx:min-w-0 [word-break:break-word]">Getting Started</span>
</a><button type=button class="hextra-sidebar-collapsible-button hx:absolute hx:top-1/2 hx:-translate-y-1/2 hx:ltr:right-2 hx:rtl:left-2 hx:shrink-0 hx:cursor-pointer hx:p-0 hx:text-gray-500 hx:dark:text-neutral-400 hx:group-hover:text-gray-900 hx:dark:group-hover:text-gray-50 hx:group-data-[active=true]:text-primary-800 hx:group-data-[active=true]:dark:text-primary-600 hx:hextra-focus-visible-inset" aria-label="Toggle section" aria-expanded=false><svg fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true" focusable="false" class="hx:h-[18px] hx:min-w-[18px] hx:rounded-xs hx:p-0.5 hx:hover:bg-gray-800/5 hx:dark:hover:bg-gray-100/5"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" class="hx:origin-center hx:transition-transform hx:rtl:-rotate-180"/></svg></button></div><div class="hextra-sidebar-children hx:ltr:pr-0 hx:rtl:pl-0 hx:overflow-hidden"><ul class='hx:relative hx:flex hx:flex-col hx:gap-1 hx:before:absolute hx:before:inset-y-1 hx:before:w-px hx:before:bg-gray-200 hx:before:content-[""] hx:ltr:ml-3 hx:ltr:pl-3 hx:ltr:before:left-0 hx:rtl:mr-3 hx:rtl:pr-3 hx:rtl:before:right-0 hx:dark:before:bg-neutral-800'><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Getting-Started/Installation/><span class="hx:min-w-0 [word-break:break-word]">Installation</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Getting-Started/Master-Tutorial/><span class="hx:min-w-0 [word-break:break-word]">Master tutorial</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Getting-Started/Preconfigured-setups/><span class="hx:min-w-0 [word-break:break-word]">Preconfigured setups</span></a></div></li></ul></div></li><li class="hx:flex hx:flex-col open"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none] hx:ltr:pr-8 hx:rtl:pl-8
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/><span class="hx:min-w-0 [word-break:break-word]">Configuring</span>
</a><button type=button class="hextra-sidebar-collapsible-button hx:absolute hx:top-1/2 hx:-translate-y-1/2 hx:ltr:right-2 hx:rtl:left-2 hx:shrink-0 hx:cursor-pointer hx:p-0 hx:text-gray-500 hx:dark:text-neutral-400 hx:group-hover:text-gray-900 hx:dark:group-hover:text-gray-50 hx:group-data-[active=true]:text-primary-800 hx:group-data-[active=true]:dark:text-primary-600 hx:hextra-focus-visible-inset" aria-label="Toggle section" aria-expanded=true><svg fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true" focusable="false" class="hx:h-[18px] hx:min-w-[18px] hx:rounded-xs hx:p-0.5 hx:hover:bg-gray-800/5 hx:dark:hover:bg-gray-100/5"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" class="hx:origin-center hx:transition-transform hx:rtl:-rotate-180"/></svg></button></div><div class="hextra-sidebar-children hx:ltr:pr-0 hx:rtl:pl-0 hx:overflow-hidden"><ul class='hx:relative hx:flex hx:flex-col hx:gap-1 hx:before:absolute hx:before:inset-y-1 hx:before:w-px hx:before:bg-gray-200 hx:before:content-[""] hx:ltr:ml-3 hx:ltr:pl-3 hx:ltr:before:left-0 hx:rtl:mr-3 hx:rtl:pr-3 hx:rtl:before:right-0 hx:dark:before:bg-neutral-800'><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Start/><span class="hx:min-w-0 [word-break:break-word]">⮞⮞ Start Here ⮜⮜</span></a></div></li><li class="hx:flex hx:flex-col open"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none] hx:ltr:pr-8 hx:rtl:pl-8
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Basics/><span class="hx:min-w-0 [word-break:break-word]">Basics</span>
</a><button type=button class="hextra-sidebar-collapsible-button hx:absolute hx:top-1/2 hx:-translate-y-1/2 hx:ltr:right-2 hx:rtl:left-2 hx:shrink-0 hx:cursor-pointer hx:p-0 hx:text-gray-500 hx:dark:text-neutral-400 hx:group-hover:text-gray-900 hx:dark:group-hover:text-gray-50 hx:group-data-[active=true]:text-primary-800 hx:group-data-[active=true]:dark:text-primary-600 hx:hextra-focus-visible-inset" aria-label="Toggle section" aria-expanded=true><svg fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true" focusable="false" class="hx:h-[18px] hx:min-w-[18px] hx:rounded-xs hx:p-0.5 hx:hover:bg-gray-800/5 hx:dark:hover:bg-gray-100/5"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" class="hx:origin-center hx:transition-transform hx:rtl:-rotate-180"/></svg></button></div><div class="hextra-sidebar-children hx:ltr:pr-0 hx:rtl:pl-0 hx:overflow-hidden"><ul class='hx:relative hx:flex hx:flex-col hx:gap-1 hx:before:absolute hx:before:inset-y-1 hx:before:w-px hx:before:bg-gray-200 hx:before:content-[""] hx:ltr:ml-3 hx:ltr:pl-3 hx:ltr:before:left-0 hx:rtl:mr-3 hx:rtl:pr-3 hx:rtl:before:right-0 hx:dark:before:bg-neutral-800'><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Basics/Variables/><span class="hx:min-w-0 [word-break:break-word]">Variables</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Basics/Monitors/><span class="hx:min-w-0 [word-break:break-word]">Monitors</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Basics/Binds/><span class="hx:min-w-0 [word-break:break-word]">Binds</span></a></div></li><li class="hx:flex hx:flex-col open"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=true><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hextra-sidebar-active-item hx:bg-primary-100 hx:font-semibold hx:text-primary-800 hx:contrast-more:border hx:contrast-more:border-primary-500 hx:dark:bg-primary-400/10 hx:dark:text-primary-600 hx:contrast-more:dark:border-primary-500" href=/Configuring/Basics/Dispatchers/><span class="hx:min-w-0 [word-break:break-word]">Dispatchers</span></a></div><ul class='hx:flex hx:flex-col hx:gap-1 hx:relative hx:before:absolute hx:before:inset-y-1 hx:before:w-px hx:before:bg-gray-200 hx:before:content-[""] hx:dark:before:bg-neutral-800 hx:ltr:pl-3 hx:ltr:before:left-0 hx:rtl:pr-3 hx:rtl:before:right-0 hx:ltr:ml-3 hx:rtl:mr-3'><li><a href=#dispatchers class="hx:flex hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [word-break:break-word] hx:cursor-pointer [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none] hx:contrast-more:border hx:gap-2 hx:before:opacity-25 hx:before:content-['#'] hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:text-gray-900 hx:contrast-more:dark:text-gray-50 hx:contrast-more:border-transparent hx:contrast-more:hover:border-gray-900 hx:contrast-more:dark:hover:border-gray-50">Dispatchers</a></li><li><a href=#dispatchers-1 class="hx:flex hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [word-break:break-word] hx:cursor-pointer [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none] hx:contrast-more:border hx:gap-2 hx:before:opacity-25 hx:before:content-['#'] hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:text-gray-900 hx:contrast-more:dark:text-gray-50 hx:contrast-more:border-transparent hx:contrast-more:hover:border-gray-900 hx:contrast-more:dark:hover:border-gray-50">Dispatchers</a></li><li><a href=#workspace-selectors class="hx:flex hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [word-break:break-word] hx:cursor-pointer [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none] hx:contrast-more:border hx:gap-2 hx:before:opacity-25 hx:before:content-['#'] hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:text-gray-900 hx:contrast-more:dark:text-gray-50 hx:contrast-more:border-transparent hx:contrast-more:hover:border-gray-900 hx:contrast-more:dark:hover:border-gray-50">Workspace selectors</a></li><li><a href=#special-workspace class="hx:flex hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [word-break:break-word] hx:cursor-pointer [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none] hx:contrast-more:border hx:gap-2 hx:before:opacity-25 hx:before:content-['#'] hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:text-gray-900 hx:contrast-more:dark:text-gray-50 hx:contrast-more:border-transparent hx:contrast-more:hover:border-gray-900 hx:contrast-more:dark:hover:border-gray-50">Special Workspace</a></li><li><a href=#executing-with-rules class="hx:flex hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [word-break:break-word] hx:cursor-pointer [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none] hx:contrast-more:border hx:gap-2 hx:before:opacity-25 hx:before:content-['#'] hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:text-gray-900 hx:contrast-more:dark:text-gray-50 hx:contrast-more:border-transparent hx:contrast-more:hover:border-gray-900 hx:contrast-more:dark:hover:border-gray-50">Executing with rules</a></li><li><a href=#set_prop class="hx:flex hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [word-break:break-word] hx:cursor-pointer [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none] hx:contrast-more:border hx:gap-2 hx:before:opacity-25 hx:before:content-['#'] hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:text-gray-900 hx:contrast-more:dark:text-gray-50 hx:contrast-more:border-transparent hx:contrast-more:hover:border-gray-900 hx:contrast-more:dark:hover:border-gray-50">set_prop</a></li><li><a href=#fullscreenstate class="hx:flex hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [word-break:break-word] hx:cursor-pointer [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none] hx:contrast-more:border hx:gap-2 hx:before:opacity-25 hx:before:content-['#'] hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:text-gray-900 hx:contrast-more:dark:text-gray-50 hx:contrast-more:border-transparent hx:contrast-more:hover:border-gray-900 hx:contrast-more:dark:hover:border-gray-50">Fullscreenstate</a></li></ul></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Basics/Window-Rules/><span class="hx:min-w-0 [word-break:break-word]">Window Rules</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Basics/Workspace-Rules/><span class="hx:min-w-0 [word-break:break-word]">Workspace Rules</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Basics/Autostart/><span class="hx:min-w-0 [word-break:break-word]">Autostart</span></a></div></li></ul></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none] hx:ltr:pr-8 hx:rtl:pl-8
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Layouts/><span class="hx:min-w-0 [word-break:break-word]">Layouts</span>
</a><button type=button class="hextra-sidebar-collapsible-button hx:absolute hx:top-1/2 hx:-translate-y-1/2 hx:ltr:right-2 hx:rtl:left-2 hx:shrink-0 hx:cursor-pointer hx:p-0 hx:text-gray-500 hx:dark:text-neutral-400 hx:group-hover:text-gray-900 hx:dark:group-hover:text-gray-50 hx:group-data-[active=true]:text-primary-800 hx:group-data-[active=true]:dark:text-primary-600 hx:hextra-focus-visible-inset" aria-label="Toggle section" aria-expanded=false><svg fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true" focusable="false" class="hx:h-[18px] hx:min-w-[18px] hx:rounded-xs hx:p-0.5 hx:hover:bg-gray-800/5 hx:dark:hover:bg-gray-100/5"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" class="hx:origin-center hx:transition-transform hx:rtl:-rotate-180"/></svg></button></div><div class="hextra-sidebar-children hx:ltr:pr-0 hx:rtl:pl-0 hx:overflow-hidden"><ul class='hx:relative hx:flex hx:flex-col hx:gap-1 hx:before:absolute hx:before:inset-y-1 hx:before:w-px hx:before:bg-gray-200 hx:before:content-[""] hx:ltr:ml-3 hx:ltr:pl-3 hx:ltr:before:left-0 hx:rtl:mr-3 hx:rtl:pr-3 hx:rtl:before:right-0 hx:dark:before:bg-neutral-800'><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Layouts/Dwindle-Layout/><span class="hx:min-w-0 [word-break:break-word]">Dwindle Layout</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Layouts/Master-Layout/><span class="hx:min-w-0 [word-break:break-word]">Master Layout</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Layouts/Scrolling-Layout/><span class="hx:min-w-0 [word-break:break-word]">Scrolling Layout</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Layouts/Monocle-Layout/><span class="hx:min-w-0 [word-break:break-word]">Monocle Layout</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Layouts/Custom-Layouts/><span class="hx:min-w-0 [word-break:break-word]">Custom Layouts</span></a></div></li></ul></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none] hx:ltr:pr-8 hx:rtl:pl-8
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Advanced-and-Cool/><span class="hx:min-w-0 [word-break:break-word]">Advanced and Cool</span>
</a><button type=button class="hextra-sidebar-collapsible-button hx:absolute hx:top-1/2 hx:-translate-y-1/2 hx:ltr:right-2 hx:rtl:left-2 hx:shrink-0 hx:cursor-pointer hx:p-0 hx:text-gray-500 hx:dark:text-neutral-400 hx:group-hover:text-gray-900 hx:dark:group-hover:text-gray-50 hx:group-data-[active=true]:text-primary-800 hx:group-data-[active=true]:dark:text-primary-600 hx:hextra-focus-visible-inset" aria-label="Toggle section" aria-expanded=false><svg fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true" focusable="false" class="hx:h-[18px] hx:min-w-[18px] hx:rounded-xs hx:p-0.5 hx:hover:bg-gray-800/5 hx:dark:hover:bg-gray-100/5"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" class="hx:origin-center hx:transition-transform hx:rtl:-rotate-180"/></svg></button></div><div class="hextra-sidebar-children hx:ltr:pr-0 hx:rtl:pl-0 hx:overflow-hidden"><ul class='hx:relative hx:flex hx:flex-col hx:gap-1 hx:before:absolute hx:before:inset-y-1 hx:before:w-px hx:before:bg-gray-200 hx:before:content-[""] hx:ltr:ml-3 hx:ltr:pl-3 hx:ltr:before:left-0 hx:rtl:mr-3 hx:rtl:pr-3 hx:rtl:before:right-0 hx:dark:before:bg-neutral-800'><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Advanced-and-Cool/Animations/><span class="hx:min-w-0 [word-break:break-word]">Animations</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Advanced-and-Cool/Gestures/><span class="hx:min-w-0 [word-break:break-word]">Gestures</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Advanced-and-Cool/Devices/><span class="hx:min-w-0 [word-break:break-word]">Devices</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Advanced-and-Cool/Tearing/><span class="hx:min-w-0 [word-break:break-word]">Tearing</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Advanced-and-Cool/Uncommon-tips-and-tricks/><span class="hx:min-w-0 [word-break:break-word]">Uncommon tips & tricks</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Advanced-and-Cool/Permissions/><span class="hx:min-w-0 [word-break:break-word]">Permissions</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Advanced-and-Cool/Using-hyprctl/><span class="hx:min-w-0 [word-break:break-word]">Using hyprctl</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset
hx:text-gray-500 hx:hover:bg-gray-100 hx:hover:text-gray-900 hx:contrast-more:border hx:contrast-more:border-transparent hx:contrast-more:text-gray-900 hx:contrast-more:hover:border-gray-900 hx:dark:text-neutral-400 hx:dark:hover:bg-primary-100/5 hx:dark:hover:text-gray-50 hx:contrast-more:dark:text-gray-50 hx:contrast-more:dark:hover:border-gray-50" href=/Configuring/Advanced-and-Cool/Notifications/><span class="hx:min-w-0 [word-break:break-word]">Notifications</span></a></div></li><li class="hx:flex hx:flex-col"><div class="hextra-sidebar-item hx:group hx:relative hx:flex hx:items-center" data-active=false><a class="hx:flex hx:items-center hx:justify-between hx:gap-2 hx:grow hx:cursor-pointer hx:rounded-sm hx:px-2 hx:py-1.5 hx:text-sm hx:transition-colors [-webkit-tap-highlight-color:transparent] [-webkit-touch-callout:none]
hx:hextra-focus-visible-inset

...219995 bytes truncated...

The tool call succeeded but the output was truncated. Full output saved to: /home/mb/.local/share/opencode/tool-output/tool_095d992f200184zUONXWKX4SM3
Use the Task tool to have explore agent process this file with Grep and Read (with offset/limit). Do NOT read the full file yourself - delegate to save context.
```

---

## Assistant (Build · Muse Spark 1.3 Free · 3.4s)

_Thinking:_



I have what I need — now making workspace 1 persistently named "code".

**Tool: bash**

**Input:**
```json
{
  "command": "cp ~/.config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua.bak.$(date +%s) && ls ~/.config/hypr/hyprland.lua.bak.* | tail -n 5"
}
```

**Output:**
```
/home/mb/.config/hypr/hyprland.lua.bak.1789220462

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.1s)

_Thinking:_



**Tool: edit**

**Input:**
```json
{
  "filePath": "/home/mb/.config/hypr/hyprland.lua",
  "newString": "-- Add any other personal Hyprland configuration below.\n-- Workspace 1 named \"code\" (persistent)\nhl.workspace_rule({ workspace = \"1\", default_name = \"code\", persistent = true })\no.window(\"qemu\", { workspace = \"5\" })",
  "oldString": "-- Add any other personal Hyprland configuration below.\no.window(\"qemu\", { workspace = \"5\" })"
}
```

**Output:**
```
Edit applied successfully.
```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.5s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "hyprctl reload 2>&1; sleep 1; hyprctl configerrors 2>&1; echo \"===\"; hyprctl workspacerules -j 2>&1; echo \"===\"; hyprctl workspaces 2>&1 | head -n 40"
}
```

**Output:**
```
ok


===
[{
    "workspaceString": "1",
    "enabled": true,
    "persistent": true,
    "defaultName": "code"
},{
    "workspaceString": "3",
    "enabled": true
}]
===
workspace ID 10 (10) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b1823c1e60
	lastwindowtitle: 5 MCP servers every Claude Code user needs right now. - YouTube
	ispersistent: 0
	tiledLayout: dwindle

workspace ID 1 (1) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b183e478e0
	lastwindowtitle: omarchy: ~
	ispersistent: 1
	tiledLayout: dwindle



```

---

## Assistant (Build · Muse Spark 1.3 Free · 3.1s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "hyprctl --batch \"dispatch renameworkspace 1 code\" 2>&1; echo \"---batch done---\"; hyprctl workspaces 2>&1 | head -n 20; echo \"===\"; hyprctl eval 'hl.dispatch(\"renameworkspace\", \"1\", \"code\")' 2>&1 | head -n 20"
}
```

**Output:**
```
error: [string "return hl.dispatch(renameworkspace 1 code)"]:1: ')' expected near '1'

 → Note: dispatch in lua is a shorthand for hl.dispatch(...), your syntax might need to be updated.
---batch done---
workspace ID 10 (10) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b1823c1e60
	lastwindowtitle: 5 MCP servers every Claude Code user needs right now. - YouTube
	ispersistent: 0
	tiledLayout: dwindle

workspace ID 1 (1) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b183e478e0
	lastwindowtitle: omarchy: ~
	ispersistent: 1
	tiledLayout: dwindle


===
error: return hl.dispatch("renameworkspace", "1", "code");:1: hl.dispatch: expected a dispatcher (e.g. hl.dsp.window.close())

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.6s)

_Thinking:_



Config is clean and persistent — now applying the name to your live workspace.

**Tool: bash**

**Input:**
```json
{
  "command": "grep -n \"dsp\\|Dsp\\|rename\\|Dispatcher\" /usr/share/hypr/stubs/hl.meta.lua | head -n 100"
}
```

**Output:**
```
400:---@class HL.Dispatcher
401:local __HL_Dispatcher = {}
822:---@field bind fun(keys: string, dispatcher: HL.Dispatcher|function, opts?: HL.BindOptions): HL.Keybind
828:---@field dispatch fun(dispatcher: HL.Dispatcher|function): any
864:---@field dsp HL.DspNamespace
870:---@class HL.DspNamespace
871:---@field dpms fun(...): HL.Dispatcher
872:---@field event fun(...): HL.Dispatcher
873:---@field exec_cmd fun(...): HL.Dispatcher
874:---@field exec_raw fun(...): HL.Dispatcher
875:---@field exit fun(...): HL.Dispatcher
876:---@field focus fun(...): HL.Dispatcher
877:---@field force_idle fun(...): HL.Dispatcher
878:---@field force_renderer_reload fun(...): HL.Dispatcher
879:---@field global fun(...): HL.Dispatcher
880:---@field layout fun(...): HL.Dispatcher
881:---@field no_op fun(...): HL.Dispatcher
882:---@field pass fun(...): HL.Dispatcher
883:---@field release_input_capture fun(...): HL.Dispatcher
884:---@field send_key_state fun(...): HL.Dispatcher
885:---@field send_shortcut fun(...): HL.Dispatcher
886:---@field submap fun(...): HL.Dispatcher
887:---@field cursor HL.DspCursorNamespace
888:---@field group HL.DspGroupNamespace
889:---@field window HL.DspWindowNamespace
890:---@field workspace HL.DspWorkspaceNamespace
891:local __HL_DspNamespace = {}
893:---@class HL.DspCursorNamespace
894:---@field move fun(...): HL.Dispatcher
895:---@field move_to_corner fun(...): HL.Dispatcher
896:local __HL_DspCursorNamespace = {}
898:---@class HL.DspGroupNamespace
899:---@field active fun(...): HL.Dispatcher
900:---@field lock fun(...): HL.Dispatcher
901:---@field lock_active fun(...): HL.Dispatcher
902:---@field move_window fun(...): HL.Dispatcher
903:---@field next fun(...): HL.Dispatcher
904:---@field prev fun(...): HL.Dispatcher
905:---@field toggle fun(...): HL.Dispatcher
906:local __HL_DspGroupNamespace = {}
908:---@class HL.DspWindowNamespace
909:---@field alter_zorder fun(...): HL.Dispatcher
910:---@field bring_to_top fun(...): HL.Dispatcher
911:---@field center fun(...): HL.Dispatcher
912:---@field clear_tags fun(...): HL.Dispatcher
913:---@field close fun(...): HL.Dispatcher
914:---@field cycle_next fun(...): HL.Dispatcher
915:---@field deny_from_group fun(...): HL.Dispatcher
916:---@field drag fun(...): HL.Dispatcher
917:---@field float fun(...): HL.Dispatcher
918:---@field fullscreen fun(...): HL.Dispatcher
919:---@field fullscreen_state fun(...): HL.Dispatcher
920:---@field kill fun(...): HL.Dispatcher
921:---@field move fun(...): HL.Dispatcher
922:---@field pin fun(...): HL.Dispatcher
923:---@field pseudo fun(...): HL.Dispatcher
924:---@field resize fun(...): HL.Dispatcher
925:---@field set_prop fun(...): HL.Dispatcher
926:---@field signal fun(...): HL.Dispatcher
927:---@field swap fun(...): HL.Dispatcher
928:---@field tag fun(...): HL.Dispatcher
929:---@field toggle_swallow fun(...): HL.Dispatcher
930:local __HL_DspWindowNamespace = {}
932:---@class HL.DspWorkspaceNamespace
933:---@field change_id fun(...): HL.Dispatcher
934:---@field move fun(...): HL.Dispatcher
935:---@field rename fun(...): HL.Dispatcher
936:---@field swap_monitors fun(...): HL.Dispatcher
937:---@field toggle_special fun(...): HL.Dispatcher
938:local __HL_DspWorkspaceNamespace = {}

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.2s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "hyprctl eval 'hl.dispatch(hl.dsp.workspace.rename(\"1\", \"code\"))' 2>&1; echo \"---\"; sleep 0.5; hyprctl workspaces 2>&1 | head -n 30"
}
```

**Output:**
```
error: =[C]:-1: hl.workspace.rename: expected a table { workspace, name? }
error: return hl.dispatch(hl.dsp.workspace.rename("1", "code"));:1: hl.dispatch: expected a dispatcher (e.g. hl.dsp.window.close())
---
workspace ID 10 (10) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b1823c1e60
	lastwindowtitle: 5 MCP servers every Claude Code user needs right now. - YouTube
	ispersistent: 0
	tiledLayout: dwindle

workspace ID 1 (1) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b183e478e0
	lastwindowtitle: omarchy: ~
	ispersistent: 1
	tiledLayout: dwindle



```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.8s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "hyprctl eval 'hl.dispatch(hl.dsp.workspace.rename({ workspace = \"1\", name = \"code\" }))' 2>&1; echo \"---\"; sleep 0.5; hyprctl workspaces 2>&1 | head -n 30"
}
```

**Output:**
```
ok
---
workspace ID 10 (10) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b1823c1e60
	lastwindowtitle: 5 MCP servers every Claude Code user needs right now. - YouTube
	ispersistent: 0
	tiledLayout: dwindle

workspace ID 1 (code) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b183e478e0
	lastwindowtitle: omarchy: ~
	ispersistent: 1
	tiledLayout: dwindle



```

---

## Assistant (Build · Muse Spark 1.3 Free · 3.2s)

_Thinking:_



Done — workspace 1 is now named **"code"**.

**What I did (per omarchy skill `hyprland.md`):**

1. Backed up `~/.config/hypr/hyprland.lua` → `hyprland.lua.bak.*`
2. Added persistent workspace rule in `~/.config/hypr/hyprland.lua`:
   ```lua
   -- Workspace 1 named "code" (persistent)
   hl.workspace_rule({ workspace = "1", default_name = "code", persistent = true })
   ```
   - `default_name` from [Hyprland Workspace-Rules wiki](https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/)
   - `persistent = true` keeps it alive even when empty
3. Validated:
   - `hyprctl reload` → `ok`
   - `hyprctl configerrors` → clean (no errors)
   - `hyprctl workspacerules -j` shows:
     ```json
     { "workspaceString": "1", "persistent": true, "defaultName": "code" }
     ```
4. Renamed live workspace immediately:
   ```
   hyprctl eval 'hl.dispatch(hl.dsp.workspace.rename({ workspace = "1", name = "code" }))'
   ```
   - `hyprctl workspaces` now shows: `workspace ID 1 (code)` with `ispersistent: 1`

Your `SUPER+1` binding still works (ID is still 1, name is just `code`). It will survive reboots/reloads via the rule.

---

## User

I want to visually display "code" for workspace 1

---

## Assistant (Build · Muse Spark 1.3 Free · 3.1s)

_Thinking:_



Got it — making the bar actually show "code" instead of "1".

**Tool: skill**

**Input:**
```json
{
  "name": "omarchy"
}
```

**Output:**
```
<skill_content name="omarchy">
# Skill: omarchy

# Omarchy Skill

Manage [Omarchy](https://omarchy.org/) Linux systems - a beautiful, modern, opinionated Arch Linux distribution with Hyprland.

This skill is for end-user customization on installed systems.
It is not for contributing to Omarchy source code.

## When This Skill MUST Be Used

**ALWAYS invoke this skill for end-user requests involving ANY of these:**

- Editing ANY file in `~/.config/hypr/` (window rules, animations, keybindings, monitors, etc.)
- Editing `~/.config/omarchy/shell.json` (status bar layout, widgets)
- Editing terminal configs (alacritty, foot, kitty, ghostty)
- Editing ANY file in `~/.config/omarchy/`
- Window behavior, animations, opacity, blur, gaps, borders
- Layer rules, workspace settings, display/monitor configuration
- Themes, backgrounds, fonts, appearance changes
- User-facing `omarchy` commands (`omarchy theme ...`, `omarchy refresh ...`, `omarchy restart ...`, etc.)
- Screenshots, screen recording, reminders, night light, idle behavior, lock screen

**If you're about to edit a config file in ~/.config/ on this system, STOP and use this skill first.**

**Do NOT use this skill for Omarchy development tasks** (editing the Omarchy source tree, creating migrations, or running `omarchy dev ...` workflows).

## Topic Guides

Deeper instructions for common areas live next to this file. Read the
matching guide before starting:

- [`hyprland.md`](hyprland.md) - keybindings, monitors, window rules, and other Hyprland config
- [`plugins.md`](plugins.md) - the Omarchy shell: bar layout, widgets, plugins, idle behavior
- [`theming.md`](theming.md) - themes, backgrounds, and fonts
- [`hooks.md`](hooks.md) - automation hooks that run on system events
- [`capture.md`](capture.md) - screenshots, screen recordings, OCR text capture, and file sharing
- [`contributing.md`](contributing.md) - reporting Omarchy bugs and submitting fixes upstream

## Critical Safety Rules

For privileged commands, follow the Privilege Escalation rules below: `sudo` when a terminal is available for the password prompt, `pkexec` when it is not. Do not wrap commands that already manage privilege elevation themselves.

**For end-user customization tasks, NEVER modify anything in `/usr/share/omarchy/`** - but READING is safe and encouraged.

This directory is owned by the omarchy package. Any local changes will be
overwritten on the next `omarchy update`.

```
/usr/share/omarchy/     # READ-ONLY - NEVER EDIT (reading is OK)
├── bin/                    # Command source (packaged binaries are on PATH)
├── config/                 # Default config templates
├── themes/                 # Stock themes
├── default/                # System defaults
├── shell/                  # Omarchy shell source and defaults
├── migrations/             # Update migrations
└── install/                # Installation scripts
```

**Reading `/usr/share/omarchy/` is SAFE and useful** - do it freely to:
- Understand how omarchy commands work: `omarchy theme set --help` or `cat $(which omarchy-theme-set)`
- See default configs before customizing: `cat "$OMARCHY_PATH/config/omarchy/shell.json"`
- Check stock theme files to copy for customization
- Reference default hyprland settings: `cat /usr/share/omarchy/default/hypr/*`

**Always use these safe locations instead:**
- `~/.config/` - User configuration (safe to edit)
- `~/.config/omarchy/themes/<custom-name>/` - Custom themes
- `~/.config/omarchy/hooks/` - Custom automation hooks

If the request is to develop Omarchy itself, this skill is out of scope. Follow repository development instructions instead of this skill.

## Privilege Escalation

For an interactive script or command run in a visible terminal, use `sudo` for
privileged work. Omarchy may grant passwordless `sudo` access to particular
commands, and the terminal is the appropriate place to request a password
when one is needed.

Use `pkexec` only when the caller cannot interact with a terminal or cannot
enter a password there, such as a command launched by an agent or a graphical
background process. Do not replace `sudo` with `pkexec` merely because a
command changes system state.

## System Architecture

Omarchy is built on:

| Component | Purpose | Config Location |
|-----------|---------|-----------------|
| **Arch Linux** | Base OS | `/etc/`, `~/.config/` |
| **Hyprland** | Wayland compositor/WM | `~/.config/hypr/` |
| **Omarchy shell** | Status bar + notifications (Quickshell) | `~/.config/omarchy/shell.json` |
| **Launcher/menus** | Quickshell menu | `~/.config/omarchy/extensions/omarchy-menu.jsonc` |
| **Alacritty/Foot/Kitty/Ghostty** | Terminals | `~/.config/<terminal>/` |
| **Omarchy OSD** | On-screen display | Quickshell plugin |

## Command Discovery

Omarchy ships a single `omarchy` CLI that dispatches to all `omarchy-*` binaries via `omarchy <group> <action>`. Always prefer this form — it is self-documenting and stable. The underlying `omarchy-*` binaries still exist on `PATH` and remain safe to read for source.

```bash
# List every documented command and its summary (--all includes hidden commands)
omarchy commands

# Show the commands inside a group
omarchy theme --help
omarchy refresh --help
omarchy restart --help

# Show help for a specific command (does not execute it)
omarchy theme set --help

# Machine-readable listing (binary, route, summary, args, aliases)
omarchy commands --json

# Read a command's source to understand it
cat $(which omarchy-theme-set)
```

### Command Groups

Run `omarchy --help` for the full list. The most common groups:

| Group | Purpose | Example |
|-------|---------|---------|
| `omarchy refresh` | Reset config to defaults (backs up first) | `omarchy refresh shell` |
| `omarchy restart` | Restart a service/app | `omarchy restart shell` |
| `omarchy toggle` | Toggle feature on/off | `omarchy toggle nightlight` |
| `omarchy theme` | Theme management | `omarchy theme set <name>` |
| `omarchy bar` | Bar layout and widgets | `omarchy bar move omarchy.clock --section right` |
| `omarchy plugin` | Manage/clone shell plugins | `omarchy plugin clone omarchy.clock` |
| `omarchy hook` | Install automation hooks | `omarchy hook install theme-set <script>` |
| `omarchy install` | Install optional software / packages | `omarchy install docker dbs` |
| `omarchy launch` | Launch apps | `omarchy launch browser` |
| `omarchy capture` | Screenshots and recordings | `omarchy capture screenshot` |
| `omarchy reminder` | Desktop notification reminders | `omarchy reminder 15 "Pickup Jack"` |
| `omarchy pkg` | Package management | `omarchy pkg add <pkg>` |
| `omarchy setup` | Interactive setup wizards | `omarchy setup security fingerprint` |
| `omarchy update` | System updates | `omarchy update` |

## Configuration Locations

Hyprland config lives in `~/.config/hypr/` — see [`hyprland.md`](hyprland.md).
The Omarchy shell (bar, notifications, plugins, idle) is configured in
`~/.config/omarchy/shell.json` — see [`plugins.md`](plugins.md).

### Terminals

```
~/.config/alacritty/alacritty.toml
~/.config/foot/foot.ini
~/.config/kitty/kitty.conf
~/.config/ghostty/config
```

**Command:** `omarchy restart terminal`

### Other Configs

| App | Location |
|-----|----------|
| btop | `~/.config/btop/btop.conf` |
| fastfetch | `/etc/fastfetch/config.jsonc` default; `~/.config/fastfetch/config.jsonc` user override |
| lazygit | `~/.config/lazygit/config.yml` |
| starship | `~/.config/starship.toml` |
| git | `~/.config/git/config` |

## Safe Customization Patterns

### Edit User Config Directly

For simple changes, edit files in `~/.config/`:

```bash
# 1. Read current config
cat ~/.config/hypr/bindings.lua

# 2. Backup before changes
cp ~/.config/hypr/bindings.lua ~/.config/hypr/bindings.lua.bak.$(date +%s)

# 3. Make changes with Edit tool

# 4. Apply changes
# - Hyprland: auto-reloads on save, but MUST validate with `hyprctl reload` and `hyprctl configerrors`
# - Omarchy shell: shell.json and user plugin code under ~/.config/omarchy/plugins/ hot-reload on save
# - Menus/launcher: ~/.config/omarchy/extensions/omarchy-menu.jsonc hot-reloads on save
# - Terminals: apply with `omarchy restart terminal` (reloads running terminals; foot picks changes up in new windows)
```

### Reset to Defaults -- ALWAYS SEEK USER CONFIRMATION BEFORE RUNNING

When customizations go wrong:

```bash
# Reset specific config (creates backup automatically)
omarchy refresh shell
omarchy refresh hyprland

# The refresh command:
# 1. Backs up current config with timestamp
# 2. Copies default from $OMARCHY_PATH/config/
# 3. Restarts the component where the refresh needs it (e.g. `refresh shell`)
```

## System Commands

```bash
omarchy update                  # Full system update
omarchy version                 # Show Omarchy version
omarchy debug --no-sudo --print # Debug info (ALWAYS use these flags)
omarchy system lock             # Lock screen
omarchy system shutdown         # Shutdown
omarchy system reboot           # Reboot
```

**IMPORTANT:** Always run `omarchy debug` with `--no-sudo --print` flags to avoid interactive sudo prompts that will hang the terminal.

## Troubleshooting

```bash
# Get debug information (ALWAYS use these flags to avoid interactive prompts)
omarchy debug --no-sudo --print

# Reset specific config to defaults
omarchy refresh <app>

# Refresh specific config file
# config-file path is relative to ~/.config/
# eg. `omarchy refresh config hypr/hyprland.lua` will refresh ~/.config/hypr/hyprland.lua
omarchy refresh config <config-file>

# Full reinstall of configs (nuclear option)
omarchy reinstall
```

## Decision Framework

When user requests system changes:

1. **Is it a stock omarchy command?** Use it directly
2. **Is it a config edit?** Edit in `~/.config/`, never `/usr/share/omarchy/`
3. **Is it a theme customization?** Follow [`theming.md`](theming.md); create a NEW custom theme directory
4. **Is it automation?** Follow [`hooks.md`](hooks.md); use `omarchy hook install` and the hook `.d` directories
5. **Is it a package install?** Use `omarchy pkg add <pkgs...>` (or `omarchy pkg aur add <pkgs...>` for AUR-only packages)
6. **Is it built-in shell/plugin code?** Follow [`plugins.md`](plugins.md); clone it with `omarchy plugin clone`, never edit the packaged copy
7. **Unsure if command exists?** Run `omarchy commands` (or `omarchy <group> --help` for one group)

### Reminder Requests

When the user asks to set a reminder, use `omarchy reminder <minutes> [message]` directly. Convert natural language durations to minutes and title-case short reminder labels when appropriate.

```bash
omarchy reminder 15 "Pickup Jack"
omarchy reminder 60 "Check laundry"
omarchy reminder show
omarchy reminder clear
```

## Out of Scope

This skill intentionally does not cover Omarchy source development. Do not use this skill for:
- Editing files in `/usr/share/omarchy/` (`bin/`, `config/`, `default/`, `shell/`, `themes/`, `migrations/`, etc.)
- Creating or editing migrations
- Running `omarchy dev ...` commands

## Example Requests

- "Change my theme to catppuccin" -> `omarchy theme set catppuccin`
- "Add a keybinding for Super+E to open file manager" -> Check existing bindings first, call `hl.unbind` if needed, then `o.bind` in `~/.config/hypr/bindings.lua`
- "Configure my external monitor" -> Edit `~/.config/hypr/monitors.lua`
- "Make the window gaps smaller" -> Edit `~/.config/hypr/looknfeel.lua`
- "Turn on night light" -> `omarchy toggle nightlight` (for time-based schedules, edit `~/.config/hypr/hyprsunset.conf` profiles, then `omarchy restart hyprsunset`)
- "Set a reminder to pickup jack in 15 minutes" -> `omarchy reminder 15 "Pickup Jack"`
- "Show my reminders" -> `omarchy reminder show`
- "Clear all reminders" -> `omarchy reminder clear`
- "Customize the catppuccin theme colors" -> Overlay: put an edited `colors.toml` in `~/.config/omarchy/themes/catppuccin/`, then re-apply the theme (see `theming.md`)
- "Run a script every time I change themes" -> Install it with `omarchy hook install theme-set <script>`
- "Change how workspace labels are rendered" -> Clone `omarchy.workspaces`, which switches the bar to `<username>.workspaces`, then edit the clone
- "Lock after ten minutes" -> Set `idle.lock` to `600` in `~/.config/omarchy/shell.json`
- "Reset shell/bar to defaults" -> `omarchy refresh shell`
- "Record my screen" -> `omarchy screenrecord --fullscreen`, then `omarchy screenrecord --stop-recording` (see `capture.md`)
- "Report this bug to Omarchy" -> Gather diagnostics and a capture of the problem, then file it (see `contributing.md`)

Base directory for this skill: /home/mb/.agents/skills/omarchy
Relative paths in this skill (e.g., scripts/, reference/) are relative to this base directory.
Note: file list is sampled.

<skill_files>
<file>/home/mb/.agents/skills/omarchy/theming.md</file>
<file>/home/mb/.agents/skills/omarchy/plugins.md</file>
<file>/home/mb/.agents/skills/omarchy/hyprland.md</file>
<file>/home/mb/.agents/skills/omarchy/hooks.md</file>
<file>/home/mb/.agents/skills/omarchy/contributing.md</file>
<file>/home/mb/.agents/skills/omarchy/capture.md</file>
</skill_files>
</skill_content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.9s)

_Thinking:_



**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.agents/skills/omarchy/plugins.md"
}
```

**Output:**
```
<path>/home/mb/.agents/skills/omarchy/plugins.md</path>
<type>file</type>
<content>
1: # Omarchy Shell: Bar, Plugins, and Idle
2: 
3: Read this before changing the status bar, notifications, shell plugins,
4: widgets, or idle/lock behavior.
5: 
6: The bar, notification daemon, settings panel, and assorted overlays all run
7: inside a single long-running Quickshell process (`omarchy-shell`).
8: 
9: ```
10: ~/.config/omarchy/shell.json             # User overrides: bar, plugins, idle
11: ~/.config/omarchy/plugins/<plugin-id>/   # User-owned shell plugins
12: $OMARCHY_PATH/config/omarchy/shell.json  # Canonical defaults
13: ```
14: 
15: The shell hot-reloads `shell.json` on save — no restart needed for layout
16: changes. `idle.screensaver` and `idle.lock` are seconds since user idle began.
17: 
18: **Commands:** `omarchy restart shell`, `omarchy refresh shell`
19: 
20: ## Bar Layout
21: 
22: Use the `omarchy bar` group to move and manage widgets:
23: 
24: ```bash
25: omarchy bar move omarchy.clock --section right
26: ```
27: 
28: For layout edits beyond what the commands cover, edit the bar configuration
29: in `~/.config/omarchy/shell.json`; it hot-reloads on save.
30: 
31: ## Customizing Built-In Plugins and Widgets
32: 
33: To customize a built-in bar widget, never edit `$OMARCHY_PATH/shell/plugins/`.
34: Clone it into the user plugin directory instead:
35: 
36: ```bash
37: omarchy plugin clone omarchy.workspaces
38: # Edit ~/.config/omarchy/plugins/<username>.workspaces/; saved changes reload automatically.
39: ```
40: 
41: Cloning switches the bar to the cloned copy (e.g. `<username>.workspaces`),
42: which is yours to edit and survives updates.
43: 
44: Saving a file anywhere under `~/.config/omarchy/plugins/` reloads plugin code
45: automatically. If a change somehow fails to apply, force a reload with
46: `omarchy-shell shell rescanPlugins`.
47: 
48: ## Idle and Lock
49: 
50: Set `idle.screensaver` and `idle.lock` in `~/.config/omarchy/shell.json`,
51: in seconds since user idle began. Example: "lock after ten minutes" means
52: setting `idle.lock` to `600`.

(End of file - total 52 lines)
</content>
```

**Tool: bash**

**Input:**
```json
{
  "command": "cat ~/.config/omarchy/shell.json 2>&1; echo \"===\"; hyprctl workspaces 2>&1; echo \"===\"; omarchy-shell workspace-layout json 2>&1 | head -n 100 || omarchy shell workspace-layout json 2>&1 | head -n 100"
}
```

**Output:**
```
{
  "bar": {
    "centerAnchor": "omarchy.clock",
    "layout": {
      "center": [
        {
          "id": "omarchy.indicators"
        },
        {
          "id": "omarchy.clock",
          "format": "ddd d MMM h:mm AP",
          "formatAlt": "d MMMM 'W'ww yyyy",
          "verticalFormat": "HH\n—\nmm"
        },
        {
          "id": "omarchy.keyboard-layout"
        },
        {
          "id": "omarchy.weather"
        },
        {
          "id": "mbhalkar.ctl"
        },
        {
          "id": "omarchy.system-update"
        }
      ],
      "left": [
        {
          "id": "omarchy.menu"
        },
        {
          "id": "omarchy.workspaces"
        }
      ],
      "right": [
        {
          "id": "omarchy.tray"
        },
        {
          "id": "akshar.radio-atlas"
        },
        {
          "id": "omarchy.agents"
        },
        {
          "id": "omarchy.bluetooth"
        },
        {
          "id": "omarchy.network"
        },
        {
          "id": "omarchy.audio"
        },
        {
          "id": "omarchy.monitor"
        },
        {
          "id": "omarchy.power",
          "showPercentage": true
        }
      ]
    },
    "position": "top",
    "transparent": false
  },
  "idle": {
    "lock": 300,
    "screensaver": 150
  },
  "plugins": [],
  "version": 1
}
===
workspace ID 10 (10) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b1823c1e60
	lastwindowtitle: 5 MCP servers every Claude Code user needs right now. - YouTube
	ispersistent: 0
	tiledLayout: dwindle

workspace ID 1 (code) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b183e478e0
	lastwindowtitle: omarchy: ~
	ispersistent: 1
	tiledLayout: dwindle


===
Target not found.

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.4s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "ls /usr/share/omarchy/shell/plugins/ 2>&1 | head -n 40; echo \"===\"; ls ~/.config/omarchy/plugins/ 2>&1; echo \"===\"; find /usr/share/omarchy/shell -name \"*workspace*\" 2>&1 | head -n 20"
}
```

**Output:**
```
agents
background
bar
clipboard
dev-gallery
emojis
image-picker
lock
menu
notifications
osd
panels
polkit
README.md
reminders
services
===
akshar.radio-atlas
mb.background
mbhalkar.ctl
===

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.3s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "echo $OMARCHY_PATH; ls /usr/share/omarchy/shell/ 2>&1 | head -n 40; find /usr/share/omarchy -maxdepth 4 -name \"*workspace*\" 2>&1 | head -n 30; omarchy plugin list 2>&1 | head -n 60"
}
```

**Output:**
```
/usr/share/omarchy
Commons
plugins
README.md
services
shell.qml
Ui
/usr/share/omarchy/default/hypr/workspace-layouts.lua
/usr/share/omarchy/bin/omarchy-hyprland-workspace-layout-toggle
ID                               STATE     SOURCE      KINDS              NAME
omarchy.active-window            disabled  first-party bar-widget         Active window
omarchy.agents                   enabled   first-party bar-widget         Agents
omarchy.audio                    enabled   first-party bar-widget         Audio
omarchy.background               enabled   first-party service            Background
omarchy.bar                      enabled   first-party bar                Bar
omarchy.battery                  enabled   first-party service            Battery
omarchy.bluetooth                enabled   first-party bar-widget         Bluetooth
omarchy.clipboard                enabled   first-party overlay            Clipboard
omarchy.clock                    enabled   first-party bar-widget         Clock
mbhalkar.ctl                     enabled   third-party overlay,bar-widget Contextual Tagging & Linking
omarchy.dev-gallery              enabled   first-party panel              Dev gallery
omarchy.disk-speedtest           enabled   first-party panel              Disk speed test
omarchy.monitor                  enabled   first-party bar-widget         Display
omarchy.dropbox                  disabled  first-party bar-widget         Dropbox
omarchy.emojis                   enabled   first-party overlay            Emojis
omarchy.idle                     enabled   first-party service            Idle
omarchy.image-picker             enabled   first-party overlay            Image picker
omarchy.indicators               enabled   first-party bar-widget         Indicators
omarchy.keyboard-layout          enabled   first-party bar-widget         Keyboard layout
omarchy.lock                     enabled   first-party service            Lock Screen
omarchy.media                    disabled  first-party service,bar-widget Media
omarchy.microphone               disabled  first-party bar-widget         Microphone
mb.background                    disabled  third-party service            My Background
omarchy.network                  enabled   first-party bar-widget         Network
omarchy.nightlight               enabled   first-party service            Night Light
omarchy.notifications            enabled   first-party service            Notifications
omarchy.menu                     enabled   first-party menu,bar-widget    Omarchy menu
omarchy.system-update            enabled   first-party bar-widget         Omarchy update
omarchy.osd                      enabled   first-party panel              On-screen display
omarchy.polkit                   enabled   first-party service            Polkit Agent
omarchy.power                    enabled   first-party bar-widget         Power
akshar.radio-atlas               enabled   third-party overlay,bar-widget Radio Atlas
omarchy.reminders                enabled   first-party overlay            Reminders
omarchy.spacer                   disabled  first-party bar-widget         Spacer
omarchy.speedtest                enabled   first-party panel              Speed Test
omarchy.tray                     enabled   first-party bar-widget         System tray
omarchy.tailscale                disabled  first-party bar-widget         Tailscale
omarchy.weather                  enabled   first-party bar-widget         Weather
omarchy.wifiqr                   enabled   first-party panel              Wi-Fi QR
omarchy.workspaces               enabled   first-party bar-widget         Workspaces

```

---

## Assistant (Build · Muse Spark 1.3 Free · 4.0s)

**Tool: bash**

**Input:**
```json
{
  "command": "omarchy plugin info omarchy.workspaces 2>&1; echo \"===\"; find / -maxdepth 6 -type d -name \"omarchy.workspaces\" 2>/dev/null | head -n 5; ls ~/.local/share/omarchy/ 2>&1 | head -n 20"
}
```

**Output:**
```
Unknown Omarchy command: omarchy plugin info omarchy.workspaces
Did you mean: omarchy plugin ?
Run 'omarchy commands --all' to discover available commands.
===
applications
bin
config
default
etc-overrides
icon.png
icon.txt
install
logo.svg
logo.txt
migrations
shell
themes
version

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.1s)

**Tool: bash**

**Input:**
```json
{
  "command": "ls ~/.local/share/omarchy/shell/ 2>&1 | head -n 20; find ~/.local/share/omarchy/shell -maxdepth 3 -name \"*workspace*\" 2>&1 | head -n 20; omarchy plugin --help 2>&1 | head -n 80"
}
```

**Output:**
```
Commons
plugins
README.md
services
shell.qml
Ui
Plugin commands — Omarchy shell plugin and bar widget management:
  omarchy plugin add [git-url] [--enable] [--yes]  Add a shell plugin from git
  omarchy plugin clone <source-id> [--edit]        Clone a built-in Omarchy shell plugin into your own config
  omarchy plugin disable <id>                      Disable a shell plugin
  omarchy plugin enable <id> [placement]           Enable a shell plugin
  omarchy plugin list [--json]                     List discovered shell plugins
  omarchy plugin remove [id] [--yes]               Remove an installed shell plugin
  omarchy plugin update [id] [--yes]               Update installed git-managed plugins
  omarchy plugin validate <plugin-folder>          Validate a plugin folder against the Omarchy plugin manifest schema

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.1s)

**Tool: bash**

**Input:**
```json
{
  "command": "ls ~/.local/share/omarchy/shell/plugins/ 2>&1 | head -n 40; echo \"===\"; find ~/.local/share/omarchy/shell/plugins -maxdepth 2 -iname \"*workspace*\" 2>&1; echo \"===\"; ls /usr/share/omarchy/shell/plugins/ 2>&1 || ls /usr/share/omarchy/default/shell/ 2>&1 | head"
}
```

**Output:**
```
agents
background
bar
clipboard
dev-gallery
emojis
image-picker
lock
menu
notifications
osd
panels
polkit
README.md
reminders
services
===
===
agents
background
bar
clipboard
dev-gallery
emojis
image-picker
lock
menu
notifications
osd
panels
polkit
README.md
reminders
services

```

---

## Assistant (Build · Muse Spark 1.3 Free · 4.1s)

_Thinking:_



The bar config looks standard — digging into how workspace labels render.

**Tool: bash**

**Input:**
```json
{
  "command": "omarchy plugin list --json 2>&1 | python3 -c \"import json,sys; data=json.load(sys.stdin); print('\\n'.join([f\\\"{p.get('id')} -> {p.get('path','?')}\\\" for p in (data if isinstance(data,list) else data.get('plugins',[])) if 'workspace' in p.get('id','')]))\"; echo \"===\"; omarchy plugin list --json 2>&1 | python3 -c \"import json,sys; data=json.load(sys.stdin); ws=[p for p in (data if isinstance(data,list) else data.get('plugins',[])) if 'workspace' in p.get('id','')]; import json as j; print(j.dumps(ws,indent=2))\" 2>&1 | head -n 80"
}
```

**Output:**
```
omarchy.workspaces -> ?
===
[
  {
    "id": "omarchy.workspaces",
    "name": "Workspaces",
    "kinds": [
      "bar-widget"
    ],
    "enabled": true,
    "active": false,
    "canDisable": true,
    "firstParty": true,
    "clonedFrom": ""
  }
]

```

---

## Assistant (Build · Muse Spark 1.3 Free · 5.5s)

**Tool: bash**

**Input:**
```json
{
  "command": "find /usr -type d -name \"*workspaces*\" 2>/dev/null | head -n 10; find / -maxdepth 7 -type f -name \"*.qml\" 2>/dev/null | xargs grep -l \"workspaces\" 2>/dev/null | head -n 10; omarchy commands --json 2>&1 | python3 -c \"import json,sys; d=json.load(sys.stdin); print('\\n'.join([c['route'] for c in d if 'workspace' in c['route'].lower() or 'bar' in c['route'].lower()]))\" 2>&1 | head -n 30"
}
```

**Output:**
```
/usr/lib/node_modules/npm/node_modules/@npmcli/map-workspaces
/usr/share/omarchy/shell/plugins/bar/Bar.qml
/usr/share/omarchy/shell/services/PluginRegistry.qml
/usr/share/omarchy/shell/shell.qml
Traceback (most recent call last):
  File "<string>", line 1, in <module>
    import json,sys; d=json.load(sys.stdin); print('\n'.join([c['route'] for c in d if 'workspace' in c['route'].lower() or 'bar' in c['route'].lower()]))
                                                                                                      ~^^^^^^^^^
TypeError: string indices must be integers, not 'str'

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.2s)

**Tool: bash**

**Input:**
```json
{
  "command": "grep -rn \"workspace\" /usr/share/omarchy/shell/plugins/bar/ 2>&1 | head -n 80; echo \"===\"; ls /usr/share/omarchy/shell/plugins/bar/"
}
```

**Output:**
```
/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.manifest.json:3:  "id": "omarchy.workspaces",
/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml:9:  moduleName: "omarchy.workspaces"
/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml:11:  function workspaceById(id) {
/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml:12:    var values = Hyprland.workspaces.values
/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml:20:  function workspaceIds() {
/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml:22:    var values = Hyprland.workspaces.values
/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml:35:    root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml:47:    columns: root.vertical ? 1 : root.workspaceIds().length
/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml:52:      model: root.workspaceIds()
/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml:57:        readonly property var workspace: root.workspaceById(modelData)
/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml:58:        readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
/usr/share/omarchy/shell/plugins/bar/Bar.qml:723:  // (clock, workspaces, tray) return null. Used by shell.summon/toggle so
/usr/share/omarchy/shell/plugins/bar/README.md:34:        { "id": "omarchy.workspaces" }
/usr/share/omarchy/shell/plugins/bar/README.md:58:| `omarchy.workspaces` | Hyprland workspace switcher | left = focus workspace |
/usr/share/omarchy/shell/plugins/bar/README.md:79:All widgets work in `top`, `bottom`, `left`, and `right` positions. Popups anchor on the side opposite the bar edge, sliding into the workspace. Vertical bars use 28px width; widgets that show text fall back to compact icon-only forms (e.g. `media` hides its scrolling label).
===
BarModel.js
Bar.qml
indicators
manifest.json
README.md
widgets

```

---

## Assistant (Build · Muse Spark 1.3 Free · 11.4s)

_Thinking:_



**Tool: read**

**Input:**
```json
{
  "filePath": "/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml"
}
```

**Output:**
```
<path>/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml</path>
<type>file</type>
<content>
1: import QtQuick
2: import QtQuick.Layouts
3: import Quickshell.Hyprland
4: import qs.Commons
5: import qs.Ui
6: 
7: BarWidget {
8:   id: root
9:   moduleName: "omarchy.workspaces"
10: 
11:   function workspaceById(id) {
12:     var values = Hyprland.workspaces.values
13:     for (var i = 0; i < values.length; i++) {
14:       if (values[i].id === id) return values[i]
15:     }
16: 
17:     return null
18:   }
19: 
20:   function workspaceIds() {
21:     var ids = [1, 2, 3, 4, 5]
22:     var values = Hyprland.workspaces.values
23: 
24:     for (var i = 0; i < values.length; i++) {
25:       var id = values[i].id
26:       if (id > 0 && id <= 10 && ids.indexOf(id) === -1) ids.push(id)
27:     }
28: 
29:     ids.sort(function(left, right) { return left - right })
30:     return ids
31:   }
32: 
33:   function focusWorkspace(id) {
34:     if (!root.bar) return
35:     root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
36:   }
37: 
38:   readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)
39: 
40:   implicitWidth: grid.implicitWidth + trailingGap
41:   implicitHeight: grid.implicitHeight
42: 
43:   GridLayout {
44:     id: grid
45:     anchors.fill: parent
46:     anchors.rightMargin: root.trailingGap
47:     columns: root.vertical ? 1 : root.workspaceIds().length
48:     columnSpacing: root.vertical ? 0 : Style.space(1)
49:     rowSpacing: root.vertical ? Style.space(2) : 0
50: 
51:     Repeater {
52:       model: root.workspaceIds()
53: 
54:       WidgetButton {
55:         required property int modelData
56: 
57:         readonly property var workspace: root.workspaceById(modelData)
58:         readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
59:         readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData
60: 
61:         bar: root.bar
62:         text: focused ? "\uDB85\uDCFB" : (modelData === 10 ? "0" : String(modelData))
63:         opacity: occupied || focused ? 1 : 0.5
64:         horizontalMargin: 6
65:         verticalPadding: 6
66:         fixedWidth: root.vertical ? root.barSize : Style.space(20)
67:         fixedHeight: root.barSize
68:         onPressed: function() { root.focusWorkspace(modelData) }
69:       }
70:     }
71:   }
72: }

(End of file - total 72 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.manifest.json"
}
```

**Output:**
```
<path>/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.manifest.json</path>
<type>file</type>
<content>
1: {
2:   "schemaVersion": 1,
3:   "id": "omarchy.workspaces",
4:   "name": "Workspaces",
5:   "version": "1.0.0",
6:   "author": "Omarchy",
7:   "description": "Workspace number indicators",
8:   "kinds": [
9:     "bar-widget"
10:   ],
11:   "entryPoints": {
12:     "barWidget": "Workspaces.qml"
13:   },
14:   "barWidget": {
15:     "displayName": "Workspaces",
16:     "description": "Workspace number indicators",
17:     "category": "Compositor",
18:     "allowMultiple": false
19:   }
20: }

(End of file - total 20 lines)
</content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 5.7s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "find /usr/share/omarchy/shell -name \"WidgetButton.qml\" | head -n 5; grep -rn \"fixedWidth\\|fixedHeight\\|horizontalMargin\" /usr/share/omarchy/shell/Ui/ 2>&1 | head -n 40"
}
```

**Output:**
```
/usr/share/omarchy/shell/Ui/WidgetButton.qml
/usr/share/omarchy/shell/Ui/BarIconButton.qml:20:  fixedWidth: vertical ? -1 : slotSize
/usr/share/omarchy/shell/Ui/BarIconButton.qml:21:  fixedHeight: vertical ? slotSize : -1
/usr/share/omarchy/shell/Ui/BarIndicator.qml:47:  horizontalMargin: 5
/usr/share/omarchy/shell/Ui/BarIndicator.qml:49:  fixedWidth: vertical ? -1 : Style.bar.statusSlot
/usr/share/omarchy/shell/Ui/BarIndicator.qml:50:  fixedHeight: vertical ? Style.bar.statusSlot : -1
/usr/share/omarchy/shell/Ui/WidgetButton.qml:14:  property real horizontalMargin: 8.5
/usr/share/omarchy/shell/Ui/WidgetButton.qml:16:  property real fixedWidth: -1
/usr/share/omarchy/shell/Ui/WidgetButton.qml:17:  property real fixedHeight: -1
/usr/share/omarchy/shell/Ui/WidgetButton.qml:59:  readonly property real scaledHorizontalMargin: Style.spaceReal(horizontalMargin)
/usr/share/omarchy/shell/Ui/WidgetButton.qml:68:  implicitWidth: fixedWidth > 0 ? fixedWidth : (vertical ? barSize : Math.max(12, label.implicitWidth + scaledHorizontalMargin * 2))
/usr/share/omarchy/shell/Ui/WidgetButton.qml:69:  implicitHeight: fixedHeight > 0 ? fixedHeight : (vertical ? Math.max(12, label.implicitHeight + scaledVerticalPadding * 2) : barSize)

```

---

## Assistant (Build · Muse Spark 1.3 Free · 3.3s)

_Thinking:_



Found it — the bar hardcodes numbers, so I'll clone the widget to show the name.

**Tool: bash**

**Input:**
```json
{
  "command": "omarchy plugin clone omarchy.workspaces 2>&1; echo \"===\"; ls ~/.config/omarchy/plugins/ 2>&1; cat ~/.config/omarchy/shell.json | python3 -m json.tool 2>&1 | head -n 80"
}
```

**Output:**
```
Cloned omarchy.workspaces to /home/mb/.config/omarchy/plugins/mb.workspaces and switched to mb.workspaces
===
akshar.radio-atlas
mb.background
mbhalkar.ctl
mb.workspaces
{
    "bar": {
        "centerAnchor": "omarchy.clock",
        "layout": {
            "center": [
                {
                    "id": "omarchy.indicators"
                },
                {
                    "id": "omarchy.clock",
                    "format": "ddd d MMM h:mm AP",
                    "formatAlt": "d MMMM 'W'ww yyyy",
                    "verticalFormat": "HH\n\u2014\nmm"
                },
                {
                    "id": "omarchy.keyboard-layout"
                },
                {
                    "id": "omarchy.weather"
                },
                {
                    "id": "mbhalkar.ctl"
                },
                {
                    "id": "omarchy.system-update"
                }
            ],
            "left": [
                {
                    "id": "omarchy.menu"
                },
                {
                    "id": "mb.workspaces"
                }
            ],
            "right": [
                {
                    "id": "omarchy.tray"
                },
                {
                    "id": "akshar.radio-atlas"
                },
                {
                    "id": "omarchy.agents"
                },
                {
                    "id": "omarchy.bluetooth"
                },
                {
                    "id": "omarchy.network"
                },
                {
                    "id": "omarchy.audio"
                },
                {
                    "id": "omarchy.monitor"
                },
                {
                    "id": "omarchy.power",
                    "showPercentage": true
                }
            ]
        },
        "position": "top",
        "transparent": false
    },
    "idle": {
        "lock": 300,
        "screensaver": 150
    },
    "plugins": [],
    "version": 1
}

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.0s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "ls -R ~/.config/omarchy/plugins/mb.workspaces/ 2>&1"
}
```

**Output:**
```
/home/mb/.config/omarchy/plugins/mb.workspaces/:
manifest.json
Workspaces.qml

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.1s)

**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml"
}
```

**Output:**
```
<path>/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml</path>
<type>file</type>
<content>
1: import QtQuick
2: import QtQuick.Layouts
3: import Quickshell.Hyprland
4: import qs.Commons
5: import qs.Ui
6: 
7: BarWidget {
8:   id: root
9:   moduleName: "omarchy.workspaces"
10: 
11:   function workspaceById(id) {
12:     var values = Hyprland.workspaces.values
13:     for (var i = 0; i < values.length; i++) {
14:       if (values[i].id === id) return values[i]
15:     }
16: 
17:     return null
18:   }
19: 
20:   function workspaceIds() {
21:     var ids = [1, 2, 3, 4, 5]
22:     var values = Hyprland.workspaces.values
23: 
24:     for (var i = 0; i < values.length; i++) {
25:       var id = values[i].id
26:       if (id > 0 && id <= 10 && ids.indexOf(id) === -1) ids.push(id)
27:     }
28: 
29:     ids.sort(function(left, right) { return left - right })
30:     return ids
31:   }
32: 
33:   function focusWorkspace(id) {
34:     if (!root.bar) return
35:     root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
36:   }
37: 
38:   readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)
39: 
40:   implicitWidth: grid.implicitWidth + trailingGap
41:   implicitHeight: grid.implicitHeight
42: 
43:   GridLayout {
44:     id: grid
45:     anchors.fill: parent
46:     anchors.rightMargin: root.trailingGap
47:     columns: root.vertical ? 1 : root.workspaceIds().length
48:     columnSpacing: root.vertical ? 0 : Style.space(1)
49:     rowSpacing: root.vertical ? Style.space(2) : 0
50: 
51:     Repeater {
52:       model: root.workspaceIds()
53: 
54:       WidgetButton {
55:         required property int modelData
56: 
57:         readonly property var workspace: root.workspaceById(modelData)
58:         readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
59:         readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData
60: 
61:         bar: root.bar
62:         text: focused ? "\uDB85\uDCFB" : (modelData === 10 ? "0" : String(modelData))
63:         opacity: occupied || focused ? 1 : 0.5
64:         horizontalMargin: 6
65:         verticalPadding: 6
66:         fixedWidth: root.vertical ? root.barSize : Style.space(20)
67:         fixedHeight: root.barSize
68:         onPressed: function() { root.focusWorkspace(modelData) }
69:       }
70:     }
71:   }
72: }

(End of file - total 72 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/omarchy/plugins/mb.workspaces/manifest.json"
}
```

**Output:**
```
<path>/home/mb/.config/omarchy/plugins/mb.workspaces/manifest.json</path>
<type>file</type>
<content>
1: {
2:   "schemaVersion": 1,
3:   "id": "mb.workspaces",
4:   "name": "My Workspaces",
5:   "version": "1.0.0",
6:   "author": "Omarchy",
7:   "description": "Workspace number indicators",
8:   "kinds": [
9:     "bar-widget"
10:   ],
11:   "entryPoints": {
12:     "barWidget": "Workspaces.qml"
13:   },
14:   "barWidget": {
15:     "displayName": "My Workspaces",
16:     "description": "Workspace number indicators",
17:     "category": "Compositor",
18:     "allowMultiple": false
19:   },
20:   "omarchy": {
21:     "clonedFrom": "omarchy.workspaces"
22:   }
23: }

(End of file - total 23 lines)
</content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 3.3s)

_Thinking:_



**Tool: edit**

**Input:**
```json
{
  "filePath": "/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml",
  "newString": "        bar: root.bar\n        text: modelData === 1 ? \"code\" : (focused ? \"󰻿\" : (modelData === 10 ? \"0\" : String(modelData)))\n        opacity: occupied || focused ? 1 : 0.5\n        horizontalMargin: 6\n        verticalPadding: 6\n        fixedWidth: modelData === 1 && !root.vertical ? -1 : (root.vertical ? root.barSize : Style.space(20))\n        fixedHeight: root.barSize",
  "oldString": "        bar: root.bar\n        text: focused ? \"󰻿\" : (modelData === 10 ? \"0\" : String(modelData))\n        opacity: occupied || focused ? 1 : 0.5\n        horizontalMargin: 6\n        verticalPadding: 6\n        fixedWidth: root.vertical ? root.barSize : Style.space(20)\n        fixedHeight: root.barSize"
}
```

**Output:**
```
Edit applied successfully.
```

---

## Assistant (Build · Muse Spark 1.3 Free · 4.3s)

_Thinking:_



Custom widget updated — reloading the bar to show "code".

**Tool: bash**

**Input:**
```json
{
  "command": "omarchy plugin validate ~/.config/omarchy/plugins/mb.workspaces 2>&1; echo \"===\"; omarchy-shell shell rescanPlugins 2>&1; sleep 1; echo \"rescan done\""
}
```

**Output:**
```
===
rescan done

```

---

## Assistant (Build · Muse Spark 1.3 Free · 1.9s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "omarchy plugin list 2>&1 | grep -i workspace; echo \"===\"; cat ~/.config/omarchy/plugins/mb.workspaces/Workspaces.qml | head -n 70"
}
```

**Output:**
```
mb.workspaces                    enabled   third-party bar-widget         My Workspaces
omarchy.workspaces               disabled  first-party bar-widget         Workspaces
===
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "omarchy.workspaces"

  function workspaceById(id) {
    var values = Hyprland.workspaces.values
    for (var i = 0; i < values.length; i++) {
      if (values[i].id === id) return values[i]
    }

    return null
  }

  function workspaceIds() {
    var ids = [1, 2, 3, 4, 5]
    var values = Hyprland.workspaces.values

    for (var i = 0; i < values.length; i++) {
      var id = values[i].id
      if (id > 0 && id <= 10 && ids.indexOf(id) === -1) ids.push(id)
    }

    ids.sort(function(left, right) { return left - right })
    return ids
  }

  function focusWorkspace(id) {
    if (!root.bar) return
    root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
  }

  readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)

  implicitWidth: grid.implicitWidth + trailingGap
  implicitHeight: grid.implicitHeight

  GridLayout {
    id: grid
    anchors.fill: parent
    anchors.rightMargin: root.trailingGap
    columns: root.vertical ? 1 : root.workspaceIds().length
    columnSpacing: root.vertical ? 0 : Style.space(1)
    rowSpacing: root.vertical ? Style.space(2) : 0

    Repeater {
      model: root.workspaceIds()

      WidgetButton {
        required property int modelData

        readonly property var workspace: root.workspaceById(modelData)
        readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
        readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData

        bar: root.bar
        text: modelData === 1 ? "code" : (focused ? "󰻿" : (modelData === 10 ? "0" : String(modelData)))
        opacity: occupied || focused ? 1 : 0.5
        horizontalMargin: 6
        verticalPadding: 6
        fixedWidth: modelData === 1 && !root.vertical ? -1 : (root.vertical ? root.barSize : Style.space(20))
        fixedHeight: root.barSize
        onPressed: function() { root.focusWorkspace(modelData) }
      }
    }

```

---

## Assistant (Build · Muse Spark 1.3 Free · 3.2s)

_Thinking:_



Done — your bar will now show **"code"** for workspace 1 instead of **"1"**.

**Why it wasn't showing before:**
- Hyprland already had `workspace ID 1 (code)` from the last step, but `omarchy.workspaces` ignores names:
  ```qml
  // /usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml:62
  text: focused ? "󰻿" : (modelData === 10 ? "0" : String(modelData))
  ```
  It hardcodes numbers, so `code` never appeared.

**What I did (per `plugins.md` — never edit stock, clone instead):**

1. Cloned built-in widget:
   ```
   omarchy plugin clone omarchy.workspaces
   → ~/.config/omarchy/plugins/mb.workspaces/
   → bar auto-switched from `omarchy.workspaces` to `mb.workspaces`
   ```
2. Edited `~/.config/omarchy/plugins/mb.workspaces/Workspaces.qml`:
   ```qml
   text: modelData === 1 ? "code" : (focused ? "󰻿" : (modelData === 10 ? "0" : String(modelData)))
   fixedWidth: modelData === 1 && !root.vertical ? -1 : (root.vertical ? root.barSize : Style.space(20))
   ```
   - Always shows `code` for ws 1 (even when focused, instead of the dot icon)
   - `-1` = auto-width so 4 chars fit; other workspaces keep fixed `Style.space(20)` + `10→0` mapping
3. Hot-reload (auto on save) + forced:
   ```
   omarchy-shell shell rescanPlugins
   ```
   Verified: `mb.workspaces enabled`, `omarchy.workspaces disabled`.

Check the top-left bar — first pill should read `code`. If it doesn't refresh, run `omarchy restart shell`.

---

## User

Will this change survive omarchy upgrade?

---

## Assistant (Plan · Muse Spark 1.3 Free · 6.8s)

_Thinking:_



Good question — checking what survives an upgrade without touching anything.

**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/hypr/hyprland.lua"
}
```

**Output:**
```
<path>/home/mb/.config/hypr/hyprland.lua</path>
<type>file</type>
<content>
1: -- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/
2: 
3: -- Omarchy's bootstrap keeps path setup out of this user config.
4: dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")
5: 
6: -- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
7: -- omarchy_default_bindings = false
8: --
9: -- Or disable only bindings for Omarchy's preinstalled apps/web apps while
10: -- keeping core window-manager bindings:
11: -- omarchy_preinstalled_bindings = false
12: 
13: -- Load Omarchy defaults.
14: require("default.hypr.omarchy")
15: 
16: -- Put your personal overrides in these files. They're loaded after Omarchy's
17: -- defaults so package updates can improve the defaults without rewriting your
18: -- ~/.config/hypr files.
19: require("hypr.monitors")
20: require("hypr.input")
21: require("hypr.bindings")
22: require("hypr.looknfeel")
23: require("hypr.autostart")
24: 
25: -- Toggle config flags dynamically.
26: require("default.hypr.toggles")
27: 
28: -- Add any other personal Hyprland configuration below.
29: -- Workspace 1 named "code" (persistent)
30: hl.workspace_rule({ workspace = "1", default_name = "code", persistent = true })
31: o.window("qemu", { workspace = "5" })

(End of file - total 31 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/omarchy/shell.json"
}
```

**Output:**
```
<path>/home/mb/.config/omarchy/shell.json</path>
<type>file</type>
<content>
1: {
2:   "bar": {
3:     "centerAnchor": "omarchy.clock",
4:     "layout": {
5:       "center": [
6:         {
7:           "id": "omarchy.indicators"
8:         },
9:         {
10:           "id": "omarchy.clock",
11:           "format": "ddd d MMM h:mm AP",
12:           "formatAlt": "d MMMM 'W'ww yyyy",
13:           "verticalFormat": "HH\n—\nmm"
14:         },
15:         {
16:           "id": "omarchy.keyboard-layout"
17:         },
18:         {
19:           "id": "omarchy.weather"
20:         },
21:         {
22:           "id": "mbhalkar.ctl"
23:         },
24:         {
25:           "id": "omarchy.system-update"
26:         }
27:       ],
28:       "left": [
29:         {
30:           "id": "omarchy.menu"
31:         },
32:         {
33:           "id": "mb.workspaces"
34:         }
35:       ],
36:       "right": [
37:         {
38:           "id": "omarchy.tray"
39:         },
40:         {
41:           "id": "akshar.radio-atlas"
42:         },
43:         {
44:           "id": "omarchy.agents"
45:         },
46:         {
47:           "id": "omarchy.bluetooth"
48:         },
49:         {
50:           "id": "omarchy.network"
51:         },
52:         {
53:           "id": "omarchy.audio"
54:         },
55:         {
56:           "id": "omarchy.monitor"
57:         },
58:         {
59:           "id": "omarchy.power",
60:           "showPercentage": true
61:         }
62:       ]
63:     },
64:     "position": "top",
65:     "transparent": false
66:   },
67:   "idle": {
68:     "lock": 300,
69:     "screensaver": 150
70:   },
71:   "plugins": [],
72:   "version": 1
73: }

(End of file - total 73 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/omarchy/plugins/mb.workspaces/manifest.json"
}
```

**Output:**
```
<path>/home/mb/.config/omarchy/plugins/mb.workspaces/manifest.json</path>
<type>file</type>
<content>
1: {
2:   "schemaVersion": 1,
3:   "id": "mb.workspaces",
4:   "name": "My Workspaces",
5:   "version": "1.0.0",
6:   "author": "Omarchy",
7:   "description": "Workspace number indicators",
8:   "kinds": [
9:     "bar-widget"
10:   ],
11:   "entryPoints": {
12:     "barWidget": "Workspaces.qml"
13:   },
14:   "barWidget": {
15:     "displayName": "My Workspaces",
16:     "description": "Workspace number indicators",
17:     "category": "Compositor",
18:     "allowMultiple": false
19:   },
20:   "omarchy": {
21:     "clonedFrom": "omarchy.workspaces"
22:   }
23: }

(End of file - total 23 lines)
</content>
```

---

## Assistant (Plan · Muse Spark 1.3 Free · 9.3s)

_Thinking:_



**Tool: glob**

**Input:**
```json
{
  "path": "/usr/share/omarchy",
  "pattern": "**/omarchy-update*"
}
```

**Output:**
```
No files found
```

**Tool: grep**

**Input:**
```json
{
  "include": "*.md",
  "path": "/home/mb/.agents/skills/omarchy",
  "pattern": "update|survive|overwrite|refresh|reinstall|migration"
}
```

**Output:**
```
Found 28 matches
/usr/share/omarchy/default/agents/skills/omarchy/theming.md:
  Line 48: on update. Two safe options:


/usr/share/omarchy/default/agents/skills/omarchy/plugins.md:
  Line 18: **Commands:** `omarchy restart shell`, `omarchy refresh shell`

  Line 42: which is yours to edit and survives updates.


/usr/share/omarchy/default/agents/skills/omarchy/hyprland.md:
  Line 26: - Use `omarchy refresh hyprland` to reset the Lua config files to defaults

  Line 30: - `hyprsunset.conf` (night light): apply changes with `omarchy restart hyprsunset`; reset with `omarchy refresh hyprsunset`


/usr/share/omarchy/default/agents/skills/omarchy/hooks.md:
  Line 4: updates, boot, low battery, etc.).

  Line 17: ├── post-update.d/          # During `omarchy update`, after system packages and migrations

  Line 18: ├── pre-refresh-pacman.d/   # Before `omarchy refresh pacman` re-syncs packages


/usr/share/omarchy/default/agents/skills/omarchy/SKILL.md:
  Line 32: - User-facing `omarchy` commands (`omarchy theme ...`, `omarchy refresh ...`, `omarchy restart ...`, etc.)

  Line 37: **Do NOT use this skill for Omarchy development tasks** (editing the Omarchy source tree, creating migrations, or running `omarchy dev ...` workflows).

  Line 58: overwritten on the next `omarchy update`.

  Line 67: ├── migrations/             # Update migrations

  Line 119: omarchy refresh --help

  Line 138: | `omarchy refresh` | Reset config to defaults (backs up first) | `omarchy refresh shell` |

  Line 151: | `omarchy update` | System updates | `omarchy update` |

  Line 208: omarchy refresh shell

  Line 209: omarchy refresh hyprland

  Line 211: # The refresh command:

  Line 214: # 3. Restarts the component where the refresh needs it (e.g. `refresh shell`)

  Line 220: omarchy update                  # Full system update

  Line 237: omarchy refresh <app>

  Line 241: # eg. `omarchy refresh config hypr/hyprland.lua` will refresh ~/.config/hypr/hyprland.lua

  Line 242: omarchy refresh config <config-file>

  Line 244: # Full reinstall of configs (nuclear option)

  Line 245: omarchy reinstall

  Line 274: - Editing files in `/usr/share/omarchy/` (`bin/`, `config/`, `default/`, `shell/`, `themes/`, `migrations/`, etc.)

  Line 275: - Creating or editing migrations

  Line 292: - "Reset shell/bar to defaults" -> `omarchy refresh shell`

```

---

## Assistant (Plan · Muse Spark 1.3 Free · 2.5s)

_Thinking:_



**Tool: read**

**Input:**
```json
{
  "filePath": "/usr/share/omarchy/default/agents/skills/omarchy/plugins.md"
}
```

**Output:**
```
<path>/usr/share/omarchy/default/agents/skills/omarchy/plugins.md</path>
<type>file</type>
<content>
1: # Omarchy Shell: Bar, Plugins, and Idle
2: 
3: Read this before changing the status bar, notifications, shell plugins,
4: widgets, or idle/lock behavior.
5: 
6: The bar, notification daemon, settings panel, and assorted overlays all run
7: inside a single long-running Quickshell process (`omarchy-shell`).
8: 
9: ```
10: ~/.config/omarchy/shell.json             # User overrides: bar, plugins, idle
11: ~/.config/omarchy/plugins/<plugin-id>/   # User-owned shell plugins
12: $OMARCHY_PATH/config/omarchy/shell.json  # Canonical defaults
13: ```
14: 
15: The shell hot-reloads `shell.json` on save — no restart needed for layout
16: changes. `idle.screensaver` and `idle.lock` are seconds since user idle began.
17: 
18: **Commands:** `omarchy restart shell`, `omarchy refresh shell`
19: 
20: ## Bar Layout
21: 
22: Use the `omarchy bar` group to move and manage widgets:
23: 
24: ```bash
25: omarchy bar move omarchy.clock --section right
26: ```
27: 
28: For layout edits beyond what the commands cover, edit the bar configuration
29: in `~/.config/omarchy/shell.json`; it hot-reloads on save.
30: 
31: ## Customizing Built-In Plugins and Widgets
32: 
33: To customize a built-in bar widget, never edit `$OMARCHY_PATH/shell/plugins/`.
34: Clone it into the user plugin directory instead:
35: 
36: ```bash
37: omarchy plugin clone omarchy.workspaces
38: # Edit ~/.config/omarchy/plugins/<username>.workspaces/; saved changes reload automatically.
39: ```
40: 
41: Cloning switches the bar to the cloned copy (e.g. `<username>.workspaces`),
42: which is yours to edit and survives updates.
43: 
44: Saving a file anywhere under `~/.config/omarchy/plugins/` reloads plugin code
45: automatically. If a change somehow fails to apply, force a reload with
46: `omarchy-shell shell rescanPlugins`.
47: 
48: ## Idle and Lock
49: 
50: Set `idle.screensaver` and `idle.lock` in `~/.config/omarchy/shell.json`,
51: in seconds since user idle began. Example: "lock after ten minutes" means
52: setting `idle.lock` to `600`.

(End of file - total 52 lines)
</content>
```

**Tool: glob**

**Input:**
```json
{
  "path": "/usr/share/omarchy/bin",
  "pattern": "*update*"
}
```

**Output:**
```
No files found
```

**Tool: glob**

**Input:**
```json
{
  "path": "/usr/share/omarchy",
  "pattern": "migrations/*"
}
```

**Output:**
```
/usr/share/omarchy/migrations/1788848726.sh
/usr/share/omarchy/migrations/1788745941.sh
/usr/share/omarchy/migrations/1788724825.sh
/usr/share/omarchy/migrations/1788662350.sh
/usr/share/omarchy/migrations/1788619462.sh
/usr/share/omarchy/migrations/1788577553.sh
/usr/share/omarchy/migrations/1788124236.sh
/usr/share/omarchy/migrations/1788112314.sh
/usr/share/omarchy/migrations/1788102906.sh
/usr/share/omarchy/migrations/1788025225.sh
/usr/share/omarchy/migrations/1788009111.sh
/usr/share/omarchy/migrations/1787865477.sh
/usr/share/omarchy/migrations/1787843905.sh
/usr/share/omarchy/migrations/1787815267.sh
/usr/share/omarchy/migrations/1787760281.sh
/usr/share/omarchy/migrations/1787691200.sh
/usr/share/omarchy/migrations/1787618700.sh
/usr/share/omarchy/migrations/1787589206.sh
/usr/share/omarchy/migrations/1787580187.sh
/usr/share/omarchy/migrations/1787515927.sh
/usr/share/omarchy/migrations/1787494718.sh
/usr/share/omarchy/migrations/1787481315.sh
/usr/share/omarchy/migrations/1787399318.sh
/usr/share/omarchy/migrations/1787215483.sh
/usr/share/omarchy/migrations/1787133200.sh
/usr/share/omarchy/migrations/1786952219.sh
/usr/share/omarchy/migrations/1786782461.sh
/usr/share/omarchy/migrations/1786643346.sh
/usr/share/omarchy/migrations/1786605598.sh
/usr/share/omarchy/migrations/1786567036.sh
/usr/share/omarchy/migrations/1786549201.sh
/usr/share/omarchy/migrations/1786539345.sh
/usr/share/omarchy/migrations/1786517850.sh
/usr/share/omarchy/migrations/1786482992.sh
/usr/share/omarchy/migrations/1786451567.sh
/usr/share/omarchy/migrations/1786447584.sh
/usr/share/omarchy/migrations/1786391100.sh
/usr/share/omarchy/migrations/1786386460.sh
/usr/share/omarchy/migrations/1786380259.sh
/usr/share/omarchy/migrations/1786355450.sh
/usr/share/omarchy/migrations/1786279107.sh
/usr/share/omarchy/migrations/1786278735.sh
/usr/share/omarchy/migrations/1786273938.sh
/usr/share/omarchy/migrations/1786183928.sh
/usr/share/omarchy/migrations/1786181929.sh
/usr/share/omarchy/migrations/1786137597.sh
/usr/share/omarchy/migrations/1786099804.sh
/usr/share/omarchy/migrations/1786098807.sh
/usr/share/omarchy/migrations/1785944594.sh
/usr/share/omarchy/migrations/1785846769.sh
/usr/share/omarchy/migrations/1785637426.sh
/usr/share/omarchy/migrations/1785633225.sh
/usr/share/omarchy/migrations/1785617047.sh
/usr/share/omarchy/migrations/1785608251.sh
/usr/share/omarchy/migrations/1785608166.sh
/usr/share/omarchy/migrations/1785591762.sh
/usr/share/omarchy/migrations/1785543725.sh
/usr/share/omarchy/migrations/1785511354.sh
/usr/share/omarchy/migrations/1785424256.sh
/usr/share/omarchy/migrations/1785351479.sh
/usr/share/omarchy/migrations/1785344985.sh
/usr/share/omarchy/migrations/1785273276.sh
/usr/share/omarchy/migrations/1785189600.sh
/usr/share/omarchy/migrations/1785167800.sh
/usr/share/omarchy/migrations/1785166747.sh
/usr/share/omarchy/migrations/1785101000.sh
/usr/share/omarchy/migrations/1785095882.sh
/usr/share/omarchy/migrations/1785090473.sh
/usr/share/omarchy/migrations/1785013000.sh
/usr/share/omarchy/migrations/1785002349.sh
/usr/share/omarchy/migrations/1784989000.sh
/usr/share/omarchy/migrations/1784970000.sh
/usr/share/omarchy/migrations/1784961000.sh
/usr/share/omarchy/migrations/1784960000.sh
/usr/share/omarchy/migrations/1784917531.sh
/usr/share/omarchy/migrations/1784914435.sh
/usr/share/omarchy/migrations/1784909971.sh
/usr/share/omarchy/migrations/1784818437.sh
/usr/share/omarchy/migrations/1784809452.sh
/usr/share/omarchy/migrations/1784767406.sh
/usr/share/omarchy/migrations/1784763917.sh
/usr/share/omarchy/migrations/1784672586.sh
/usr/share/omarchy/migrations/1784568652.sh
/usr/share/omarchy/migrations/1784521870.sh
/usr/share/omarchy/migrations/1784510887.sh
/usr/share/omarchy/migrations/1784508556.sh
/usr/share/omarchy/migrations/1784479832.sh
/usr/share/omarchy/migrations/1784476564.sh
/usr/share/omarchy/migrations/1784401744.sh
/usr/share/omarchy/migrations/1782049344.sh
/usr/share/omarchy/migrations/1782002156.sh
/usr/share/omarchy/migrations/1781984677.sh
/usr/share/omarchy/migrations/1781793381.sh
/usr/share/omarchy/migrations/1781587663.sh
/usr/share/omarchy/migrations/1781485962.sh
/usr/share/omarchy/migrations/1780517689.sh
/usr/share/omarchy/migrations/1780294774.sh
/usr/share/omarchy/migrations/1780057136.sh
/usr/share/omarchy/migrations/1778623107.sh
/usr/share/omarchy/migrations/1781286586.sh

(Results are truncated: showing first 100 results. Consider using a more specific path or pattern.)
```

---

## Assistant (Plan · Muse Spark 1.3 Free · 4.7s)

_Thinking:_



**Tool: grep**

**Input:**
```json
{
  "path": "/usr/share/omarchy/migrations",
  "pattern": "workspaces|shell\\.json|hyprland\\.lua|mb\\.workspaces"
}
```

**Output:**
```
Found 9 matches
/usr/share/omarchy/migrations/1786099804.sh:
  Line 12: config_file="$HOME/.config/omarchy/shell.json"


/usr/share/omarchy/migrations/1781063758.sh:
  Line 3: hyprland_config="$HOME/.config/hypr/hyprland.lua"


/usr/share/omarchy/migrations/1781043107.sh:
  Line 55:   local file="$HOME/.config/hypr/hyprland.lua"

  Line 81:   "$HOME/.config/hypr/hyprland.lua" \


/usr/share/omarchy/migrations/1780294774.sh:
  Line 3: config_file="$HOME/.config/omarchy/shell.json"


/usr/share/omarchy/migrations/1787481315.sh:
  Line 3: # A theme installed from a repo could ship hyprland.lua, gum_env.lua, neovim.lua


/usr/share/omarchy/migrations/1785344985.sh:
  Line 9: config_file="$HOME/.config/omarchy/shell.json"


/usr/share/omarchy/migrations/1784989000.sh:
  Line 3: config_file="$HOME/.config/omarchy/shell.json"


/usr/share/omarchy/migrations/1785189600.sh:
  Line 84: config_file="$HOME/.config/omarchy/shell.json"

```

---

## Assistant (Plan · Muse Spark 1.3 Free · 1.7s)

_Thinking:_



**Tool: read**

**Input:**
```json
{
  "filePath": "/usr/share/omarchy/migrations/1781063758.sh"
}
```

**Output:**
```
<path>/usr/share/omarchy/migrations/1781063758.sh</path>
<type>file</type>
<content>
1: echo "Update Hyprland Lua entrypoint to load Omarchy bootstrap"
2: 
3: hyprland_config="$HOME/.config/hypr/hyprland.lua"
4: 
5: if [[ -f $hyprland_config ]] && ! grep -Fq '/default/hypr/bootstrap.lua' "$hyprland_config"; then
6:   tmp=$(mktemp)
7: 
8:   awk '
9:     BEGIN {
10:       replaced = 0
11:     }
12: 
13:     !replaced && $0 == "-- Load user modules from ~/.config and Omarchy defaults from $OMARCHY_PATH." {
14:       comment = $0
15:       got_next = getline next_line
16:       if (got_next > 0 && next_line == "package.path = os.getenv(\"HOME\")") {
17:         print "-- Omarchy'\''s bootstrap keeps path setup out of this user config."
18:         print "dofile((os.getenv(\"OMARCHY_PATH\") or \"/usr/share/omarchy\") .. \"/default/hypr/bootstrap.lua\")"
19:         replaced = 1
20: 
21:         while ((getline line) > 0) {
22:           if (line ~ /^[[:space:]]*\.\. package\.path$/) {
23:             break
24:           }
25:         }
26: 
27:         next
28:       }
29: 
30:       print comment
31:       if (got_next > 0) {
32:         print next_line
33:       }
34:       next
35:     }
36: 
37:     { print }
38:   ' "$hyprland_config" >"$tmp"
39: 
40:   mv "$tmp" "$hyprland_config"
41: fi

(End of file - total 41 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/usr/share/omarchy/migrations/1781043107.sh"
}
```

**Output:**
```
<path>/usr/share/omarchy/migrations/1781043107.sh</path>
<type>file</type>
<content>
1: echo "Move current Omarchy theme state to ~/.local/state"
2: 
3: legacy_current_dir="$HOME/.config/omarchy/current"
4: current_state_dir="$HOME/.local/state/omarchy/current"
5: 
6: mkdir -p "$HOME/.local/state/omarchy"
7: 
8: if [[ -e $legacy_current_dir || -L $legacy_current_dir ]]; then
9:   if [[ ! -e $current_state_dir && ! -L $current_state_dir ]]; then
10:     mv "$legacy_current_dir" "$current_state_dir"
11:   else
12:     if [[ -d $legacy_current_dir && -d $current_state_dir ]]; then
13:       cp -an "$legacy_current_dir/." "$current_state_dir/" 2>/dev/null || true
14:     fi
15:     rm -rf "$legacy_current_dir"
16:   fi
17: fi
18: 
19: replace_literal_in_file() {
20:   local file="$1"
21:   local old="$2"
22:   local new="$3"
23:   local tmp
24: 
25:   grep -Fq -- "$old" "$file" || return 0
26: 
27:   tmp=$(mktemp)
28:   OLD="$old" NEW="$new" awk '
29:     BEGIN {
30:       old = ENVIRON["OLD"]
31:       new = ENVIRON["NEW"]
32:     }
33:     {
34:       while ((pos = index($0, old)) > 0) {
35:         $0 = substr($0, 1, pos - 1) new substr($0, pos + length(old))
36:       }
37:       print
38:     }
39:   ' "$file" >"$tmp"
40:   cat "$tmp" >"$file"
41:   rm -f "$tmp"
42: }
43: 
44: replace_current_path() {
45:   local file="$1"
46: 
47:   [[ -f $file ]] || return 0
48: 
49:   replace_literal_in_file "$file" "$HOME/.config/omarchy/current" "$HOME/.local/state/omarchy/current"
50:   replace_literal_in_file "$file" "~/.config/omarchy/current" "~/.local/state/omarchy/current"
51:   replace_literal_in_file "$file" "../omarchy/current" "../../.local/state/omarchy/current"
52: }
53: 
54: ensure_hyprland_state_path() {
55:   local file="$HOME/.config/hypr/hyprland.lua"
56:   local tmp
57: 
58:   [[ -f $file ]] || return 0
59:   grep -Fq '/.local/state/?.lua;' "$file" && return 0
60:   grep -Fq '/default/hypr/bootstrap.lua' "$file" && return 0
61:   grep -Fq '  .. "/.config/?.lua;"' "$file" || return 0
62: 
63:   tmp=$(mktemp)
64:   awk '
65:     !inserted && $0 == "  .. \"/.config/?.lua;\"" {
66:       print "  .. \"/.local/state/?.lua;\""
67:       print "  .. os.getenv(\"HOME\")"
68:       inserted = 1
69:     }
70:     { print }
71:   ' "$file" >"$tmp"
72:   cat "$tmp" >"$file"
73:   rm -f "$tmp"
74: }
75: 
76: for file in \
77:   "$HOME/.config/alacritty/alacritty.toml" \
78:   "$HOME/.config/foot/foot.ini" \
79:   "$HOME/.config/ghostty/config" \
80:   "$HOME/.config/hypr/hyprland.conf" \
81:   "$HOME/.config/hypr/hyprland.lua" \
82:   "$HOME/.config/hyprland-preview-share-picker/config.yaml" \
83:   "$HOME/.config/kitty/kitty.conf"; do
84:   replace_current_path "$file"
85: done
86: 
87: ensure_hyprland_state_path
88: 
89: relink_current_symlink() {
90:   local link="$1"
91:   local target suffix
92: 
93:   [[ -L $link ]] || return 0
94:   target=$(readlink "$link") || return 0
95: 
96:   case "$target" in
97:     "$legacy_current_dir"/*)
98:       suffix=${target#"$legacy_current_dir"/}
99:       ln -sfn "$current_state_dir/$suffix" "$link"
100:       ;;
101:     "~/.config/omarchy/current/"*)
102:       # The filesystem never expands a literal ~ in a symlink target, so keep
103:       # $HOME out of the quoted string and let the shell expand it instead.
104:       suffix=${target#"~/.config/omarchy/current/"}
105:       ln -sfn "$current_state_dir/$suffix" "$link"
106:       ;;
107:   esac
108: }
109: 
110: for link in \
111:   "$HOME/.config/btop/themes/current.theme" \
112:   "$HOME/.config/helix/themes/omarchy.toml" \
113:   "$HOME/.vscode/extensions/omarchy-theme/themes/omarchy-color-theme.json" \
114:   "$HOME/.vscode-insiders/extensions/omarchy-theme/themes/omarchy-color-theme.json" \
115:   "$HOME/.vscode-oss/extensions/omarchy-theme/themes/omarchy-color-theme.json" \
116:   "$HOME/.cursor/extensions/omarchy-theme/themes/omarchy-color-theme.json"; do
117:   relink_current_symlink "$link"
118: done

(End of file - total 118 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/usr/share/omarchy/migrations/1786099804.sh"
}
```

**Output:**
```
<path>/usr/share/omarchy/migrations/1786099804.sh</path>
<type>file</type>
<content>
1: echo "Rename the model usage widget to agents and prime its data files"
2: 
3: # The widget formerly known as omarchy.model-usage is now omarchy.agents, and
4: # it no longer scans providers itself: it displays the records that
5: # omarchy-agent-usage-update writes under ~/.local/state/omarchy/agents/usage/.
6: # Rename the widget wherever a user's config mentions it — bar layout entries
7: # keep their settings, a disabled widget stays disabled — then generate the
8: # records once so the bar doesn't sit empty until the widget's first refresh
9: # timer, and drop the old scanner's cache directory, which nothing reads
10: # anymore.
11: 
12: config_file="$HOME/.config/omarchy/shell.json"
13: 
14: if [[ -s $config_file ]]; then
15:   tmp=$(mktemp)
16:   jq '
17:     def rename:
18:       if . == "omarchy.model-usage" then
19:         "omarchy.agents"
20:       elif type == "object" and .id == "omarchy.model-usage" then
21:         .id = "omarchy.agents"
22:       else
23:         .
24:       end;
25: 
26:     (if (.bar.layout? | type) == "object" then
27:       .bar.layout |= map_values(if type == "array" then map(rename) else . end)
28:     else . end)
29:     | (if (.disabledPlugins? | type) == "array" then
30:       .disabledPlugins |= map(rename)
31:     else . end)
32:   ' "$config_file" >"$tmp" && mv "$tmp" "$config_file" || rm -f "$tmp"
33: fi
34: 
35: rm -rf "$HOME/.cache/omarchy/model-usage"
36: 
37: omarchy-agent-usage-update || true

(End of file - total 37 lines)
</content>
```

---

## Assistant (Plan · Muse Spark 1.3 Free · 20.7s)

_Thinking:_



Yes — all 3 changes survive `omarchy update` by design:

**1. `~/.config/hypr/hyprland.lua:30`**
```lua
hl.workspace_rule({ workspace = "1", default_name = "code", persistent = true })
```
* File header itself says: `They're loaded after Omarchy's defaults so package updates can improve the defaults without rewriting your ~/.config/hypr files.`
* `update` only overwrites `/usr/share/omarchy/` (package-owned). I checked migrations that touch this file (`1781063758.sh`, `1781043107.sh`) — they do surgical `awk` inserts for bootstrap/state paths, not wipes.

**2. `~/.config/omarchy/plugins/mb.workspaces/Workspaces.qml`**
* `plugins.md:42`: `which is yours to edit and survives updates.`
* This is the whole point of `omarchy plugin clone` vs editing `$OMARCHY_PATH/shell/plugins/`.

**3. `~/.config/omarchy/shell.json:33` (`mb.workspaces`)**
* User overrides vs `$OMARCHY_PATH/config/omarchy/shell.json` canonical defaults. Migrations that touch it (`1786099804.sh`, etc.) use `jq` to rename single IDs in-place and preserve your layout/settings — your `mb.workspaces` ID isn't touched.

**What *would* wipe it (don't run without backup):**
* `omarchy refresh hyprland / shell` — backs up then copies defaults
* `omarchy reinstall` — nuclear option
* `omarchy refresh config hypr/hyprland.lua`

**Two real caveats:**

1. **Clone drift:** upstream `omarchy.workspaces` bugfixes/new features won't auto-flow to `mb.workspaces`. If the bar breaks after a big update, diff against `/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml` and re-merge, or re-clone.
2. **Runtime rename alone wouldn't survive** — but you don't rely on it. `persistent:true + default_name:"code"` recreates `ID 1 (code)` on every reload/reboot. The `hyprctl eval ...rename...` I ran was just to apply it live without logging out.

You already have `hyprland.lua.bak.*` from before the edit. If you want extra safety, back up `shell.json` + `mb.workspaces/` the same way — but `update` won't touch them.


---

## User

I want to visually display "browser" for workspace 2
and "terminal" for workspace 3 and "youtube" for workspace 0

---

## Assistant (Build · Muse Spark 1.3 Free · 4.8s)

_Thinking:_



Adding the rest — browser, terminal, and youtube workspaces.

**Tool: skill**

**Input:**
```json
{
  "name": "omarchy"
}
```

**Output:**
```
<skill_content name="omarchy">
# Skill: omarchy

# Omarchy Skill

Manage [Omarchy](https://omarchy.org/) Linux systems - a beautiful, modern, opinionated Arch Linux distribution with Hyprland.

This skill is for end-user customization on installed systems.
It is not for contributing to Omarchy source code.

## When This Skill MUST Be Used

**ALWAYS invoke this skill for end-user requests involving ANY of these:**

- Editing ANY file in `~/.config/hypr/` (window rules, animations, keybindings, monitors, etc.)
- Editing `~/.config/omarchy/shell.json` (status bar layout, widgets)
- Editing terminal configs (alacritty, foot, kitty, ghostty)
- Editing ANY file in `~/.config/omarchy/`
- Window behavior, animations, opacity, blur, gaps, borders
- Layer rules, workspace settings, display/monitor configuration
- Themes, backgrounds, fonts, appearance changes
- User-facing `omarchy` commands (`omarchy theme ...`, `omarchy refresh ...`, `omarchy restart ...`, etc.)
- Screenshots, screen recording, reminders, night light, idle behavior, lock screen

**If you're about to edit a config file in ~/.config/ on this system, STOP and use this skill first.**

**Do NOT use this skill for Omarchy development tasks** (editing the Omarchy source tree, creating migrations, or running `omarchy dev ...` workflows).

## Topic Guides

Deeper instructions for common areas live next to this file. Read the
matching guide before starting:

- [`hyprland.md`](hyprland.md) - keybindings, monitors, window rules, and other Hyprland config
- [`plugins.md`](plugins.md) - the Omarchy shell: bar layout, widgets, plugins, idle behavior
- [`theming.md`](theming.md) - themes, backgrounds, and fonts
- [`hooks.md`](hooks.md) - automation hooks that run on system events
- [`capture.md`](capture.md) - screenshots, screen recordings, OCR text capture, and file sharing
- [`contributing.md`](contributing.md) - reporting Omarchy bugs and submitting fixes upstream

## Critical Safety Rules

For privileged commands, follow the Privilege Escalation rules below: `sudo` when a terminal is available for the password prompt, `pkexec` when it is not. Do not wrap commands that already manage privilege elevation themselves.

**For end-user customization tasks, NEVER modify anything in `/usr/share/omarchy/`** - but READING is safe and encouraged.

This directory is owned by the omarchy package. Any local changes will be
overwritten on the next `omarchy update`.

```
/usr/share/omarchy/     # READ-ONLY - NEVER EDIT (reading is OK)
├── bin/                    # Command source (packaged binaries are on PATH)
├── config/                 # Default config templates
├── themes/                 # Stock themes
├── default/                # System defaults
├── shell/                  # Omarchy shell source and defaults
├── migrations/             # Update migrations
└── install/                # Installation scripts
```

**Reading `/usr/share/omarchy/` is SAFE and useful** - do it freely to:
- Understand how omarchy commands work: `omarchy theme set --help` or `cat $(which omarchy-theme-set)`
- See default configs before customizing: `cat "$OMARCHY_PATH/config/omarchy/shell.json"`
- Check stock theme files to copy for customization
- Reference default hyprland settings: `cat /usr/share/omarchy/default/hypr/*`

**Always use these safe locations instead:**
- `~/.config/` - User configuration (safe to edit)
- `~/.config/omarchy/themes/<custom-name>/` - Custom themes
- `~/.config/omarchy/hooks/` - Custom automation hooks

If the request is to develop Omarchy itself, this skill is out of scope. Follow repository development instructions instead of this skill.

## Privilege Escalation

For an interactive script or command run in a visible terminal, use `sudo` for
privileged work. Omarchy may grant passwordless `sudo` access to particular
commands, and the terminal is the appropriate place to request a password
when one is needed.

Use `pkexec` only when the caller cannot interact with a terminal or cannot
enter a password there, such as a command launched by an agent or a graphical
background process. Do not replace `sudo` with `pkexec` merely because a
command changes system state.

## System Architecture

Omarchy is built on:

| Component | Purpose | Config Location |
|-----------|---------|-----------------|
| **Arch Linux** | Base OS | `/etc/`, `~/.config/` |
| **Hyprland** | Wayland compositor/WM | `~/.config/hypr/` |
| **Omarchy shell** | Status bar + notifications (Quickshell) | `~/.config/omarchy/shell.json` |
| **Launcher/menus** | Quickshell menu | `~/.config/omarchy/extensions/omarchy-menu.jsonc` |
| **Alacritty/Foot/Kitty/Ghostty** | Terminals | `~/.config/<terminal>/` |
| **Omarchy OSD** | On-screen display | Quickshell plugin |

## Command Discovery

Omarchy ships a single `omarchy` CLI that dispatches to all `omarchy-*` binaries via `omarchy <group> <action>`. Always prefer this form — it is self-documenting and stable. The underlying `omarchy-*` binaries still exist on `PATH` and remain safe to read for source.

```bash
# List every documented command and its summary (--all includes hidden commands)
omarchy commands

# Show the commands inside a group
omarchy theme --help
omarchy refresh --help
omarchy restart --help

# Show help for a specific command (does not execute it)
omarchy theme set --help

# Machine-readable listing (binary, route, summary, args, aliases)
omarchy commands --json

# Read a command's source to understand it
cat $(which omarchy-theme-set)
```

### Command Groups

Run `omarchy --help` for the full list. The most common groups:

| Group | Purpose | Example |
|-------|---------|---------|
| `omarchy refresh` | Reset config to defaults (backs up first) | `omarchy refresh shell` |
| `omarchy restart` | Restart a service/app | `omarchy restart shell` |
| `omarchy toggle` | Toggle feature on/off | `omarchy toggle nightlight` |
| `omarchy theme` | Theme management | `omarchy theme set <name>` |
| `omarchy bar` | Bar layout and widgets | `omarchy bar move omarchy.clock --section right` |
| `omarchy plugin` | Manage/clone shell plugins | `omarchy plugin clone omarchy.clock` |
| `omarchy hook` | Install automation hooks | `omarchy hook install theme-set <script>` |
| `omarchy install` | Install optional software / packages | `omarchy install docker dbs` |
| `omarchy launch` | Launch apps | `omarchy launch browser` |
| `omarchy capture` | Screenshots and recordings | `omarchy capture screenshot` |
| `omarchy reminder` | Desktop notification reminders | `omarchy reminder 15 "Pickup Jack"` |
| `omarchy pkg` | Package management | `omarchy pkg add <pkg>` |
| `omarchy setup` | Interactive setup wizards | `omarchy setup security fingerprint` |
| `omarchy update` | System updates | `omarchy update` |

## Configuration Locations

Hyprland config lives in `~/.config/hypr/` — see [`hyprland.md`](hyprland.md).
The Omarchy shell (bar, notifications, plugins, idle) is configured in
`~/.config/omarchy/shell.json` — see [`plugins.md`](plugins.md).

### Terminals

```
~/.config/alacritty/alacritty.toml
~/.config/foot/foot.ini
~/.config/kitty/kitty.conf
~/.config/ghostty/config
```

**Command:** `omarchy restart terminal`

### Other Configs

| App | Location |
|-----|----------|
| btop | `~/.config/btop/btop.conf` |
| fastfetch | `/etc/fastfetch/config.jsonc` default; `~/.config/fastfetch/config.jsonc` user override |
| lazygit | `~/.config/lazygit/config.yml` |
| starship | `~/.config/starship.toml` |
| git | `~/.config/git/config` |

## Safe Customization Patterns

### Edit User Config Directly

For simple changes, edit files in `~/.config/`:

```bash
# 1. Read current config
cat ~/.config/hypr/bindings.lua

# 2. Backup before changes
cp ~/.config/hypr/bindings.lua ~/.config/hypr/bindings.lua.bak.$(date +%s)

# 3. Make changes with Edit tool

# 4. Apply changes
# - Hyprland: auto-reloads on save, but MUST validate with `hyprctl reload` and `hyprctl configerrors`
# - Omarchy shell: shell.json and user plugin code under ~/.config/omarchy/plugins/ hot-reload on save
# - Menus/launcher: ~/.config/omarchy/extensions/omarchy-menu.jsonc hot-reloads on save
# - Terminals: apply with `omarchy restart terminal` (reloads running terminals; foot picks changes up in new windows)
```

### Reset to Defaults -- ALWAYS SEEK USER CONFIRMATION BEFORE RUNNING

When customizations go wrong:

```bash
# Reset specific config (creates backup automatically)
omarchy refresh shell
omarchy refresh hyprland

# The refresh command:
# 1. Backs up current config with timestamp
# 2. Copies default from $OMARCHY_PATH/config/
# 3. Restarts the component where the refresh needs it (e.g. `refresh shell`)
```

## System Commands

```bash
omarchy update                  # Full system update
omarchy version                 # Show Omarchy version
omarchy debug --no-sudo --print # Debug info (ALWAYS use these flags)
omarchy system lock             # Lock screen
omarchy system shutdown         # Shutdown
omarchy system reboot           # Reboot
```

**IMPORTANT:** Always run `omarchy debug` with `--no-sudo --print` flags to avoid interactive sudo prompts that will hang the terminal.

## Troubleshooting

```bash
# Get debug information (ALWAYS use these flags to avoid interactive prompts)
omarchy debug --no-sudo --print

# Reset specific config to defaults
omarchy refresh <app>

# Refresh specific config file
# config-file path is relative to ~/.config/
# eg. `omarchy refresh config hypr/hyprland.lua` will refresh ~/.config/hypr/hyprland.lua
omarchy refresh config <config-file>

# Full reinstall of configs (nuclear option)
omarchy reinstall
```

## Decision Framework

When user requests system changes:

1. **Is it a stock omarchy command?** Use it directly
2. **Is it a config edit?** Edit in `~/.config/`, never `/usr/share/omarchy/`
3. **Is it a theme customization?** Follow [`theming.md`](theming.md); create a NEW custom theme directory
4. **Is it automation?** Follow [`hooks.md`](hooks.md); use `omarchy hook install` and the hook `.d` directories
5. **Is it a package install?** Use `omarchy pkg add <pkgs...>` (or `omarchy pkg aur add <pkgs...>` for AUR-only packages)
6. **Is it built-in shell/plugin code?** Follow [`plugins.md`](plugins.md); clone it with `omarchy plugin clone`, never edit the packaged copy
7. **Unsure if command exists?** Run `omarchy commands` (or `omarchy <group> --help` for one group)

### Reminder Requests

When the user asks to set a reminder, use `omarchy reminder <minutes> [message]` directly. Convert natural language durations to minutes and title-case short reminder labels when appropriate.

```bash
omarchy reminder 15 "Pickup Jack"
omarchy reminder 60 "Check laundry"
omarchy reminder show
omarchy reminder clear
```

## Out of Scope

This skill intentionally does not cover Omarchy source development. Do not use this skill for:
- Editing files in `/usr/share/omarchy/` (`bin/`, `config/`, `default/`, `shell/`, `themes/`, `migrations/`, etc.)
- Creating or editing migrations
- Running `omarchy dev ...` commands

## Example Requests

- "Change my theme to catppuccin" -> `omarchy theme set catppuccin`
- "Add a keybinding for Super+E to open file manager" -> Check existing bindings first, call `hl.unbind` if needed, then `o.bind` in `~/.config/hypr/bindings.lua`
- "Configure my external monitor" -> Edit `~/.config/hypr/monitors.lua`
- "Make the window gaps smaller" -> Edit `~/.config/hypr/looknfeel.lua`
- "Turn on night light" -> `omarchy toggle nightlight` (for time-based schedules, edit `~/.config/hypr/hyprsunset.conf` profiles, then `omarchy restart hyprsunset`)
- "Set a reminder to pickup jack in 15 minutes" -> `omarchy reminder 15 "Pickup Jack"`
- "Show my reminders" -> `omarchy reminder show`
- "Clear all reminders" -> `omarchy reminder clear`
- "Customize the catppuccin theme colors" -> Overlay: put an edited `colors.toml` in `~/.config/omarchy/themes/catppuccin/`, then re-apply the theme (see `theming.md`)
- "Run a script every time I change themes" -> Install it with `omarchy hook install theme-set <script>`
- "Change how workspace labels are rendered" -> Clone `omarchy.workspaces`, which switches the bar to `<username>.workspaces`, then edit the clone
- "Lock after ten minutes" -> Set `idle.lock` to `600` in `~/.config/omarchy/shell.json`
- "Reset shell/bar to defaults" -> `omarchy refresh shell`
- "Record my screen" -> `omarchy screenrecord --fullscreen`, then `omarchy screenrecord --stop-recording` (see `capture.md`)
- "Report this bug to Omarchy" -> Gather diagnostics and a capture of the problem, then file it (see `contributing.md`)

Base directory for this skill: /home/mb/.agents/skills/omarchy
Relative paths in this skill (e.g., scripts/, reference/) are relative to this base directory.
Note: file list is sampled.

<skill_files>
<file>/home/mb/.agents/skills/omarchy/contributing.md</file>
<file>/home/mb/.agents/skills/omarchy/theming.md</file>
<file>/home/mb/.agents/skills/omarchy/plugins.md</file>
<file>/home/mb/.agents/skills/omarchy/capture.md</file>
<file>/home/mb/.agents/skills/omarchy/hyprland.md</file>
<file>/home/mb/.agents/skills/omarchy/hooks.md</file>
</skill_files>
</skill_content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.1s)

_Thinking:_



**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/hypr/hyprland.lua"
}
```

**Output:**
```
<path>/home/mb/.config/hypr/hyprland.lua</path>
<type>file</type>
<content>
1: -- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/
2: 
3: -- Omarchy's bootstrap keeps path setup out of this user config.
4: dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")
5: 
6: -- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
7: -- omarchy_default_bindings = false
8: --
9: -- Or disable only bindings for Omarchy's preinstalled apps/web apps while
10: -- keeping core window-manager bindings:
11: -- omarchy_preinstalled_bindings = false
12: 
13: -- Load Omarchy defaults.
14: require("default.hypr.omarchy")
15: 
16: -- Put your personal overrides in these files. They're loaded after Omarchy's
17: -- defaults so package updates can improve the defaults without rewriting your
18: -- ~/.config/hypr files.
19: require("hypr.monitors")
20: require("hypr.input")
21: require("hypr.bindings")
22: require("hypr.looknfeel")
23: require("hypr.autostart")
24: 
25: -- Toggle config flags dynamically.
26: require("default.hypr.toggles")
27: 
28: -- Add any other personal Hyprland configuration below.
29: -- Workspace 1 named "code" (persistent)
30: hl.workspace_rule({ workspace = "1", default_name = "code", persistent = true })
31: o.window("qemu", { workspace = "5" })

(End of file - total 31 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml"
}
```

**Output:**
```
<path>/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml</path>
<type>file</type>
<content>
1: import QtQuick
2: import QtQuick.Layouts
3: import Quickshell.Hyprland
4: import qs.Commons
5: import qs.Ui
6: 
7: BarWidget {
8:   id: root
9:   moduleName: "omarchy.workspaces"
10: 
11:   function workspaceById(id) {
12:     var values = Hyprland.workspaces.values
13:     for (var i = 0; i < values.length; i++) {
14:       if (values[i].id === id) return values[i]
15:     }
16: 
17:     return null
18:   }
19: 
20:   function workspaceIds() {
21:     var ids = [1, 2, 3, 4, 5]
22:     var values = Hyprland.workspaces.values
23: 
24:     for (var i = 0; i < values.length; i++) {
25:       var id = values[i].id
26:       if (id > 0 && id <= 10 && ids.indexOf(id) === -1) ids.push(id)
27:     }
28: 
29:     ids.sort(function(left, right) { return left - right })
30:     return ids
31:   }
32: 
33:   function focusWorkspace(id) {
34:     if (!root.bar) return
35:     root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
36:   }
37: 
38:   readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)
39: 
40:   implicitWidth: grid.implicitWidth + trailingGap
41:   implicitHeight: grid.implicitHeight
42: 
43:   GridLayout {
44:     id: grid
45:     anchors.fill: parent
46:     anchors.rightMargin: root.trailingGap
47:     columns: root.vertical ? 1 : root.workspaceIds().length
48:     columnSpacing: root.vertical ? 0 : Style.space(1)
49:     rowSpacing: root.vertical ? Style.space(2) : 0
50: 
51:     Repeater {
52:       model: root.workspaceIds()
53: 
54:       WidgetButton {
55:         required property int modelData
56: 
57:         readonly property var workspace: root.workspaceById(modelData)
58:         readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
59:         readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData
60: 
61:         bar: root.bar
62:         text: modelData === 1 ? "code" : (focused ? "󰻿" : (modelData === 10 ? "0" : String(modelData)))
63:         opacity: occupied || focused ? 1 : 0.5
64:         horizontalMargin: 6
65:         verticalPadding: 6
66:         fixedWidth: modelData === 1 && !root.vertical ? -1 : (root.vertical ? root.barSize : Style.space(20))
67:         fixedHeight: root.barSize
68:         onPressed: function() { root.focusWorkspace(modelData) }
69:       }
70:     }
71:   }
72: }

(End of file - total 72 lines)
</content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.9s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "cp ~/.config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua.bak.$(date +%s) && cp ~/.config/omarchy/plugins/mb.workspaces/Workspaces.qml ~/.config/omarchy/plugins/mb.workspaces/Workspaces.qml.bak.$(date +%s) && echo \"backups done\" && hyprctl workspaces 2>&1 | head -n 20"
}
```

**Output:**
```
backups done
workspace ID 10 (10) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b1823c1e60
	lastwindowtitle: 5 MCP servers every Claude Code user needs right now. - YouTube
	ispersistent: 0
	tiledLayout: dwindle

workspace ID 1 (code) on monitor eDP-1:
	monitorID: 0
	windows: 2
	hasfullscreen: 0
	lastwindow: 0x55b183e478e0
	lastwindowtitle: omarchy: ~
	ispersistent: 1
	tiledLayout: dwindle



```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.2s)

_Thinking:_



**Tool: edit**

**Input:**
```json
{
  "filePath": "/home/mb/.config/hypr/hyprland.lua",
  "newString": "-- Add any other personal Hyprland configuration below.\n-- Named persistent workspaces\nhl.workspace_rule({ workspace = \"1\", default_name = \"code\", persistent = true })\nhl.workspace_rule({ workspace = \"2\", default_name = \"browser\", persistent = true })\nhl.workspace_rule({ workspace = \"3\", default_name = \"terminal\", persistent = true })\nhl.workspace_rule({ workspace = \"10\", default_name = \"youtube\", persistent = true })\no.window(\"qemu\", { workspace = \"5\" })",
  "oldString": "-- Add any other personal Hyprland configuration below.\n-- Workspace 1 named \"code\" (persistent)\nhl.workspace_rule({ workspace = \"1\", default_name = \"code\", persistent = true })\no.window(\"qemu\", { workspace = \"5\" })"
}
```

**Output:**
```
Edit applied successfully.
```

---

## Assistant (Build · Muse Spark 1.3 Free · 7.0s)

_Thinking:_



Hyprland rules set — now updating the bar labels.

**Tool: edit**

**Input:**
```json
{
  "filePath": "/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml",
  "newString": "  function focusWorkspace(id) {\n    if (!root.bar) return\n    root.bar.run(\"hyprctl dispatch \" + Util.shellQuote(\"hl.dsp.focus({ workspace = \\\"\" + id + \"\\\" })\"))\n  }\n\n  function workspaceLabel(id) {\n    if (id === 1) return \"code\"\n    if (id === 2) return \"browser\"\n    if (id === 3) return \"terminal\"\n    if (id === 10) return \"youtube\"\n    return null\n  }",
  "oldString": "  function focusWorkspace(id) {\n    if (!root.bar) return\n    root.bar.run(\"hyprctl dispatch \" + Util.shellQuote(\"hl.dsp.focus({ workspace = \\\"\" + id + \"\\\" })\"))\n  }"
}
```

**Output:**
```
Edit applied successfully.
```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.3s)

**Tool: edit**

**Input:**
```json
{
  "filePath": "/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml",
  "newString": "        bar: root.bar\n        readonly property string customLabel: root.workspaceLabel(modelData)\n        text: customLabel !== \"\" && customLabel !== null ? customLabel : (focused ? \"󰻿\" : String(modelData))\n        opacity: occupied || focused ? 1 : 0.5\n        horizontalMargin: 6\n        verticalPadding: 6\n        fixedWidth: customLabel !== \"\" && customLabel !== null ? (root.vertical ? root.barSize : -1) : (root.vertical ? root.barSize : Style.space(20))\n        fixedHeight: root.barSize",
  "oldString": "        bar: root.bar\n        text: modelData === 1 ? \"code\" : (focused ? \"󰻿\" : (modelData === 10 ? \"0\" : String(modelData)))\n        opacity: occupied || focused ? 1 : 0.5\n        horizontalMargin: 6\n        verticalPadding: 6\n        fixedWidth: modelData === 1 && !root.vertical ? -1 : (root.vertical ? root.barSize : Style.space(20))\n        fixedHeight: root.barSize"
}
```

**Output:**
```
Edit applied successfully.
```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.9s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "hyprctl reload 2>&1; sleep 1; hyprctl configerrors 2>&1; echo \"===rules===\"; hyprctl workspacerules -j 2>&1"
}
```

**Output:**
```
ok


===rules===
[{
    "workspaceString": "1",
    "enabled": true,
    "persistent": true,
    "defaultName": "code"
},{
    "workspaceString": "3",
    "enabled": true,
    "persistent": true,
    "defaultName": "terminal"
},{
    "workspaceString": "2",
    "enabled": true,
    "persistent": true,
    "defaultName": "browser"
},{
    "workspaceString": "10",
    "enabled": true,
    "persistent": true,
    "defaultName": "youtube"
}]

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.2s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "hyprctl eval 'hl.dispatch(hl.dsp.workspace.rename({ workspace = \"2\", name = \"browser\" }))' 2>&1; hyprctl eval 'hl.dispatch(hl.dsp.workspace.rename({ workspace = \"3\", name = \"terminal\" }))' 2>&1; hyprctl eval 'hl.dispatch(hl.dsp.workspace.rename({ workspace = \"10\", name = \"youtube\" }))' 2>&1; echo \"---\"; sleep 0.5; hyprctl workspaces 2>&1; echo \"===\"; omarchy-shell shell rescanPlugins 2>&1; echo \"rescan done\""
}
```

**Output:**
```
ok
ok
ok
---
workspace ID 10 (youtube) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b1823c1e60
	lastwindowtitle: 5 MCP servers every Claude Code user needs right now. - YouTube
	ispersistent: 1
	tiledLayout: dwindle

workspace ID 1 (code) on monitor eDP-1:
	monitorID: 0
	windows: 2
	hasfullscreen: 0
	lastwindow: 0x55b183e478e0
	lastwindowtitle: omarchy: ~
	ispersistent: 1
	tiledLayout: dwindle

workspace ID 3 (terminal) on monitor eDP-1:
	monitorID: 0
	windows: 0
	hasfullscreen: 0
	lastwindow: 0x0
	lastwindowtitle: 
	ispersistent: 1
	tiledLayout: dwindle

workspace ID 2 (browser) on monitor eDP-1:
	monitorID: 0
	windows: 0
	hasfullscreen: 0
	lastwindow: 0x0
	lastwindowtitle: 
	ispersistent: 1
	tiledLayout: dwindle


===
rescan done

```

---

## Assistant (Build · Muse Spark 1.3 Free · 1.7s)

_Thinking:_



All workspaces renamed — doing a final check.

**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml"
}
```

**Output:**
```
<path>/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml</path>
<type>file</type>
<content>
1: import QtQuick
2: import QtQuick.Layouts
3: import Quickshell.Hyprland
4: import qs.Commons
5: import qs.Ui
6: 
7: BarWidget {
8:   id: root
9:   moduleName: "omarchy.workspaces"
10: 
11:   function workspaceById(id) {
12:     var values = Hyprland.workspaces.values
13:     for (var i = 0; i < values.length; i++) {
14:       if (values[i].id === id) return values[i]
15:     }
16: 
17:     return null
18:   }
19: 
20:   function workspaceIds() {
21:     var ids = [1, 2, 3, 4, 5]
22:     var values = Hyprland.workspaces.values
23: 
24:     for (var i = 0; i < values.length; i++) {
25:       var id = values[i].id
26:       if (id > 0 && id <= 10 && ids.indexOf(id) === -1) ids.push(id)
27:     }
28: 
29:     ids.sort(function(left, right) { return left - right })
30:     return ids
31:   }
32: 
33:   function focusWorkspace(id) {
34:     if (!root.bar) return
35:     root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
36:   }
37: 
38:   function workspaceLabel(id) {
39:     if (id === 1) return "code"
40:     if (id === 2) return "browser"
41:     if (id === 3) return "terminal"
42:     if (id === 10) return "youtube"
43:     return null
44:   }
45: 
46:   readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)
47: 
48:   implicitWidth: grid.implicitWidth + trailingGap
49:   implicitHeight: grid.implicitHeight
50: 
51:   GridLayout {
52:     id: grid
53:     anchors.fill: parent
54:     anchors.rightMargin: root.trailingGap
55:     columns: root.vertical ? 1 : root.workspaceIds().length
56:     columnSpacing: root.vertical ? 0 : Style.space(1)
57:     rowSpacing: root.vertical ? Style.space(2) : 0
58: 
59:     Repeater {
60:       model: root.workspaceIds()
61: 
62:       WidgetButton {
63:         required property int modelData
64: 
65:         readonly property var workspace: root.workspaceById(modelData)
66:         readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
67:         readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData
68: 
69:         bar: root.bar
70:         readonly property string customLabel: root.workspaceLabel(modelData)
71:         text: customLabel !== "" && customLabel !== null ? customLabel : (focused ? "󰻿" : String(modelData))
72:         opacity: occupied || focused ? 1 : 0.5
73:         horizontalMargin: 6
74:         verticalPadding: 6
75:         fixedWidth: customLabel !== "" && customLabel !== null ? (root.vertical ? root.barSize : -1) : (root.vertical ? root.barSize : Style.space(20))
76:         fixedHeight: root.barSize
77:         onPressed: function() { root.focusWorkspace(modelData) }
78:       }
79:     }
80:   }
81: }

(End of file - total 81 lines)
</content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 4.5s)

_Thinking:_



Done — bar now shows names for all four:

* `1 → code` (kept)
* `2 → browser`
* `3 → terminal`
* `10 → youtube` — note: you said “workspace 0”, Hyprland has no ID 0, the pill that displays as `0` is ID `10`, so I mapped `10` to `youtube`. If you meant a different ID, tell me.

**What I did (per omarchy `hyprland.md` + `plugins.md`):**

1. Backed up `hyprland.lua` + `Workspaces.qml`
2. `~/.config/hypr/hyprland.lua` — added persistent rules:
   ```lua
   hl.workspace_rule({ workspace = "1", default_name = "code", persistent = true })
   hl.workspace_rule({ workspace = "2", default_name = "browser", persistent = true })
   hl.workspace_rule({ workspace = "3", default_name = "terminal", persistent = true })
   hl.workspace_rule({ workspace = "10", default_name = "youtube", persistent = true })
   ```
   `hyprctl reload → ok`, `configerrors → clean`, `workspacerules -j` confirms all 4.

3. `~/.config/omarchy/plugins/mb.workspaces/Workspaces.qml` — centralized labels:
   ```qml
   function workspaceLabel(id) {
     if (id === 1) return "code"
     if (id === 2) return "browser"
     if (id === 3) return "terminal"
     if (id === 10) return "youtube"
     return null
   }
   text: customLabel ? customLabel : (focused ? "󰻿" : String(modelData))
   fixedWidth: customLabel ? (vertical ? barSize : -1) : ...
   ```
   Named pills use auto-width (`-1`) so `browser`/`terminal`/`youtube` fit; others keep fixed `Style.space(20)`. Old `10→0` mapping is gone — it now shows `youtube`.

4. Applied live + reloaded bar:
   ```
   hyprctl eval 'hl.dispatch(hl.dsp.workspace.rename({workspace:"2",name:"browser"}))' → ok
   ... same for 3, 10
   hyprctl workspaces → ID 1 (code), 2 (browser), 3 (terminal), 10 (youtube), all ispersistent:1
   omarchy-shell shell rescanPlugins
   ```

All in `~/.config/`, so it survives `omarchy update` like before.

---

## User

put respective workspace id as prefix for code, browser, terminal and youtube
e.g. 1_code 2_browser 3_terminal 0_youtube
This will avoid any confusion and let me remember the workspace number as well.

---

## Assistant (Build · Muse Spark 1.3 Free · 7.8s)

_Thinking:_



Good call — adding the numbers back so you get `1_code`, `2_browser`, etc.

**Tool: skill**

**Input:**
```json
{
  "name": "omarchy"
}
```

**Output:**
```
<skill_content name="omarchy">
# Skill: omarchy

# Omarchy Skill

Manage [Omarchy](https://omarchy.org/) Linux systems - a beautiful, modern, opinionated Arch Linux distribution with Hyprland.

This skill is for end-user customization on installed systems.
It is not for contributing to Omarchy source code.

## When This Skill MUST Be Used

**ALWAYS invoke this skill for end-user requests involving ANY of these:**

- Editing ANY file in `~/.config/hypr/` (window rules, animations, keybindings, monitors, etc.)
- Editing `~/.config/omarchy/shell.json` (status bar layout, widgets)
- Editing terminal configs (alacritty, foot, kitty, ghostty)
- Editing ANY file in `~/.config/omarchy/`
- Window behavior, animations, opacity, blur, gaps, borders
- Layer rules, workspace settings, display/monitor configuration
- Themes, backgrounds, fonts, appearance changes
- User-facing `omarchy` commands (`omarchy theme ...`, `omarchy refresh ...`, `omarchy restart ...`, etc.)
- Screenshots, screen recording, reminders, night light, idle behavior, lock screen

**If you're about to edit a config file in ~/.config/ on this system, STOP and use this skill first.**

**Do NOT use this skill for Omarchy development tasks** (editing the Omarchy source tree, creating migrations, or running `omarchy dev ...` workflows).

## Topic Guides

Deeper instructions for common areas live next to this file. Read the
matching guide before starting:

- [`hyprland.md`](hyprland.md) - keybindings, monitors, window rules, and other Hyprland config
- [`plugins.md`](plugins.md) - the Omarchy shell: bar layout, widgets, plugins, idle behavior
- [`theming.md`](theming.md) - themes, backgrounds, and fonts
- [`hooks.md`](hooks.md) - automation hooks that run on system events
- [`capture.md`](capture.md) - screenshots, screen recordings, OCR text capture, and file sharing
- [`contributing.md`](contributing.md) - reporting Omarchy bugs and submitting fixes upstream

## Critical Safety Rules

For privileged commands, follow the Privilege Escalation rules below: `sudo` when a terminal is available for the password prompt, `pkexec` when it is not. Do not wrap commands that already manage privilege elevation themselves.

**For end-user customization tasks, NEVER modify anything in `/usr/share/omarchy/`** - but READING is safe and encouraged.

This directory is owned by the omarchy package. Any local changes will be
overwritten on the next `omarchy update`.

```
/usr/share/omarchy/     # READ-ONLY - NEVER EDIT (reading is OK)
├── bin/                    # Command source (packaged binaries are on PATH)
├── config/                 # Default config templates
├── themes/                 # Stock themes
├── default/                # System defaults
├── shell/                  # Omarchy shell source and defaults
├── migrations/             # Update migrations
└── install/                # Installation scripts
```

**Reading `/usr/share/omarchy/` is SAFE and useful** - do it freely to:
- Understand how omarchy commands work: `omarchy theme set --help` or `cat $(which omarchy-theme-set)`
- See default configs before customizing: `cat "$OMARCHY_PATH/config/omarchy/shell.json"`
- Check stock theme files to copy for customization
- Reference default hyprland settings: `cat /usr/share/omarchy/default/hypr/*`

**Always use these safe locations instead:**
- `~/.config/` - User configuration (safe to edit)
- `~/.config/omarchy/themes/<custom-name>/` - Custom themes
- `~/.config/omarchy/hooks/` - Custom automation hooks

If the request is to develop Omarchy itself, this skill is out of scope. Follow repository development instructions instead of this skill.

## Privilege Escalation

For an interactive script or command run in a visible terminal, use `sudo` for
privileged work. Omarchy may grant passwordless `sudo` access to particular
commands, and the terminal is the appropriate place to request a password
when one is needed.

Use `pkexec` only when the caller cannot interact with a terminal or cannot
enter a password there, such as a command launched by an agent or a graphical
background process. Do not replace `sudo` with `pkexec` merely because a
command changes system state.

## System Architecture

Omarchy is built on:

| Component | Purpose | Config Location |
|-----------|---------|-----------------|
| **Arch Linux** | Base OS | `/etc/`, `~/.config/` |
| **Hyprland** | Wayland compositor/WM | `~/.config/hypr/` |
| **Omarchy shell** | Status bar + notifications (Quickshell) | `~/.config/omarchy/shell.json` |
| **Launcher/menus** | Quickshell menu | `~/.config/omarchy/extensions/omarchy-menu.jsonc` |
| **Alacritty/Foot/Kitty/Ghostty** | Terminals | `~/.config/<terminal>/` |
| **Omarchy OSD** | On-screen display | Quickshell plugin |

## Command Discovery

Omarchy ships a single `omarchy` CLI that dispatches to all `omarchy-*` binaries via `omarchy <group> <action>`. Always prefer this form — it is self-documenting and stable. The underlying `omarchy-*` binaries still exist on `PATH` and remain safe to read for source.

```bash
# List every documented command and its summary (--all includes hidden commands)
omarchy commands

# Show the commands inside a group
omarchy theme --help
omarchy refresh --help
omarchy restart --help

# Show help for a specific command (does not execute it)
omarchy theme set --help

# Machine-readable listing (binary, route, summary, args, aliases)
omarchy commands --json

# Read a command's source to understand it
cat $(which omarchy-theme-set)
```

### Command Groups

Run `omarchy --help` for the full list. The most common groups:

| Group | Purpose | Example |
|-------|---------|---------|
| `omarchy refresh` | Reset config to defaults (backs up first) | `omarchy refresh shell` |
| `omarchy restart` | Restart a service/app | `omarchy restart shell` |
| `omarchy toggle` | Toggle feature on/off | `omarchy toggle nightlight` |
| `omarchy theme` | Theme management | `omarchy theme set <name>` |
| `omarchy bar` | Bar layout and widgets | `omarchy bar move omarchy.clock --section right` |
| `omarchy plugin` | Manage/clone shell plugins | `omarchy plugin clone omarchy.clock` |
| `omarchy hook` | Install automation hooks | `omarchy hook install theme-set <script>` |
| `omarchy install` | Install optional software / packages | `omarchy install docker dbs` |
| `omarchy launch` | Launch apps | `omarchy launch browser` |
| `omarchy capture` | Screenshots and recordings | `omarchy capture screenshot` |
| `omarchy reminder` | Desktop notification reminders | `omarchy reminder 15 "Pickup Jack"` |
| `omarchy pkg` | Package management | `omarchy pkg add <pkg>` |
| `omarchy setup` | Interactive setup wizards | `omarchy setup security fingerprint` |
| `omarchy update` | System updates | `omarchy update` |

## Configuration Locations

Hyprland config lives in `~/.config/hypr/` — see [`hyprland.md`](hyprland.md).
The Omarchy shell (bar, notifications, plugins, idle) is configured in
`~/.config/omarchy/shell.json` — see [`plugins.md`](plugins.md).

### Terminals

```
~/.config/alacritty/alacritty.toml
~/.config/foot/foot.ini
~/.config/kitty/kitty.conf
~/.config/ghostty/config
```

**Command:** `omarchy restart terminal`

### Other Configs

| App | Location |
|-----|----------|
| btop | `~/.config/btop/btop.conf` |
| fastfetch | `/etc/fastfetch/config.jsonc` default; `~/.config/fastfetch/config.jsonc` user override |
| lazygit | `~/.config/lazygit/config.yml` |
| starship | `~/.config/starship.toml` |
| git | `~/.config/git/config` |

## Safe Customization Patterns

### Edit User Config Directly

For simple changes, edit files in `~/.config/`:

```bash
# 1. Read current config
cat ~/.config/hypr/bindings.lua

# 2. Backup before changes
cp ~/.config/hypr/bindings.lua ~/.config/hypr/bindings.lua.bak.$(date +%s)

# 3. Make changes with Edit tool

# 4. Apply changes
# - Hyprland: auto-reloads on save, but MUST validate with `hyprctl reload` and `hyprctl configerrors`
# - Omarchy shell: shell.json and user plugin code under ~/.config/omarchy/plugins/ hot-reload on save
# - Menus/launcher: ~/.config/omarchy/extensions/omarchy-menu.jsonc hot-reloads on save
# - Terminals: apply with `omarchy restart terminal` (reloads running terminals; foot picks changes up in new windows)
```

### Reset to Defaults -- ALWAYS SEEK USER CONFIRMATION BEFORE RUNNING

When customizations go wrong:

```bash
# Reset specific config (creates backup automatically)
omarchy refresh shell
omarchy refresh hyprland

# The refresh command:
# 1. Backs up current config with timestamp
# 2. Copies default from $OMARCHY_PATH/config/
# 3. Restarts the component where the refresh needs it (e.g. `refresh shell`)
```

## System Commands

```bash
omarchy update                  # Full system update
omarchy version                 # Show Omarchy version
omarchy debug --no-sudo --print # Debug info (ALWAYS use these flags)
omarchy system lock             # Lock screen
omarchy system shutdown         # Shutdown
omarchy system reboot           # Reboot
```

**IMPORTANT:** Always run `omarchy debug` with `--no-sudo --print` flags to avoid interactive sudo prompts that will hang the terminal.

## Troubleshooting

```bash
# Get debug information (ALWAYS use these flags to avoid interactive prompts)
omarchy debug --no-sudo --print

# Reset specific config to defaults
omarchy refresh <app>

# Refresh specific config file
# config-file path is relative to ~/.config/
# eg. `omarchy refresh config hypr/hyprland.lua` will refresh ~/.config/hypr/hyprland.lua
omarchy refresh config <config-file>

# Full reinstall of configs (nuclear option)
omarchy reinstall
```

## Decision Framework

When user requests system changes:

1. **Is it a stock omarchy command?** Use it directly
2. **Is it a config edit?** Edit in `~/.config/`, never `/usr/share/omarchy/`
3. **Is it a theme customization?** Follow [`theming.md`](theming.md); create a NEW custom theme directory
4. **Is it automation?** Follow [`hooks.md`](hooks.md); use `omarchy hook install` and the hook `.d` directories
5. **Is it a package install?** Use `omarchy pkg add <pkgs...>` (or `omarchy pkg aur add <pkgs...>` for AUR-only packages)
6. **Is it built-in shell/plugin code?** Follow [`plugins.md`](plugins.md); clone it with `omarchy plugin clone`, never edit the packaged copy
7. **Unsure if command exists?** Run `omarchy commands` (or `omarchy <group> --help` for one group)

### Reminder Requests

When the user asks to set a reminder, use `omarchy reminder <minutes> [message]` directly. Convert natural language durations to minutes and title-case short reminder labels when appropriate.

```bash
omarchy reminder 15 "Pickup Jack"
omarchy reminder 60 "Check laundry"
omarchy reminder show
omarchy reminder clear
```

## Out of Scope

This skill intentionally does not cover Omarchy source development. Do not use this skill for:
- Editing files in `/usr/share/omarchy/` (`bin/`, `config/`, `default/`, `shell/`, `themes/`, `migrations/`, etc.)
- Creating or editing migrations
- Running `omarchy dev ...` commands

## Example Requests

- "Change my theme to catppuccin" -> `omarchy theme set catppuccin`
- "Add a keybinding for Super+E to open file manager" -> Check existing bindings first, call `hl.unbind` if needed, then `o.bind` in `~/.config/hypr/bindings.lua`
- "Configure my external monitor" -> Edit `~/.config/hypr/monitors.lua`
- "Make the window gaps smaller" -> Edit `~/.config/hypr/looknfeel.lua`
- "Turn on night light" -> `omarchy toggle nightlight` (for time-based schedules, edit `~/.config/hypr/hyprsunset.conf` profiles, then `omarchy restart hyprsunset`)
- "Set a reminder to pickup jack in 15 minutes" -> `omarchy reminder 15 "Pickup Jack"`
- "Show my reminders" -> `omarchy reminder show`
- "Clear all reminders" -> `omarchy reminder clear`
- "Customize the catppuccin theme colors" -> Overlay: put an edited `colors.toml` in `~/.config/omarchy/themes/catppuccin/`, then re-apply the theme (see `theming.md`)
- "Run a script every time I change themes" -> Install it with `omarchy hook install theme-set <script>`
- "Change how workspace labels are rendered" -> Clone `omarchy.workspaces`, which switches the bar to `<username>.workspaces`, then edit the clone
- "Lock after ten minutes" -> Set `idle.lock` to `600` in `~/.config/omarchy/shell.json`
- "Reset shell/bar to defaults" -> `omarchy refresh shell`
- "Record my screen" -> `omarchy screenrecord --fullscreen`, then `omarchy screenrecord --stop-recording` (see `capture.md`)
- "Report this bug to Omarchy" -> Gather diagnostics and a capture of the problem, then file it (see `contributing.md`)

Base directory for this skill: /home/mb/.agents/skills/omarchy
Relative paths in this skill (e.g., scripts/, reference/) are relative to this base directory.
Note: file list is sampled.

<skill_files>
<file>/home/mb/.agents/skills/omarchy/theming.md</file>
<file>/home/mb/.agents/skills/omarchy/plugins.md</file>
<file>/home/mb/.agents/skills/omarchy/hyprland.md</file>
<file>/home/mb/.agents/skills/omarchy/hooks.md</file>
<file>/home/mb/.agents/skills/omarchy/contributing.md</file>
<file>/home/mb/.agents/skills/omarchy/capture.md</file>
</skill_files>
</skill_content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.2s)

_Thinking:_



**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/hypr/hyprland.lua"
}
```

**Output:**
```
<path>/home/mb/.config/hypr/hyprland.lua</path>
<type>file</type>
<content>
1: -- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/
2: 
3: -- Omarchy's bootstrap keeps path setup out of this user config.
4: dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")
5: 
6: -- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
7: -- omarchy_default_bindings = false
8: --
9: -- Or disable only bindings for Omarchy's preinstalled apps/web apps while
10: -- keeping core window-manager bindings:
11: -- omarchy_preinstalled_bindings = false
12: 
13: -- Load Omarchy defaults.
14: require("default.hypr.omarchy")
15: 
16: -- Put your personal overrides in these files. They're loaded after Omarchy's
17: -- defaults so package updates can improve the defaults without rewriting your
18: -- ~/.config/hypr files.
19: require("hypr.monitors")
20: require("hypr.input")
21: require("hypr.bindings")
22: require("hypr.looknfeel")
23: require("hypr.autostart")
24: 
25: -- Toggle config flags dynamically.
26: require("default.hypr.toggles")
27: 
28: -- Add any other personal Hyprland configuration below.
29: -- Named persistent workspaces
30: hl.workspace_rule({ workspace = "1", default_name = "code", persistent = true })
31: hl.workspace_rule({ workspace = "2", default_name = "browser", persistent = true })
32: hl.workspace_rule({ workspace = "3", default_name = "terminal", persistent = true })
33: hl.workspace_rule({ workspace = "10", default_name = "youtube", persistent = true })
34: o.window("qemu", { workspace = "5" })

(End of file - total 34 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml"
}
```

**Output:**
```
<path>/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml</path>
<type>file</type>
<content>
1: import QtQuick
2: import QtQuick.Layouts
3: import Quickshell.Hyprland
4: import qs.Commons
5: import qs.Ui
6: 
7: BarWidget {
8:   id: root
9:   moduleName: "omarchy.workspaces"
10: 
11:   function workspaceById(id) {
12:     var values = Hyprland.workspaces.values
13:     for (var i = 0; i < values.length; i++) {
14:       if (values[i].id === id) return values[i]
15:     }
16: 
17:     return null
18:   }
19: 
20:   function workspaceIds() {
21:     var ids = [1, 2, 3, 4, 5]
22:     var values = Hyprland.workspaces.values
23: 
24:     for (var i = 0; i < values.length; i++) {
25:       var id = values[i].id
26:       if (id > 0 && id <= 10 && ids.indexOf(id) === -1) ids.push(id)
27:     }
28: 
29:     ids.sort(function(left, right) { return left - right })
30:     return ids
31:   }
32: 
33:   function focusWorkspace(id) {
34:     if (!root.bar) return
35:     root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
36:   }
37: 
38:   function workspaceLabel(id) {
39:     if (id === 1) return "code"
40:     if (id === 2) return "browser"
41:     if (id === 3) return "terminal"
42:     if (id === 10) return "youtube"
43:     return null
44:   }
45: 
46:   readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)
47: 
48:   implicitWidth: grid.implicitWidth + trailingGap
49:   implicitHeight: grid.implicitHeight
50: 
51:   GridLayout {
52:     id: grid
53:     anchors.fill: parent
54:     anchors.rightMargin: root.trailingGap
55:     columns: root.vertical ? 1 : root.workspaceIds().length
56:     columnSpacing: root.vertical ? 0 : Style.space(1)
57:     rowSpacing: root.vertical ? Style.space(2) : 0
58: 
59:     Repeater {
60:       model: root.workspaceIds()
61: 
62:       WidgetButton {
63:         required property int modelData
64: 
65:         readonly property var workspace: root.workspaceById(modelData)
66:         readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
67:         readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData
68: 
69:         bar: root.bar
70:         readonly property string customLabel: root.workspaceLabel(modelData)
71:         text: customLabel !== "" && customLabel !== null ? customLabel : (focused ? "󰻿" : String(modelData))
72:         opacity: occupied || focused ? 1 : 0.5
73:         horizontalMargin: 6
74:         verticalPadding: 6
75:         fixedWidth: customLabel !== "" && customLabel !== null ? (root.vertical ? root.barSize : -1) : (root.vertical ? root.barSize : Style.space(20))
76:         fixedHeight: root.barSize
77:         onPressed: function() { root.focusWorkspace(modelData) }
78:       }
79:     }
80:   }
81: }

(End of file - total 81 lines)
</content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.0s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "cp ~/.config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua.bak.$(date +%s) && cp ~/.config/omarchy/plugins/mb.workspaces/Workspaces.qml ~/.config/omarchy/plugins/mb.workspaces/Workspaces.qml.bak.$(date +%s) && echo \"backups done\""
}
```

**Output:**
```
backups done

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.0s)

**Tool: edit**

**Input:**
```json
{
  "filePath": "/home/mb/.config/hypr/hyprland.lua",
  "newString": "-- Add any other personal Hyprland configuration below.\n-- Named persistent workspaces (id prefix to remember numbers)\nhl.workspace_rule({ workspace = \"1\", default_name = \"1_code\", persistent = true })\nhl.workspace_rule({ workspace = \"2\", default_name = \"2_browser\", persistent = true })\nhl.workspace_rule({ workspace = \"3\", default_name = \"3_terminal\", persistent = true })\nhl.workspace_rule({ workspace = \"10\", default_name = \"0_youtube\", persistent = true })",
  "oldString": "-- Add any other personal Hyprland configuration below.\n-- Named persistent workspaces\nhl.workspace_rule({ workspace = \"1\", default_name = \"code\", persistent = true })\nhl.workspace_rule({ workspace = \"2\", default_name = \"browser\", persistent = true })\nhl.workspace_rule({ workspace = \"3\", default_name = \"terminal\", persistent = true })\nhl.workspace_rule({ workspace = \"10\", default_name = \"youtube\", persistent = true })"
}
```

**Output:**
```
Edit applied successfully.
```

---

## Assistant (Build · Muse Spark 1.3 Free · 1.7s)

**Tool: edit**

**Input:**
```json
{
  "filePath": "/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml",
  "newString": "  function workspaceLabel(id) {\n    if (id === 1) return \"1_code\"\n    if (id === 2) return \"2_browser\"\n    if (id === 3) return \"3_terminal\"\n    if (id === 10) return \"0_youtube\"\n    return null\n  }",
  "oldString": "  function workspaceLabel(id) {\n    if (id === 1) return \"code\"\n    if (id === 2) return \"browser\"\n    if (id === 3) return \"terminal\"\n    if (id === 10) return \"youtube\"\n    return null\n  }"
}
```

**Output:**
```
Edit applied successfully.
```

---

## Assistant (Build · Muse Spark 1.3 Free · 5.7s)

**Tool: bash**

**Input:**
```json
{
  "command": "hyprctl reload 2>&1; sleep 1; hyprctl configerrors 2>&1; echo \"===rules===\"; hyprctl workspacerules -j 2>&1"
}
```

**Output:**
```
ok


===rules===
[{
    "workspaceString": "1",
    "enabled": true,
    "persistent": true,
    "defaultName": "1_code"
},{
    "workspaceString": "3",
    "enabled": true,
    "persistent": true,
    "defaultName": "3_terminal"
},{
    "workspaceString": "2",
    "enabled": true,
    "persistent": true,
    "defaultName": "2_browser"
},{
    "workspaceString": "10",
    "enabled": true,
    "persistent": true,
    "defaultName": "0_youtube"
}]

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.6s)

**Tool: bash**

**Input:**
```json
{
  "command": "hyprctl eval 'hl.dispatch(hl.dsp.workspace.rename({ workspace = \"1\", name = \"1_code\" }))' 2>&1; hyprctl eval 'hl.dispatch(hl.dsp.workspace.rename({ workspace = \"2\", name = \"2_browser\" }))' 2>&1; hyprctl eval 'hl.dispatch(hl.dsp.workspace.rename({ workspace = \"3\", name = \"3_terminal\" }))' 2>&1; hyprctl eval 'hl.dispatch(hl.dsp.workspace.rename({ workspace = \"10\", name = \"0_youtube\" }))' 2>&1; echo \"---\"; sleep 0.5; hyprctl workspaces 2>&1; echo \"===\"; omarchy-shell shell rescanPlugins 2>&1; echo \"rescan done\""
}
```

**Output:**
```
ok
ok
ok
ok
---
workspace ID 10 (0_youtube) on monitor eDP-1:
	monitorID: 0
	windows: 1
	hasfullscreen: 0
	lastwindow: 0x55b1823c1e60
	lastwindowtitle: 5 MCP servers every Claude Code user needs right now. - YouTube
	ispersistent: 1
	tiledLayout: dwindle

workspace ID 1 (1_code) on monitor eDP-1:
	monitorID: 0
	windows: 2
	hasfullscreen: 0
	lastwindow: 0x55b183e478e0
	lastwindowtitle: omarchy: ~
	ispersistent: 1
	tiledLayout: dwindle

workspace ID 3 (3_terminal) on monitor eDP-1:
	monitorID: 0
	windows: 0
	hasfullscreen: 0
	lastwindow: 0x0
	lastwindowtitle: 
	ispersistent: 1
	tiledLayout: dwindle

workspace ID 2 (2_browser) on monitor eDP-1:
	monitorID: 0
	windows: 0
	hasfullscreen: 0
	lastwindow: 0x0
	lastwindowtitle: 
	ispersistent: 1
	tiledLayout: dwindle


===
rescan done

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.4s)

_Thinking:_



Done — now with ID prefixes so you keep the numbers:

* `1 → 1_code`
* `2 → 2_browser`
* `3 → 3_terminal`
* `10 (shown as 0) → 0_youtube`

**What I changed:**

1. `~/.config/hypr/hyprland.lua` (backed up first):
   ```lua
   hl.workspace_rule({ workspace = "1", default_name = "1_code", persistent = true })
   hl.workspace_rule({ workspace = "2", default_name = "2_browser", persistent = true })
   hl.workspace_rule({ workspace = "3", default_name = "3_terminal", persistent = true })
   hl.workspace_rule({ workspace = "10", default_name = "0_youtube", persistent = true })
   ```
   `hyprctl reload → ok`, `configerrors → clean`.

2. `~/.config/omarchy/plugins/mb.workspaces/Workspaces.qml`:
   ```qml
   if (id === 1) return "1_code"
   if (id === 2) return "2_browser"
   if (id === 3) return "3_terminal"
   if (id === 10) return "0_youtube"
   ```
   Auto-width (`-1`) still applies so the longer labels fit.

3. Renamed live workspaces + `omarchy-shell shell rescanPlugins`:
   ```
   ID 10 (0_youtube) ispersistent:1
   ID 1 (1_code) ispersistent:1
   ID 3 (3_terminal) ispersistent:1
   ID 2 (2_browser) ispersistent:1
   ```

Bar and `hyprctl` now agree, so no confusion between number vs name. Still all in `~/.config/`, so survives `omarchy update`.

---

## User

based on the selected theme, highlight the selected workspace somehow, either appropriate font color or background color. 

---

## Assistant (Build · Muse Spark 1.3 Free · 5.6s)

_Thinking:_



Styling the active workspace to match your theme — first checking the theme setup.

**Tool: skill**

**Input:**
```json
{
  "name": "omarchy"
}
```

**Output:**
```
<skill_content name="omarchy">
# Skill: omarchy

# Omarchy Skill

Manage [Omarchy](https://omarchy.org/) Linux systems - a beautiful, modern, opinionated Arch Linux distribution with Hyprland.

This skill is for end-user customization on installed systems.
It is not for contributing to Omarchy source code.

## When This Skill MUST Be Used

**ALWAYS invoke this skill for end-user requests involving ANY of these:**

- Editing ANY file in `~/.config/hypr/` (window rules, animations, keybindings, monitors, etc.)
- Editing `~/.config/omarchy/shell.json` (status bar layout, widgets)
- Editing terminal configs (alacritty, foot, kitty, ghostty)
- Editing ANY file in `~/.config/omarchy/`
- Window behavior, animations, opacity, blur, gaps, borders
- Layer rules, workspace settings, display/monitor configuration
- Themes, backgrounds, fonts, appearance changes
- User-facing `omarchy` commands (`omarchy theme ...`, `omarchy refresh ...`, `omarchy restart ...`, etc.)
- Screenshots, screen recording, reminders, night light, idle behavior, lock screen

**If you're about to edit a config file in ~/.config/ on this system, STOP and use this skill first.**

**Do NOT use this skill for Omarchy development tasks** (editing the Omarchy source tree, creating migrations, or running `omarchy dev ...` workflows).

## Topic Guides

Deeper instructions for common areas live next to this file. Read the
matching guide before starting:

- [`hyprland.md`](hyprland.md) - keybindings, monitors, window rules, and other Hyprland config
- [`plugins.md`](plugins.md) - the Omarchy shell: bar layout, widgets, plugins, idle behavior
- [`theming.md`](theming.md) - themes, backgrounds, and fonts
- [`hooks.md`](hooks.md) - automation hooks that run on system events
- [`capture.md`](capture.md) - screenshots, screen recordings, OCR text capture, and file sharing
- [`contributing.md`](contributing.md) - reporting Omarchy bugs and submitting fixes upstream

## Critical Safety Rules

For privileged commands, follow the Privilege Escalation rules below: `sudo` when a terminal is available for the password prompt, `pkexec` when it is not. Do not wrap commands that already manage privilege elevation themselves.

**For end-user customization tasks, NEVER modify anything in `/usr/share/omarchy/`** - but READING is safe and encouraged.

This directory is owned by the omarchy package. Any local changes will be
overwritten on the next `omarchy update`.

```
/usr/share/omarchy/     # READ-ONLY - NEVER EDIT (reading is OK)
├── bin/                    # Command source (packaged binaries are on PATH)
├── config/                 # Default config templates
├── themes/                 # Stock themes
├── default/                # System defaults
├── shell/                  # Omarchy shell source and defaults
├── migrations/             # Update migrations
└── install/                # Installation scripts
```

**Reading `/usr/share/omarchy/` is SAFE and useful** - do it freely to:
- Understand how omarchy commands work: `omarchy theme set --help` or `cat $(which omarchy-theme-set)`
- See default configs before customizing: `cat "$OMARCHY_PATH/config/omarchy/shell.json"`
- Check stock theme files to copy for customization
- Reference default hyprland settings: `cat /usr/share/omarchy/default/hypr/*`

**Always use these safe locations instead:**
- `~/.config/` - User configuration (safe to edit)
- `~/.config/omarchy/themes/<custom-name>/` - Custom themes
- `~/.config/omarchy/hooks/` - Custom automation hooks

If the request is to develop Omarchy itself, this skill is out of scope. Follow repository development instructions instead of this skill.

## Privilege Escalation

For an interactive script or command run in a visible terminal, use `sudo` for
privileged work. Omarchy may grant passwordless `sudo` access to particular
commands, and the terminal is the appropriate place to request a password
when one is needed.

Use `pkexec` only when the caller cannot interact with a terminal or cannot
enter a password there, such as a command launched by an agent or a graphical
background process. Do not replace `sudo` with `pkexec` merely because a
command changes system state.

## System Architecture

Omarchy is built on:

| Component | Purpose | Config Location |
|-----------|---------|-----------------|
| **Arch Linux** | Base OS | `/etc/`, `~/.config/` |
| **Hyprland** | Wayland compositor/WM | `~/.config/hypr/` |
| **Omarchy shell** | Status bar + notifications (Quickshell) | `~/.config/omarchy/shell.json` |
| **Launcher/menus** | Quickshell menu | `~/.config/omarchy/extensions/omarchy-menu.jsonc` |
| **Alacritty/Foot/Kitty/Ghostty** | Terminals | `~/.config/<terminal>/` |
| **Omarchy OSD** | On-screen display | Quickshell plugin |

## Command Discovery

Omarchy ships a single `omarchy` CLI that dispatches to all `omarchy-*` binaries via `omarchy <group> <action>`. Always prefer this form — it is self-documenting and stable. The underlying `omarchy-*` binaries still exist on `PATH` and remain safe to read for source.

```bash
# List every documented command and its summary (--all includes hidden commands)
omarchy commands

# Show the commands inside a group
omarchy theme --help
omarchy refresh --help
omarchy restart --help

# Show help for a specific command (does not execute it)
omarchy theme set --help

# Machine-readable listing (binary, route, summary, args, aliases)
omarchy commands --json

# Read a command's source to understand it
cat $(which omarchy-theme-set)
```

### Command Groups

Run `omarchy --help` for the full list. The most common groups:

| Group | Purpose | Example |
|-------|---------|---------|
| `omarchy refresh` | Reset config to defaults (backs up first) | `omarchy refresh shell` |
| `omarchy restart` | Restart a service/app | `omarchy restart shell` |
| `omarchy toggle` | Toggle feature on/off | `omarchy toggle nightlight` |
| `omarchy theme` | Theme management | `omarchy theme set <name>` |
| `omarchy bar` | Bar layout and widgets | `omarchy bar move omarchy.clock --section right` |
| `omarchy plugin` | Manage/clone shell plugins | `omarchy plugin clone omarchy.clock` |
| `omarchy hook` | Install automation hooks | `omarchy hook install theme-set <script>` |
| `omarchy install` | Install optional software / packages | `omarchy install docker dbs` |
| `omarchy launch` | Launch apps | `omarchy launch browser` |
| `omarchy capture` | Screenshots and recordings | `omarchy capture screenshot` |
| `omarchy reminder` | Desktop notification reminders | `omarchy reminder 15 "Pickup Jack"` |
| `omarchy pkg` | Package management | `omarchy pkg add <pkg>` |
| `omarchy setup` | Interactive setup wizards | `omarchy setup security fingerprint` |
| `omarchy update` | System updates | `omarchy update` |

## Configuration Locations

Hyprland config lives in `~/.config/hypr/` — see [`hyprland.md`](hyprland.md).
The Omarchy shell (bar, notifications, plugins, idle) is configured in
`~/.config/omarchy/shell.json` — see [`plugins.md`](plugins.md).

### Terminals

```
~/.config/alacritty/alacritty.toml
~/.config/foot/foot.ini
~/.config/kitty/kitty.conf
~/.config/ghostty/config
```

**Command:** `omarchy restart terminal`

### Other Configs

| App | Location |
|-----|----------|
| btop | `~/.config/btop/btop.conf` |
| fastfetch | `/etc/fastfetch/config.jsonc` default; `~/.config/fastfetch/config.jsonc` user override |
| lazygit | `~/.config/lazygit/config.yml` |
| starship | `~/.config/starship.toml` |
| git | `~/.config/git/config` |

## Safe Customization Patterns

### Edit User Config Directly

For simple changes, edit files in `~/.config/`:

```bash
# 1. Read current config
cat ~/.config/hypr/bindings.lua

# 2. Backup before changes
cp ~/.config/hypr/bindings.lua ~/.config/hypr/bindings.lua.bak.$(date +%s)

# 3. Make changes with Edit tool

# 4. Apply changes
# - Hyprland: auto-reloads on save, but MUST validate with `hyprctl reload` and `hyprctl configerrors`
# - Omarchy shell: shell.json and user plugin code under ~/.config/omarchy/plugins/ hot-reload on save
# - Menus/launcher: ~/.config/omarchy/extensions/omarchy-menu.jsonc hot-reloads on save
# - Terminals: apply with `omarchy restart terminal` (reloads running terminals; foot picks changes up in new windows)
```

### Reset to Defaults -- ALWAYS SEEK USER CONFIRMATION BEFORE RUNNING

When customizations go wrong:

```bash
# Reset specific config (creates backup automatically)
omarchy refresh shell
omarchy refresh hyprland

# The refresh command:
# 1. Backs up current config with timestamp
# 2. Copies default from $OMARCHY_PATH/config/
# 3. Restarts the component where the refresh needs it (e.g. `refresh shell`)
```

## System Commands

```bash
omarchy update                  # Full system update
omarchy version                 # Show Omarchy version
omarchy debug --no-sudo --print # Debug info (ALWAYS use these flags)
omarchy system lock             # Lock screen
omarchy system shutdown         # Shutdown
omarchy system reboot           # Reboot
```

**IMPORTANT:** Always run `omarchy debug` with `--no-sudo --print` flags to avoid interactive sudo prompts that will hang the terminal.

## Troubleshooting

```bash
# Get debug information (ALWAYS use these flags to avoid interactive prompts)
omarchy debug --no-sudo --print

# Reset specific config to defaults
omarchy refresh <app>

# Refresh specific config file
# config-file path is relative to ~/.config/
# eg. `omarchy refresh config hypr/hyprland.lua` will refresh ~/.config/hypr/hyprland.lua
omarchy refresh config <config-file>

# Full reinstall of configs (nuclear option)
omarchy reinstall
```

## Decision Framework

When user requests system changes:

1. **Is it a stock omarchy command?** Use it directly
2. **Is it a config edit?** Edit in `~/.config/`, never `/usr/share/omarchy/`
3. **Is it a theme customization?** Follow [`theming.md`](theming.md); create a NEW custom theme directory
4. **Is it automation?** Follow [`hooks.md`](hooks.md); use `omarchy hook install` and the hook `.d` directories
5. **Is it a package install?** Use `omarchy pkg add <pkgs...>` (or `omarchy pkg aur add <pkgs...>` for AUR-only packages)
6. **Is it built-in shell/plugin code?** Follow [`plugins.md`](plugins.md); clone it with `omarchy plugin clone`, never edit the packaged copy
7. **Unsure if command exists?** Run `omarchy commands` (or `omarchy <group> --help` for one group)

### Reminder Requests

When the user asks to set a reminder, use `omarchy reminder <minutes> [message]` directly. Convert natural language durations to minutes and title-case short reminder labels when appropriate.

```bash
omarchy reminder 15 "Pickup Jack"
omarchy reminder 60 "Check laundry"
omarchy reminder show
omarchy reminder clear
```

## Out of Scope

This skill intentionally does not cover Omarchy source development. Do not use this skill for:
- Editing files in `/usr/share/omarchy/` (`bin/`, `config/`, `default/`, `shell/`, `themes/`, `migrations/`, etc.)
- Creating or editing migrations
- Running `omarchy dev ...` commands

## Example Requests

- "Change my theme to catppuccin" -> `omarchy theme set catppuccin`
- "Add a keybinding for Super+E to open file manager" -> Check existing bindings first, call `hl.unbind` if needed, then `o.bind` in `~/.config/hypr/bindings.lua`
- "Configure my external monitor" -> Edit `~/.config/hypr/monitors.lua`
- "Make the window gaps smaller" -> Edit `~/.config/hypr/looknfeel.lua`
- "Turn on night light" -> `omarchy toggle nightlight` (for time-based schedules, edit `~/.config/hypr/hyprsunset.conf` profiles, then `omarchy restart hyprsunset`)
- "Set a reminder to pickup jack in 15 minutes" -> `omarchy reminder 15 "Pickup Jack"`
- "Show my reminders" -> `omarchy reminder show`
- "Clear all reminders" -> `omarchy reminder clear`
- "Customize the catppuccin theme colors" -> Overlay: put an edited `colors.toml` in `~/.config/omarchy/themes/catppuccin/`, then re-apply the theme (see `theming.md`)
- "Run a script every time I change themes" -> Install it with `omarchy hook install theme-set <script>`
- "Change how workspace labels are rendered" -> Clone `omarchy.workspaces`, which switches the bar to `<username>.workspaces`, then edit the clone
- "Lock after ten minutes" -> Set `idle.lock` to `600` in `~/.config/omarchy/shell.json`
- "Reset shell/bar to defaults" -> `omarchy refresh shell`
- "Record my screen" -> `omarchy screenrecord --fullscreen`, then `omarchy screenrecord --stop-recording` (see `capture.md`)
- "Report this bug to Omarchy" -> Gather diagnostics and a capture of the problem, then file it (see `contributing.md`)

Base directory for this skill: /home/mb/.agents/skills/omarchy
Relative paths in this skill (e.g., scripts/, reference/) are relative to this base directory.
Note: file list is sampled.

<skill_files>
<file>/home/mb/.agents/skills/omarchy/hooks.md</file>
<file>/home/mb/.agents/skills/omarchy/theming.md</file>
<file>/home/mb/.agents/skills/omarchy/capture.md</file>
<file>/home/mb/.agents/skills/omarchy/contributing.md</file>
<file>/home/mb/.agents/skills/omarchy/hyprland.md</file>
<file>/home/mb/.agents/skills/omarchy/plugins.md</file>
</skill_files>
</skill_content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.6s)

_Thinking:_



**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.agents/skills/omarchy/theming.md"
}
```

**Output:**
```
<path>/home/mb/.agents/skills/omarchy/theming.md</path>
<type>file</type>
<content>
1: # Themes, Backgrounds, and Fonts
2: 
3: Read this before changing themes, backgrounds, fonts, or theme colors.
4: 
5: ## Theme Commands
6: 
7: ```bash
8: omarchy theme list              # Show available themes
9: omarchy theme current           # Show current theme
10: omarchy theme set <name>        # Apply theme ("Tokyo Night" and "tokyo-night" both work)
11: omarchy theme bg next           # Cycle background
12: omarchy theme install <url>     # Install from git repo
13: ```
14: 
15: ## Making a New Theme
16: 
17: 1. Create a directory under `~/.config/omarchy/themes`.
18: 2. See how an existing theme is done via `/usr/share/omarchy/themes/catppuccin`.
19: 3. Download a matching background (or several) from the internet and put them in `~/.config/omarchy/themes/<name-of-new-theme>/backgrounds/`.
20: 4. When done with the theme, run `omarchy theme set "Name of new theme"`.
21: 
22: Additional user backgrounds for any theme (stock or custom) go in
23: `~/.config/omarchy/backgrounds/<theme-slug>/`.
24: 
25: ## What a Theme Installed From a Repo May Not Contain
26: 
27: A theme the user wrote by hand in `~/.config/omarchy/themes` is unrestricted, as
28: are Omarchy's own themes. From a theme cloned by `omarchy theme install`, Omarchy
29: drops only what runs code: any `*.lua` (Hyprland requires a theme's
30: `hyprland.lua` and `gum_env.lua` at login, Neovim loads `neovim.lua` at startup),
31: the terminal configs `alacritty.toml`, `foot.ini`, `ghostty.conf` and
32: `kitty.conf` (each names the program the terminal launches), and `vscode.json`
33: (names a VS Code extension to install). Those are regenerated from `colors.toml`
34: through `$OMARCHY_PATH/default/themed/*.tpl`, and named on stderr.
35: 
36: Everything else a cloned theme ships is kept, including `btop.theme`,
37: `chromium.theme`, `helix.toml`, `icons.theme`, `keyboard.rgb` and `shell.toml`.
38: Omarchy tells a cloned theme from the user's own by the `.git` directory a clone
39: leaves behind.
40: 
41: To change how Omarchy themes an app for every theme, write the template rather
42: than the theme: `~/.config/omarchy/themed/<config-name>.tpl` overrides the
43: built-in one. See `docs/theming.md` in the Omarchy repo.
44: 
45: ## Customizing a Stock Theme
46: 
47: Never edit stock themes under `/usr/share/omarchy/themes/` — changes are lost
48: on update. Two safe options:
49: 
50: Both write into `~/.config/omarchy/themes`, where a theme the user wrote is
51: unrestricted — the list above applies only to a theme cloned from a repo.
52: 
53: **Overlay (preferred for small tweaks):** create a user theme directory with
54: the SAME slug containing only the files you want to change. When the theme is
55: applied, the stock theme is copied first and your files win on top:
56: 
57: ```bash
58: mkdir -p ~/.config/omarchy/themes/catppuccin
59: cp /usr/share/omarchy/themes/catppuccin/colors.toml ~/.config/omarchy/themes/catppuccin/
60: # Edit the copied colors.toml, then re-apply:
61: omarchy theme set catppuccin
62: ```
63: 
64: **Fork:** copy the whole stock theme under a new name for a fully independent
65: variant:
66: 
67: ```bash
68: cp -r /usr/share/omarchy/themes/catppuccin ~/.config/omarchy/themes/catppuccin-custom
69: # Edit ~/.config/omarchy/themes/catppuccin-custom/, then:
70: omarchy theme set catppuccin-custom
71: ```
72: 
73: ## Fonts
74: 
75: ```bash
76: omarchy font list               # Available fonts
77: omarchy font current            # Current font
78: omarchy font set <name>         # Change font
79: ```

(End of file - total 79 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml"
}
```

**Output:**
```
<path>/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml</path>
<type>file</type>
<content>
1: import QtQuick
2: import QtQuick.Layouts
3: import Quickshell.Hyprland
4: import qs.Commons
5: import qs.Ui
6: 
7: BarWidget {
8:   id: root
9:   moduleName: "omarchy.workspaces"
10: 
11:   function workspaceById(id) {
12:     var values = Hyprland.workspaces.values
13:     for (var i = 0; i < values.length; i++) {
14:       if (values[i].id === id) return values[i]
15:     }
16: 
17:     return null
18:   }
19: 
20:   function workspaceIds() {
21:     var ids = [1, 2, 3, 4, 5]
22:     var values = Hyprland.workspaces.values
23: 
24:     for (var i = 0; i < values.length; i++) {
25:       var id = values[i].id
26:       if (id > 0 && id <= 10 && ids.indexOf(id) === -1) ids.push(id)
27:     }
28: 
29:     ids.sort(function(left, right) { return left - right })
30:     return ids
31:   }
32: 
33:   function focusWorkspace(id) {
34:     if (!root.bar) return
35:     root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
36:   }
37: 
38:   function workspaceLabel(id) {
39:     if (id === 1) return "1_code"
40:     if (id === 2) return "2_browser"
41:     if (id === 3) return "3_terminal"
42:     if (id === 10) return "0_youtube"
43:     return null
44:   }
45: 
46:   readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)
47: 
48:   implicitWidth: grid.implicitWidth + trailingGap
49:   implicitHeight: grid.implicitHeight
50: 
51:   GridLayout {
52:     id: grid
53:     anchors.fill: parent
54:     anchors.rightMargin: root.trailingGap
55:     columns: root.vertical ? 1 : root.workspaceIds().length
56:     columnSpacing: root.vertical ? 0 : Style.space(1)
57:     rowSpacing: root.vertical ? Style.space(2) : 0
58: 
59:     Repeater {
60:       model: root.workspaceIds()
61: 
62:       WidgetButton {
63:         required property int modelData
64: 
65:         readonly property var workspace: root.workspaceById(modelData)
66:         readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
67:         readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData
68: 
69:         bar: root.bar
70:         readonly property string customLabel: root.workspaceLabel(modelData)
71:         text: customLabel !== "" && customLabel !== null ? customLabel : (focused ? "󰻿" : String(modelData))
72:         opacity: occupied || focused ? 1 : 0.5
73:         horizontalMargin: 6
74:         verticalPadding: 6
75:         fixedWidth: customLabel !== "" && customLabel !== null ? (root.vertical ? root.barSize : -1) : (root.vertical ? root.barSize : Style.space(20))
76:         fixedHeight: root.barSize
77:         onPressed: function() { root.focusWorkspace(modelData) }
78:       }
79:     }
80:   }
81: }

(End of file - total 81 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/usr/share/omarchy/shell/Ui/WidgetButton.qml"
}
```

**Output:**
```
<path>/usr/share/omarchy/shell/Ui/WidgetButton.qml</path>
<type>file</type>
<content>
1: import QtQuick
2: import qs.Commons
3: 
4: Item {
5:   id: root
6: 
7:   property var bar: null
8:   property string text: ""
9:   property string fontFamily: bar ? bar.fontFamily : Style.font.family
10:   property real fontSize: Style.font.body
11:   property color foreground: bar ? bar.barForeground : Color.foreground
12:   property color activeColor: bar ? bar.urgent : Color.urgent
13:   property bool active: false
14:   property real horizontalMargin: 8.5
15:   property real verticalPadding: 6
16:   property real fixedWidth: -1
17:   property real fixedHeight: -1
18:   property real textRotation: 0
19:   property bool keepSpace: false
20:   property bool dimmed: false
21:   property bool concealed: false
22:   property bool interactive: true
23:   property bool pressable: true
24:   property bool useActiveColor: true
25:   property bool maintainIndicatorReveal: false
26:   property bool labelVisible: true
27:   property bool hasVisualContent: text !== ""
28:   property var revealHost: bar
29:   property string tooltipText: ""
30:   property var registeredBar: null
31: 
32:   signal pressed(int button)
33:   signal wheelMoved(int delta)
34: 
35:   function triggerPress(button) {
36:     if (root.bar) root.bar.hideTooltip(root)
37:     root.pressed(button)
38:   }
39: 
40:   function hideOwnTooltip() {
41:     if (root.bar) root.bar.hideTooltip(root)
42:   }
43: 
44:   function syncClickRegistration() {
45:     if (registeredBar && registeredBar.unregisterClickTarget) registeredBar.unregisterClickTarget(root)
46:     registeredBar = root.bar
47:     if (registeredBar && registeredBar.registerClickTarget) registeredBar.registerClickTarget(root)
48:   }
49: 
50:   onBarChanged: syncClickRegistration()
51:   onVisibleChanged: if (!visible) hideOwnTooltip()
52:   onInteractiveChanged: if (!interactive) hideOwnTooltip()
53:   onConcealedChanged: if (concealed) hideOwnTooltip()
54:   Component.onCompleted: syncClickRegistration()
55:   Component.onDestruction: if (registeredBar && registeredBar.unregisterClickTarget) registeredBar.unregisterClickTarget(root)
56: 
57:   readonly property bool vertical: bar ? bar.vertical : false
58:   readonly property int barSize: bar ? bar.barSize : Style.bar.sizeHorizontal
59:   readonly property real scaledHorizontalMargin: Style.spaceReal(horizontalMargin)
60:   readonly property real scaledVerticalPadding: Style.spaceReal(verticalPadding)
61:   readonly property bool tooltipHovered: visible && interactive && !concealed && mouseArea.containsMouse
62:   // Width of the painted label, for bar chrome that wants to line up with the
63:   // text rather than with the slot it sits in. Zero on icon-only buttons.
64:   readonly property real labelWidth: label.visible ? label.implicitWidth : 0
65: 
66:   visible: hasVisualContent || keepSpace
67:   opacity: !hasVisualContent || concealed ? 0 : (dimmed ? 0.45 : 1)
68:   implicitWidth: fixedWidth > 0 ? fixedWidth : (vertical ? barSize : Math.max(12, label.implicitWidth + scaledHorizontalMargin * 2))
69:   implicitHeight: fixedHeight > 0 ? fixedHeight : (vertical ? Math.max(12, label.implicitHeight + scaledVerticalPadding * 2) : barSize)
70: 
71:   Behavior on opacity {
72:     NumberAnimation { duration: 140; easing.type: Easing.OutCubic }
73:   }
74: 
75:   Text {
76:     id: label
77:     textFormat: Text.PlainText
78:     visible: root.labelVisible
79:     anchors.centerIn: parent
80:     text: root.text
81:     color: root.active && root.useActiveColor ? root.activeColor : root.foreground
82:     font.family: root.fontFamily
83:     font.pixelSize: root.fontSize
84:     renderType: Text.NativeRendering
85:     rotation: root.textRotation
86:     horizontalAlignment: Text.AlignHCenter
87:     verticalAlignment: Text.AlignVCenter
88: 
89:     Behavior on color {
90:       enabled: !root.bar || root.bar.foregroundAnimationEnabled
91:       ColorAnimation { duration: 160 }
92:     }
93:   }
94: 
95:   MouseArea {
96:     id: mouseArea
97:     anchors.fill: parent
98:     acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
99:     enabled: root.interactive
100:     hoverEnabled: true
101:     cursorShape: root.pressable ? Qt.PointingHandCursor : Qt.ArrowCursor
102:     onEntered: {
103:       if (root.bar) {
104:         root.bar.showTooltip(root, root.tooltipText)
105:       }
106:       if (root.maintainIndicatorReveal && root.revealHost && root.revealHost.setIndicatorItemHovered)
107:         root.revealHost.setIndicatorItemHovered(true)
108:     }
109:     onExited: {
110:       if (root.bar) {
111:         root.bar.hideTooltip(root)
112:       }
113:       if (root.maintainIndicatorReveal && root.revealHost && root.revealHost.setIndicatorItemHovered)
114:         root.revealHost.setIndicatorItemHovered(false)
115:     }
116:     onClicked: function(mouse) { if (root.pressable) root.triggerPress(mouse.button) }
117:     onWheel: function(wheel) { root.wheelMoved(wheel.angleDelta.y) }
118:   }
119: }

(End of file - total 119 lines)
</content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.3s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "ls /usr/share/omarchy/shell/Commons/ 2>&1; echo \"===\"; omarchy theme current 2>&1; echo \"===\"; ls ~/.config/omarchy/themes/ 2>&1; ls /usr/share/omarchy/themes/ 2>&1 | head -n 20"
}
```

**Output:**
```
BorderGeometry.js
Border.qml
Color.qml
qmldir
Style.qml
Util.qml
===
Gruvbox
===
bengaluru
catppuccin
catppuccin-latte
ethereal
everforest
flexoki-light
gruvbox
hackerman
kanagawa
last-horizon
lumon
lupine
matte-black
miasma
nord
osaka-jade
retro-82
ristretto
rose-pine
solitude
tokyo-night

```

---

## Assistant (Build · Muse Spark 1.3 Free · 1.7s)

**Tool: read**

**Input:**
```json
{
  "filePath": "/usr/share/omarchy/shell/Commons/Color.qml"
}
```

**Output:**
```
<path>/usr/share/omarchy/shell/Commons/Color.qml</path>
<type>file</type>
<content>
1: pragma Singleton
2: import QtQuick
3: import Quickshell
4: import Quickshell.Io
5: import "BorderGeometry.js" as Geometry
6: 
7: // Color surfaces for the shell. Foundational palette (foreground, background,
8: // accent, urgent) comes from theme/colors.toml. Per-surface roles come from
9: // theme/shell.toml — generated per theme from default/themed/shell.toml.tpl,
10: // or shipped directly by a theme to replace the generated file. Surfaces that
11: // don't appear in shell.toml fall back to the foundational palette.
12: QtObject {
13:   id: root
14: 
15:   readonly property string home: Quickshell.env("HOME")
16:   readonly property string stateHome: home + "/.local/state"
17:   readonly property string currentThemePath: stateHome + "/omarchy/current/theme"
18: 
19:   property color foreground: "#cacccc"
20:   property color background: "#101315"
21:   property color accent: "#cacccc"
22:   property color urgent: "#a55555"
23:   property color muted: "#707880"
24: 
25:   // Flat dictionary of "section.key" -> raw string from shell.toml.
26:   // Reassigning this whole property is what makes surface bindings below
27:   // re-evaluate when the theme swaps; mutating it in place would not.
28:   property var shellValues: ({})
29: 
30:   function pick(key, fallback) {
31:     var v = shellValues[key]
32:     return (typeof v === "string" && v.length > 0) ? v : fallback
33:   }
34: 
35:   function pickAlpha(key, fallback) {
36:     var v = shellValues[key]
37:     if (typeof v !== "string" || v.length === 0) return fallback
38:     var n = Number(v)
39:     if (!isFinite(n)) return fallback
40:     return Util.clampAlpha(n)
41:   }
42: 
43:   function firstColorToken(value) {
44:     var parts = String(value || "").replace(/^\s+|\s+$/g, "").split(/\s+/)
45:     for (var i = 0; i < parts.length; i++) {
46:       if (!parts[i].match(/^-?\d+(?:\.\d+)?deg$/)) return parts[i]
47:     }
48:     return value
49:   }
50: 
51:   function flatColor(value, fallback) {
52:     var token = firstColorToken(value)
53:     var role = String(token || "").replace(/^\s+|\s+$/g, "").toLowerCase()
54:     if (root.shellValues[role] && root.shellValues[role] !== token) return flatColor(root.shellValues[role], fallback)
55:     if (role === "foreground" || role === "text") return root.foreground
56:     if (role === "accent") return root.accent
57:     if (role === "urgent") return root.urgent
58:     if (role === "muted") return root.muted
59:     if (role === "background") return root.background
60:     if (role === "transparent") return Qt.rgba(0, 0, 0, 0)
61: 
62:     var color = Geometry.canonicalColor(token, 1)
63:     if (typeof color === "string" && color === token && token.charAt(0) !== "#") return fallback
64:     return color
65:   }
66: 
67:   // Compose a color from a base-color key and its `-alpha` companion. If the
68:   // base token is a gradient, color-only consumers use the first stop.
69:   function composed(colorKey, alphaKey, colorFallback, alphaFallback) {
70:     return Util.alpha(flatColor(pick(colorKey, colorFallback), colorFallback), pickAlpha(alphaKey, alphaFallback))
71:   }
72: 
73:   readonly property QtObject bar: QtObject {
74:     property color background: root.composed("bar.background", "bar.background-alpha", root.background, 1.0)
75:     property color text: root.pick("bar.text", root.foreground)
76:     property color active: root.pick("bar.active", root.urgent)
77:   }
78:   readonly property QtObject popups: QtObject {
79:     property color background: root.composed("popups.background", "popups.background-alpha", root.background, 1.0)
80:     property color text: root.pick("popups.text", root.foreground)
81:     property color border: root.composed("popups.border", "popups.border-alpha", root.accent, 1.0)
82:   }
83:   readonly property QtObject tooltip: QtObject {
84:     property color background: root.composed("tooltip.background", "tooltip.background-alpha", root.background, 1.0)
85:     property color text: root.pick("tooltip.text", root.foreground)
86:     property color border: root.composed("tooltip.border", "tooltip.border-alpha", root.foreground, 1.0)
87:   }
88:   readonly property QtObject notifications: QtObject {
89:     property color background: root.composed("notifications.background", "notifications.background-alpha", root.background, 1.0)
90:     property color text: root.pick("notifications.text", root.foreground)
91:     property color border: root.composed("notifications.border", "notifications.border-alpha", root.accent, 1.0)
92:     property color countdown: root.pick("notifications.countdown", root.accent)
93:   }
94:   readonly property QtObject menu: QtObject {
95:     property color background: root.composed("menu.background", "menu.background-alpha", root.background, 1.0)
96:     property color text: root.pick("menu.text", root.foreground)
97:     property color border: root.composed("menu.border", "menu.border-alpha", root.foreground, 1.0)
98:     property color scrim: root.composed("menu.scrim", "menu.scrim-alpha", root.background, 0.5)
99:     property color selectedBackground: root.composed("menu.selected-background", "menu.selected-background-alpha", root.foreground, 0.08)
100:     property color selectedText: root.pick("menu.selected-text", root.accent)
101:     property color selectedBorder: root.composed("menu.selected-border", "menu.selected-border-alpha", root.foreground, 0.0)
102:   }
103:   // polkit + lock share a single border-alpha across border / border-active /
104:   // border-error: the three states are mutually exclusive in time, so one
105:   // companion is enough.
106:   readonly property QtObject polkit: QtObject {
107:     property color background: root.composed("polkit.background", "polkit.background-alpha", root.background, 1.0)
108:     property color text: root.pick("polkit.text", root.foreground)
109:     property color textError: root.pick("polkit.text-error", root.urgent)
110:     property color border: root.composed("polkit.border", "polkit.border-alpha", root.accent, 1.0)
111:     property color borderError: root.composed("polkit.border-error", "polkit.border-alpha", root.urgent, 1.0)
112:     property color accent: root.pick("polkit.accent", root.accent)
113:     property color scrim: root.composed("polkit.scrim", "polkit.scrim-alpha", root.background, 0.5)
114:   }
115:   readonly property QtObject lock: QtObject {
116:     property color background: root.composed("lock.background", "lock.background-alpha", root.background, 0.8)
117:     property color text: root.pick("lock.text", root.foreground)
118:     property color placeholder: root.shellValues["lock.placeholder"] ? root.flatColor(root.shellValues["lock.placeholder"], Util.alpha(root.foreground, 0.66)) : Util.alpha(root.foreground, 0.66)
119:     property color textError: root.pick("lock.text-error", root.urgent)
120:     property color border: root.composed("lock.border", "lock.border-alpha", root.foreground, 1.0)
121:     property color borderActive: root.composed("lock.border-active", "lock.border-alpha", root.accent, 1.0)
122:     property color borderError: root.composed("lock.border-error", "lock.border-alpha", root.urgent, 1.0)
123:     property color selection: root.composed("lock.selection", "lock.selection-alpha", root.accent, 0.45)
124:   }
125:   // The image picker has no card surface; `scrim` is the full-screen dim
126:   // wash, and per-slice dim overlays / text outlines use the foundational
127:   // `background` color directly.
128:   readonly property QtObject imagePicker: QtObject {
129:     property color scrim: root.composed("image-picker.scrim", "image-picker.scrim-alpha", root.background, 0.5)
130:     property color text: root.pick("image-picker.text", root.foreground)
131:     property color selectedBorder: root.composed("image-picker.selected-border", "image-picker.selected-border-alpha", root.accent, 1.0)
132:     property color unselectedBorder: root.composed("image-picker.unselected-border", "image-picker.unselected-border-alpha", root.foreground, 0.28)
133:   }
134: 
135:   function loadColors(raw) {
136:     var lines = String(raw || "").split("\n")
137:     var foundAccent = false
138:     var foundMuted = false
139:     var loadedForeground = false
140:     var loadedBackground = false
141:     var color0Value = ""
142:     var color4Value = ""
143:     var color7Value = ""
144:     var color8Value = ""
145:     for (var i = 0; i < lines.length; i++) {
146:       var match = lines[i].match(/^\s*([A-Za-z0-9_-]+)\s*=\s*["']?(#[0-9A-Fa-f]{6})/)
147:       if (!match) continue
148:       if (match[1] === "foreground") { foreground = match[2]; loadedForeground = true }
149:       else if (match[1] === "background") { background = match[2]; loadedBackground = true }
150:       // Prefer the explicit `accent` key; only fall back to color4 when the
151:       // theme doesn't define a separate accent. color4 appears later in the
152:       // file so the old single-property approach clobbered accent with it.
153:       else if (match[1] === "accent") { accent = match[2]; foundAccent = true }
154:       else if (match[1] === "muted") { muted = match[2]; foundMuted = true }
155:       else if (match[1] === "color0") color0Value = match[2]
156:       else if (match[1] === "color4") color4Value = match[2]
157:       else if (match[1] === "color7") color7Value = match[2]
158:       else if (match[1] === "color8") color8Value = match[2]
159:       else if (match[1] === "red" || match[1] === "color1") urgent = match[2]
160:     }
161:     if (!loadedBackground && color0Value.length > 0) background = color0Value
162:     if (!loadedForeground && color7Value.length > 0) foreground = color7Value
163:     if (!foundAccent && color4Value.length > 0) accent = color4Value
164:     if (!foundMuted) muted = color8Value.length > 0 ? color8Value : foreground
165:   }
166: 
167:   // Last theme-supplied and user-supplied shell.toml dicts, kept separate so
168:   // either can be reloaded without re-reading the other. `shellValues` is
169:   // always the merge of theme (base) and user (override) — see mergeShell.
170:   property var themeShellValues: ({})
171:   property var userShellValues: ({})
172: 
173:   // Single TOML walker for shell.toml. Both Color (surface roles) and Style
174:   // (typography, spacing, bar, control states) consume the resulting dict.
175:   // Accepts quoted strings, bare numeric values, bare width lists, and bare
176:   // role names; tolerates inline comments. Numbers are kept as strings here —
177:   // readers coerce when they pull a value.
178:   function parseShell(raw) {
179:     var parsed = {}
180:     var text = String(raw || "")
181:     if (text) {
182:       var lines = text.split("\n")
183:       var section = ""
184:       for (var i = 0; i < lines.length; i++) {
185:         var line = lines[i].replace(/^\s+|\s+$/g, "")
186:         if (!line || line.charAt(0) === "#") continue
187:         var sectionMatch = line.match(/^\[([A-Za-z0-9_-]+)\]\s*(#.*)?$/)
188:         if (sectionMatch) { section = sectionMatch[1]; continue }
189:         var stringKv = line.match(/^([A-Za-z0-9_-]+)\s*=\s*["']([^"']+)["']\s*(#.*)?$/)
190:         var numKv = line.match(/^([A-Za-z0-9_-]+)\s*=\s*(-?\d+(?:\.\d+)?)\s*(#.*)?$/)
191:         var widthKv = line.match(/^([A-Za-z0-9_-]+)\s*=\s*(-?\d+(?:\.\d+)?(?:\s+-?\d+(?:\.\d+)?){1,3})\s*(#.*)?$/)
192:         var bareKv = line.match(/^([A-Za-z0-9_-]+)\s*=\s*([A-Za-z][A-Za-z0-9_-]*)\s*(#.*)?$/)
193:         var kv = stringKv || numKv || widthKv || bareKv
194:         if (!kv || !section) continue
195:         parsed[section + "." + kv[1]] = kv[2]
196:       }
197:     }
198:     return parsed
199:   }
200: 
201:   // Re-derive `shellValues` from theme base + user override and push it to
202:   // Style. User keys win, so a machine-level `~/.config/omarchy/shell.toml`
203:   // survives theme switches (which replace only themeShellValues).
204:   function mergeShell() {
205:     var merged = {}
206:     for (var tk in themeShellValues) merged[tk] = themeShellValues[tk]
207:     for (var uk in userShellValues) merged[uk] = userShellValues[uk]
208:     shellValues = merged
209:     Style.applyShellValues(merged)
210:   }
211: 
212:   function loadShell(raw) {
213:     themeShellValues = parseShell(raw)
214:     mergeShell()
215:   }
216: 
217:   function loadUserShell(raw) {
218:     userShellValues = parseShell(raw)
219:     mergeShell()
220:   }
221: 
222:   // Startup load only. Runtime theme switches push the payload explicitly
223:   // through shell IPC.
224:   property FileView colorsFile: FileView {
225:     id: colorsFile
226:     path: root.currentThemePath + "/colors.toml"
227:     watchChanges: false
228:     printErrors: false
229:     onLoaded: root.loadColors(text())
230:   }
231:   property FileView shellFile: FileView {
232:     id: shellFile
233:     path: root.currentThemePath + "/shell.toml"
234:     watchChanges: false
235:     printErrors: false
236:     onLoaded: root.loadShell(text())
237:     onLoadFailed: root.loadShell("")
238:   }
239:   // Machine-level override, layered on top of whatever theme is active. This
240:   // is where `omarchy display text size` writes `[font] base-size`. Watched so the
241:   // CLI takes effect live without restarting the shell; absent by default.
242:   property FileView userShellFile: FileView {
243:     id: userShellFile
244:     path: root.home + "/.config/omarchy/shell.toml"
245:     watchChanges: true
246:     printErrors: false
247:     onLoaded: root.loadUserShell(text())
248:     // Re-read on change (including first creation) before loading — `text()`
249:     // is stale in the change signal itself, so route both paths through reload
250:     // → onLoaded to always parse fresh content.
251:     onFileChanged: reload()
252:     onLoadFailed: root.loadUserShell("")
253:   }
254: }

(End of file - total 254 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/usr/share/omarchy/shell/Commons/Style.qml"
}
```

**Output:**
```
<path>/usr/share/omarchy/shell/Commons/Style.qml</path>
<type>file</type>
<content>
1: pragma Singleton
2: import QtQuick
3: import Quickshell
4: import Quickshell.Io
5: 
6: // Shared structural style tokens for the shell. Color is the palette
7: // singleton; Style holds everything else themes can influence — corner
8: // rounding, gap to screen edges, state affordances, spacing, typography
9: // scale, and bar dimensions.
10: //
11: // `cornerRadius` mirrors Hyprland's `decoration:rounding`. `gapsOut` is
12: // half of Hyprland's `general:gaps_out` — Hyprland's value works well as
13: // a window-to-window gap but feels too cavernous when used as the
14: // distance from a panel/notification to the screen edge, so the shell
15: // halves it. Themes and user Hyprland config own those values; the
16: // shell picks them up by re-running `hyprctl getoption` on startup and
17: // after theme IPC applies a theme.
18: //
19: // Typography, spacing, and bar size come from theme/shell.toml.
20: // `[font] base-size` is the rem root; every `Style.font.<token>` derives
21: // from it via the scale multipliers below unless the theme pins that
22: // specific token. `[spacing] scale` multiplies shared margins, gaps,
23: // padding, controls, and panel dimensions while preserving each component's
24: // proportions; by default it also tracks `base-size`. `[bar]
25: // size-horizontal` / `size-vertical` set the cross-axis dimension for
26: // top/bottom and left/right bars at the default 12px font size; by default
27: // those dimensions scale with `base-size` so larger fonts don't clip.
28: QtObject {
29:   id: root
30: 
31:   property int cornerRadius: 0
32:   property int gapsOut: 5
33: 
34:   // ---------------------------------------------------------- state tokens
35:   //
36:   // Shared interactive-state tokens for every reusable surface in the kit.
37:   // The vocabulary:
38:   //   normal       — idle control chrome
39:   //   hover-cursor — mouse hover OR panel keyboard cursor (`hasCursor`)
40:   //   selected     — persistent chosen/current state
41:   //   focus        — actual Qt activeFocus, defaulting to hover-cursor
42:   //
43:   // Each state has a color token plus fill/border alphas. Color tokens
44:   // may be palette roles (`foreground`, `accent`, `urgent`, `background`)
45:   // or hex colors. Set a state's border width to 0 to drop that border.
46:   property var styleOverrides: ({})
47: 
48:   function styleRawNum(key) {
49:     var v = styleOverrides[key]
50:     var n = Number(v)
51:     return isFinite(n) ? n : null
52:   }
53: 
54:   function styleNum(key, fallback) {
55:     var n = styleRawNum(key)
56:     return n === null ? fallback : n
57:   }
58: 
59:   function styleAlpha(key, fallback) {
60:     return Util.clampAlpha(styleNum(key, fallback))
61:   }
62: 
63:   function styleString(key, fallback) {
64:     var v = styleOverrides[key]
65:     if (typeof v !== "string") return fallback
66:     v = v.replace(/^\s+|\s+$/g, "")
67:     return v.length > 0 ? v : fallback
68:   }
69: 
70:   readonly property string normalColorToken: styleString("normal-color", "foreground")
71:   readonly property string hoverColorToken: styleString("hover-cursor-color", "foreground")
72:   readonly property string selectedColorToken: styleString("selected-color", "foreground")
73:   readonly property string pressedColorToken: styleString("pressed-color", hoverColorToken)
74:   readonly property string focusColorToken: styleString("focus-color", hoverColorToken)
75:   readonly property string selectionColorToken: styleString("selection-color", "foreground")
76: 
77:   readonly property int normalBorderWidth: Math.max(0, Math.round(styleNum("normal-border-width", 1)))
78:   readonly property int hoverBorderWidth: Math.max(0, Math.round(styleNum("hover-cursor-border-width", normalBorderWidth)))
79:   readonly property int selectedBorderWidth: Math.max(0, Math.round(styleNum("selected-border-width", 0)))
80:   readonly property int focusBorderWidth: Math.max(0, Math.round(styleNum("focus-border-width", hoverBorderWidth)))
81: 
82:   readonly property real normalFillAlpha:    styleAlpha("normal-fill-alpha", 0.04)
83:   readonly property real hoverFillAlpha:     styleAlpha("hover-cursor-fill-alpha", 0.08)
84:   readonly property real selectedFillAlpha:  styleAlpha("selected-fill-alpha", 0.18)
85:   readonly property real pressedFillAlpha:   styleAlpha("pressed-fill-alpha", 0.22)
86:   readonly property real focusFillAlpha:     styleAlpha("focus-fill-alpha", hoverFillAlpha)
87:   readonly property real selectionFillAlpha: styleAlpha("selection-fill-alpha", 0.35)
88: 
89:   readonly property real normalBorderAlpha:   styleAlpha("normal-border-alpha", 0.4)
90:   readonly property real hoverBorderAlpha:    styleAlpha("hover-cursor-border-alpha", 0.25)
91:   readonly property real selectedBorderAlpha: styleAlpha("selected-border-alpha", 1.0)
92:   readonly property real focusBorderAlpha:    styleAlpha("focus-border-alpha", hoverBorderAlpha)
93: 
94:   function colorFromHex(value, fallback) {
95:     var s = String(value || "").replace(/^\s+|\s+$/g, "")
96:     var shortHex = s.match(/^#([0-9A-Fa-f]{3})$/)
97:     if (shortHex) {
98:       var sh = shortHex[1]
99:       return Qt.rgba(
100:         parseInt(sh.charAt(0) + sh.charAt(0), 16) / 255,
101:         parseInt(sh.charAt(1) + sh.charAt(1), 16) / 255,
102:         parseInt(sh.charAt(2) + sh.charAt(2), 16) / 255,
103:         1)
104:     }
105:     var hex = s.match(/^#([0-9A-Fa-f]{6})([0-9A-Fa-f]{2})?$/)
106:     if (!hex) return fallback
107:     var h = hex[1]
108:     return Qt.rgba(
109:       parseInt(h.substr(0, 2), 16) / 255,
110:       parseInt(h.substr(2, 2), 16) / 255,
111:       parseInt(h.substr(4, 2), 16) / 255,
112:       hex[2] ? parseInt(hex[2], 16) / 255 : 1)
113:   }
114: 
115:   function resolveStateColor(token, foreground, accent, urgent, fallback) {
116:     var fb = fallback || foreground || Color.foreground
117:     var s = String(token || "").replace(/^\s+|\s+$/g, "")
118:     var role = s.toLowerCase()
119:     if (role === "foreground" || role === "text") return foreground || Color.foreground
120:     if (role === "accent") return accent || Color.accent
121:     if (role === "urgent") return urgent || Color.urgent
122:     if (role === "background") return Color.background
123:     if (role === "transparent") return Qt.rgba(0, 0, 0, 0)
124:     return colorFromHex(s, fb)
125:   }
126: 
127:   function normalStateColor(foreground, accent, urgent) {
128:     return resolveStateColor(normalColorToken, foreground, accent, urgent, foreground || Color.foreground)
129:   }
130: 
131:   function hoverStateColor(foreground, accent, urgent) {
132:     return resolveStateColor(hoverColorToken, foreground, accent, urgent, foreground || Color.foreground)
133:   }
134: 
135:   function selectedStateColor(foreground, accent, urgent) {
136:     return resolveStateColor(selectedColorToken, foreground, accent, urgent, foreground || Color.foreground)
137:   }
138: 
139:   function pressedStateColor(foreground, accent, urgent) {
140:     return resolveStateColor(pressedColorToken, foreground, accent, urgent, hoverStateColor(foreground, accent, urgent))
141:   }
142: 
143:   function focusStateColor(foreground, accent, urgent) {
144:     var role = String(focusColorToken || "").replace(/^\s+|\s+$/g, "").toLowerCase()
145:     if (role === "hover" || role === "hover-cursor" || role === "inherit")
146:       return hoverStateColor(foreground, accent, urgent)
147:     return resolveStateColor(focusColorToken, foreground, accent, urgent, hoverStateColor(foreground, accent, urgent))
148:   }
149: 
150:   function selectionStateColor(foreground, accent, urgent) {
151:     return resolveStateColor(selectionColorToken, foreground, accent, urgent, foreground || Color.foreground)
152:   }
153: 
154:   function normalFillFor(foreground, accent, urgent) { return Util.alpha(normalStateColor(foreground, accent, urgent), normalFillAlpha) }
155:   function hoverFillFor(foreground, accent, urgent) { return Util.alpha(hoverStateColor(foreground, accent, urgent), hoverFillAlpha) }
156:   function selectedFillFor(foreground, accent, urgent) { return Util.alpha(selectedStateColor(foreground, accent, urgent), selectedFillAlpha) }
157:   function pressedFillFor(foreground, accent, urgent) { return Util.alpha(pressedStateColor(foreground, accent, urgent), pressedFillAlpha) }
158:   function focusFillFor(foreground, accent, urgent) { return Util.alpha(focusStateColor(foreground, accent, urgent), focusFillAlpha) }
159:   function selectionFillFor(foreground, accent, urgent) { return Util.alpha(selectionStateColor(foreground, accent, urgent), selectionFillAlpha) }
160: 
161:   function normalBorderFor(foreground, accent, urgent) { return Util.alpha(normalStateColor(foreground, accent, urgent), normalBorderAlpha) }
162:   function hoverBorderFor(foreground, accent, urgent) { return Util.alpha(hoverStateColor(foreground, accent, urgent), hoverBorderAlpha) }
163:   function selectedBorderFor(foreground, accent, urgent) { return Util.alpha(selectedStateColor(foreground, accent, urgent), selectedBorderAlpha) }
164:   function focusBorderFor(foreground, accent, urgent) { return Util.alpha(focusStateColor(foreground, accent, urgent), focusBorderAlpha) }
165: 
166:   // Composite helpers for the focus > hover > normal priority chain used by
167:   // every form control surface (TextField, NumberField, Dropdown, Toggle,
168:   // etc.). Saves callers from re-writing the three-line ternary ladder for
169:   // fill / border / border-width on every Rectangle background.
170:   function controlFill(focused, hot, foreground, accent) {
171:     if (focused) return focusFillFor(foreground, accent)
172:     if (hot) return hoverFillFor(foreground, accent)
173:     return normalFillFor(foreground, accent)
174:   }
175: 
176:   function controlBorder(focused, hot, foreground, accent) {
177:     if (focused) return focusBorderFor(foreground, accent)
178:     if (hot) return hoverBorderFor(foreground, accent)
179:     return normalBorderFor(foreground, accent)
180:   }
181: 
182:   function controlBorderWidth(focused, hot) {
183:     if (focused) return focusBorderWidth
184:     if (hot) return hoverBorderWidth
185:     return normalBorderWidth
186:   }
187: 
188:   // Convenience colors resolved against the foundational palette.
189:   readonly property color normalFill: normalFillFor(Color.foreground, Color.accent, Color.urgent)
190:   readonly property color hoverFill: hoverFillFor(Color.foreground, Color.accent, Color.urgent)
191:   readonly property color selectedFill: selectedFillFor(Color.foreground, Color.accent, Color.urgent)
192:   readonly property color pressedFill: pressedFillFor(Color.foreground, Color.accent, Color.urgent)
193:   readonly property color focusFillColor: focusFillFor(Color.foreground, Color.accent, Color.urgent)
194:   readonly property color normalBorderColor: normalBorderFor(Color.foreground, Color.accent, Color.urgent)
195:   readonly property color hoverBorderColor: hoverBorderFor(Color.foreground, Color.accent, Color.urgent)
196:   readonly property color selectedBorderColor: selectedBorderFor(Color.foreground, Color.accent, Color.urgent)
197:   readonly property color focusBorderColor: focusBorderFor(Color.foreground, Color.accent, Color.urgent)
198:   readonly property color selectedAccentFill: Util.alpha(Color.accent, selectedFillAlpha)
199:   readonly property color selectionFill: selectionFillFor(Color.foreground, Color.accent, Color.urgent)
200: 
201:   // ---------------------------------------------------------- spacing
202:   //
203:   // The spacing scale is the shell equivalent of rem for margins, gaps,
204:   // and padding. Components keep their existing proportions by asking for
205:   // the old pixel value through `Style.space(px)` (or `spaceReal(px)` for
206:   // fractional geometry); themes can make the shell denser or roomier
207:   // with `[spacing] scale`, or pin individual tokens.
208:   property real spacingScale: 1.0
209:   property bool spacingScaleWithFont: true
210:   property var spacingOverrides: ({})
211:   readonly property real effectiveSpacingScale: spacingScale * (spacingScaleWithFont ? fontScale : 1)
212: 
213:   function spaceReal(px) {
214:     var n = Number(px)
215:     if (!isFinite(n) || n <= 0) return 0
216:     return n * effectiveSpacingScale
217:   }
218: 
219:   function space(px) {
220:     var n = spaceReal(px)
221:     if (n <= 0) return 0
222:     return Math.max(1, Math.round(n))
223:   }
224: 
225:   function spacingToken(key, fallback) {
226:     var v = spacingOverrides[key]
227:     var n = Number(v)
228:     return (isFinite(n) && n >= 0) ? Math.round(n) : space(fallback)
229:   }
230: 
231:   readonly property QtObject spacing: QtObject {
232:     readonly property real scale: root.effectiveSpacingScale
233: 
234:     readonly property int hairline: root.space(1)
235:     readonly property int xxs: root.spacingToken("xxs", 2)
236:     readonly property int xs: root.spacingToken("xs", 3)
237:     readonly property int sm: root.spacingToken("sm", 4)
238:     readonly property int md: root.spacingToken("md", 6)
239:     readonly property int lg: root.spacingToken("lg", 8)
240:     readonly property int xl: root.spacingToken("xl", 10)
241:     readonly property int xxl: root.spacingToken("xxl", 12)
242:     readonly property int xxxl: root.spacingToken("xxxl", 14)
243:     readonly property int huge: root.spacingToken("huge", 18)
244: 
245:     readonly property int controlGap: root.spacingToken("control-gap", 8)
246:     readonly property int controlPaddingX: root.spacingToken("control-padding-x", 10)
247:     readonly property int controlPaddingY: root.spacingToken("control-padding-y", 6)
248:     readonly property int inputPaddingY: root.spacingToken("input-padding-y", 7)
249:     readonly property int controlHeight: root.spacingToken("control-height", 28)
250:     readonly property int popupRowHeight: root.spacingToken("popup-row-height", 28)
251:     readonly property int dropdownWidth: root.spacingToken("dropdown-width", 240)
252:     readonly property int searchableDropdownWidth: root.spacingToken("searchable-dropdown-width", 260)
253:     readonly property int numberFieldWidth: root.spacingToken("number-field-width", 120)
254:     readonly property int searchablePopupMinHeight: root.spacingToken("searchable-popup-min-height", 220)
255:     readonly property int rowGap: root.spacingToken("row-gap", 8)
256:     readonly property int rowPaddingX: root.spacingToken("row-padding-x", 12)
257:     readonly property int labelGap: root.spacingToken("label-gap", 4)
258:     readonly property int panelGap: root.spacingToken("panel-gap", 14)
259:     readonly property int panelPadding: root.spacingToken("panel-padding", 18)
260:     readonly property int popupPadding: root.spacingToken("popup-padding", 14)
261:   }
262: 
263:   // ---------------------------------------------------------- typography
264:   //
265:   // `fontFamily` defaults to "monospace" so the bar and every qs.Ui
266:   // component follows the fontconfig alias `omarchy-font-set` writes.
267:   // Themes can override per-token via [font] in shell.toml, but the
268:   // family stays system-wide.
269:   property string fontFamily: "monospace"
270: 
271:   // The concrete family `monospace` resolves to right now, e.g.
272:   // "JetBrainsMono Nerd Font". Bind `font.family` to `fontFamily` (so the
273:   // alias path keeps working when the user runs `omarchy font set`), but
274:   // read `resolvedFontFamily` when you want to *display* what's drawing.
275:   property string resolvedFontFamily: "monospace"
276: 
277:   // The only sanity floor is 1px. Themes and users can make this as large
278:   // as they like; if the shell gets ridiculous, that's their call.
279:   property int fontBaseSize: 12
280: 
281:   property var fontOverrides: ({})
282:   property var barOverrides: ({})
283:   property bool barScaleWithFont: true
284:   readonly property real fontScale: Math.max(1 / 12, fontBaseSize / 12)
285: 
286:   function fontPx(mult) {
287:     return Math.max(1, Math.round(fontBaseSize * mult))
288:   }
289: 
290:   function fontToken(key, fallback) {
291:     var v = fontOverrides[key]
292:     var n = Number(v)
293:     return (isFinite(n) && n > 0) ? Math.round(n) : fallback
294:   }
295: 
296:   function barToken(key, fallback) {
297:     var v = barOverrides[key]
298:     var n = Number(v)
299:     var base = (isFinite(n) && n > 0) ? n : fallback
300:     if (barScaleWithFont) base *= fontScale
301:     return Math.max(1, Math.round(base))
302:   }
303: 
304:   function boolToken(value, fallback) {
305:     if (value === undefined || value === null) return fallback
306:     var s = String(value).replace(/^\s+|\s+$/g, "").toLowerCase()
307:     if (s === "true" || s === "1" || s === "yes" || s === "on") return true
308:     if (s === "false" || s === "0" || s === "no" || s === "off") return false
309:     return fallback
310:   }
311: 
312:   // The menu, polkit, emojis, and clipboard surfaces honor an
313:   // OMARCHY_MENU_FONT override for users who want a different family on the
314:   // summoned popups than on the bar. Resolved once at startup; an empty env
315:   // value falls back to the shared fontconfig alias.
316:   readonly property string menuFontFamily: {
317:     var override = Quickshell.env("OMARCHY_MENU_FONT")
318:     return (override && override.length > 0) ? override : fontFamily
319:   }
320: 
321:   readonly property QtObject font: QtObject {
322:     readonly property string family: root.fontFamily
323:     readonly property string resolvedFamily: root.resolvedFontFamily
324:     readonly property string menuFamily: root.menuFontFamily
325:     readonly property int baseSize: root.fontBaseSize
326: 
327:     readonly property int caption:      root.fontToken("caption",       root.fontPx(0.833))   // 10
328:     readonly property int bodySmall:    root.fontToken("body-small",    root.fontPx(0.917))   // 11
329:     readonly property int body:         root.fontToken("body",          root.fontPx(1.0))     // 12
330:     readonly property int subtitle:     root.fontToken("subtitle",      root.fontPx(1.083))   // 13
331:     readonly property int title:        root.fontToken("title",         root.fontPx(1.167))   // 14
332:     readonly property int heading:      root.fontToken("heading",       root.fontPx(1.333))   // 16
333:     readonly property int display:      root.fontToken("display",       root.fontPx(2.0))     // 24
334:     readonly property int displayLarge: root.fontToken("display-large", root.fontPx(2.333))   // 28
335: 
336:     readonly property int iconSmall:    root.fontToken("icon-small",    bodySmall)
337:     readonly property int icon:         root.fontToken("icon",          title)
338:     readonly property int iconLarge:    root.fontToken("icon-large",    root.fontPx(1.5))     // 18
339:   }
340: 
341:   readonly property QtObject bar: QtObject {
342:     readonly property int sizeHorizontal: root.barToken("size-horizontal", 26)
343:     readonly property int sizeVertical:   root.barToken("size-vertical",   28)
344:     readonly property int iconSlot:       root.barToken("icon-slot",       27)
345:     readonly property int iconCanvas:     root.barToken("icon-canvas",     16)
346:     readonly property int iconFont:       root.barToken("icon-font",       13)
347:     readonly property int statusSlot:     root.barToken("status-slot",     21)
348:   }
349: 
350:   function refresh() {
351:     hyprctlProc.running = true
352:     gapsOutProc.running = true
353:   }
354: 
355:   function scheduleRefresh() {
356:     refreshTimer.restart()
357:   }
358: 
359:   function applyRoundingJson(raw) {
360:     try {
361:       var json = JSON.parse(raw || "{}")
362:       var n = Number(json.int)
363:       if (isFinite(n) && n >= 0) cornerRadius = n
364:     } catch (e) {
365:       // hyprctl missing / Hyprland not running — leave the previous value.
366:     }
367:   }
368: 
369:   function applyGapsOutJson(raw) {
370:     try {
371:       var json = JSON.parse(raw || "{}")
372:       var css = String(json.css || "")
373:       var parts = css.match(/-?\d+(?:\.\d+)?/g) || []
374:       var n = parts.length > 0 ? Number(parts[0]) : Number(json.int)
375:       if (isFinite(n) && n >= 0) gapsOut = Math.max(0, Math.round(n / 2))
376:     } catch (e) {
377:       // hyprctl missing / Hyprland not running — leave the previous value.
378:     }
379:   }
380: 
381:   // Pull typography, bar dimensions, state tokens, and spacing out of the
382:   // shell.toml dict that Color already parsed. Called by Color.loadShell so
383:   // a single parse pass feeds both singletons.
384:   function applyShellValues(values) {
385:     var fontOut = {}
386:     var barOut = {}
387:     var styleOut = {}
388:     var spacingOut = {}
389:     var nextBase = 12
390:     var nextSpacingScale = 1.0
391:     var nextSpacingScaleWithFont = true
392:     var nextBarScaleWithFont = true
393:     var v = values || {}
394:     for (var fullKey in v) {
395:       var dot = fullKey.indexOf(".")
396:       if (dot < 0) continue
397:       var section = fullKey.substr(0, dot)
398:       var key = fullKey.substr(dot + 1)
399:       var raw = v[fullKey]
400:       if (section === "font") {
401:         var ival = parseInt(raw, 10)
402:         if (!isFinite(ival)) continue
403:         if (key === "base-size") nextBase = ival
404:         else fontOut[key] = ival
405:       } else if (section === "bar") {
406:         if (key === "scale-with-font") {
407:           nextBarScaleWithFont = boolToken(raw, nextBarScaleWithFont)
408:         } else if (key === "size-horizontal" || key === "size-vertical") {
409:           var b = parseInt(raw, 10)
410:           if (isFinite(b)) barOut[key] = b
411:         }
412:       } else if (section === "spacing") {
413:         if (key === "scale-with-font") {
414:           nextSpacingScaleWithFont = boolToken(raw, nextSpacingScaleWithFont)
415:         } else {
416:           var fval = parseFloat(raw)
417:           if (!isFinite(fval)) continue
418:           if (key === "scale") nextSpacingScale = fval
419:           else spacingOut[key] = fval
420:         }
421:       } else if (section === "controls" || section === "style") {
422:         // Strings are passed through; styleRawNum/styleString coerce on read.
423:         // [style] is the legacy name for [controls].
424:         styleOut[key] = raw
425:       }
426:     }
427:     // Keep only a 1px sanity floor. Per-token overrides aren't clamped
428:     // either — a theme that wants display-large = 64 should be allowed to
429:     // ship it.
430:     if (!isFinite(nextBase) || nextBase < 1) nextBase = 1
431:     if (!isFinite(nextSpacingScale) || nextSpacingScale < 0) nextSpacingScale = 1.0
432:     spacingScale = nextSpacingScale
433:     spacingScaleWithFont = nextSpacingScaleWithFont
434:     fontBaseSize = nextBase
435:     fontOverrides = fontOut
436:     barOverrides = barOut
437:     barScaleWithFont = nextBarScaleWithFont
438:     spacingOverrides = spacingOut
439:     styleOverrides = styleOut
440:   }
441: 
442:   property Process hyprctlProc: Process {
443:     id: hyprctlProc
444:     command: ["hyprctl", "-j", "getoption", "decoration:rounding"]
445:     stdout: StdioCollector {
446:       waitForEnd: true
447:       onStreamFinished: root.applyRoundingJson(text)
448:     }
449:   }
450: 
451:   property Process gapsOutProc: Process {
452:     id: gapsOutProc
453:     command: ["hyprctl", "-j", "getoption", "general:gaps_out"]
454:     stdout: StdioCollector {
455:       waitForEnd: true
456:       onStreamFinished: root.applyGapsOutJson(text)
457:     }
458:   }
459: 
460:   // Resolve the fontconfig alias to a concrete family name. `omarchy font
461:   // set <name>` rewrites ~/.config/fontconfig/fonts.conf and restarts the
462:   // shell, but rerun on file change anyway so manual edits propagate too.
463:   function resolveFontFamily() {
464:     fcMatchProc.running = true
465:   }
466: 
467:   property Process fcMatchProc: Process {
468:     id: fcMatchProc
469:     command: ["fc-match", "-f", "%{family[0]}", "monospace"]
470:     stdout: StdioCollector {
471:       waitForEnd: true
472:       onStreamFinished: {
473:         var name = String(text || "").trim()
474:         if (name.length > 0) root.resolvedFontFamily = name
475:       }
476:     }
477:   }
478: 
479:   property FileView fontconfigFile: FileView {
480:     path: Quickshell.env("HOME") + "/.config/fontconfig/fonts.conf"
481:     watchChanges: true
482:     printErrors: false
483:     onFileChanged: root.resolveFontFamily()
484:     onLoaded: root.resolveFontFamily()
485:     onLoadFailed: root.resolveFontFamily()
486:   }
487: 
488:   // Re-poll Hyprland a beat after either input file changes. Hyprland's
489:   // auto-reload runs asynchronously when its sourced .lua files change,
490:   // so racing it with an immediate hyprctl gives the old value. 200ms is
491:   // generous enough for Hyprland to settle without being user-visible.
492:   property Timer refreshTimer: Timer {
493:     id: refreshTimer
494:     interval: 200
495:     repeat: false
496:     onTriggered: root.refresh()
497:   }
498: 
499:   // `omarchy toggle window-gaps` creates/removes this flag file. Hyprland
500:   // reloads its config when sourced files change, then hyprctl reflects
501:   // the new effective value.
502:   property FileView windowNoGapsToggle: FileView {
503:     path: Quickshell.env("HOME") + "/.local/state/omarchy/toggles/hypr/window-no-gaps.lua"
504:     watchChanges: true
505:     printErrors: false
506:     onFileChanged: refreshTimer.restart()
507:     onLoaded: refreshTimer.restart()
508:     onLoadFailed: refreshTimer.restart()
509:   }
510: 
511:   Component.onCompleted: {
512:     refresh()
513:     resolveFontFamily()
514:   }
515: }

(End of file - total 515 lines)
</content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.7s)

_Thinking:_



Theme system understood — now looking at how other widgets highlight selection.

**Tool: bash**

**Input:**
```json
{
  "command": "cat ~/.local/state/omarchy/current/theme/colors.toml 2>&1 | head -n 60; echo \"===\"; cat ~/.local/state/omarchy/current/theme/shell.toml 2>&1 | head -n 100; echo \"===\"; ls ~/.local/state/omarchy/current/theme/ 2>&1"
}
```

**Output:**
```
mode = "dark"

accent = "#7daea3"
selection = "#504945"
muted = "#665c54"

background = "#282828"
dark_background = "#1e1e1e"
darker_background = "#161616"
lighter_background = "#3c3836"

foreground = "#d4be98"
dark_foreground = "#7c6f64"
light_foreground = "#bdae93"
bright_foreground = "#d4be98"

red = "#ea6962"
yellow = "#d8a657"
orange = "#e1875c"
green = "#a9b665"
cyan = "#89b482"
blue = "#7daea3"
magenta = "#d3869b"
brown = "#70432e"

bright_red = "#ea6962"
bright_yellow = "#d8a657"
bright_green = "#a9b665"
bright_cyan = "#89b482"
bright_blue = "#7daea3"
bright_magenta = "#d3869b"
===
# Omarchy shell surfaces. Colors derive from colors.toml; sizes and the
# typographic scale come from the keys below. Themes can ship
# themes/<name>/shell.toml to replace this generated file.

[bar]
# Alpha companions (where present) range from 0 (invisible) to 1 (opaque).
background       = "#282828"
background-alpha = 1.0
text             = "#d4be98"
# Modules calling attention to themselves (recording, voxtype, alerts, updates)
active           = "#ea6962"
# Cross-axis size at font base-size 12. size-horizontal is the height of
# top/bottom bars; size-vertical is the width of left/right bars. With
# scale-with-font enabled, these grow/shrink with [font] base-size.
scale-with-font  = true
size-horizontal  = 26
size-vertical    = 28

[hyprland]
# Shared Hyprland-derived border tokens. Surface sections reference these so
# lock, notifications, popups, and menu-style cards stay aligned with the
# current Hyprland active-border gradient.
active-border            = "#7daea3"
active-border-foreground = "#d4be98"

[controls]
# Shared state tokens for interactive control chrome (buttons, dropdowns,
# tab strips, etc).

# Normal: idle control chrome. Border widths accept one CSS-style scalar/list:
# N, "Y X", "T X B", or "T R B L". Per-side keys like
# normal-border-width-left override the list. Each *-border accepts either a
# solid color or a Hyprland-style gradient, e.g. "rgba(...) rgba(...) 45deg".
normal-color        = "#d4be98"
normal-fill-alpha   = 0.04
normal-border       = "#d4be98"
normal-border-width = 1
normal-border-alpha = 0.4

# Hover-cursor: mouse hover and the panel keyboard cursor.
hover-cursor-color        = "#d4be98"
hover-cursor-fill-alpha   = 0.08
hover-cursor-border       = "#d4be98"
hover-cursor-border-width = 1
hover-cursor-border-alpha = 0.25

# Focus: Qt activeFocus. Mirror the hover-cursor values by default so
# mouse hover, keyboard cursor, and tab focus all read as the same state
# — themes that want focus to stand out override these four lines.
focus-color        = "#d4be98"
focus-fill-alpha   = 0.08
focus-border       = "#d4be98"
focus-border-width = 1
focus-border-alpha = 0.25

# Selected: persistent chosen/current state.
selected-color        = "#d4be98"
selected-fill-alpha   = 0.18
selected-border       = "#d4be98"
selected-border-width = 0
selected-border-alpha = 1.0

# Momentary fills.
pressed-fill-alpha   = 0.22
selection-fill-alpha = 0.35

[spacing]
# `scale` multiplies shared margins, gaps, padding, controls, and panel
# dimensions; components keep their proportions. With scale-with-font
# enabled, those dimensions grow/shrink with [font] base-size too. Per-token
# overrides (in px) below pin individual values without affecting the rest
# of the scale. Uncomment any to tune a specific surface.
scale = 1.0
scale-with-font = true
# xxs                       = 2
# xs                        = 3
# sm                        = 4
# md                        = 6
# lg                        = 8
# xl                        = 10
# xxl                       = 12
# xxxl                      = 14
# huge                      = 18
# control-gap               = 8
# control-padding-x         = 10
# control-padding-y         = 6
# input-padding-y           = 7
# control-height            = 28
# popup-row-height          = 28
# row-gap                   = 8
# row-padding-x             = 12
# label-gap                 = 4
# panel-gap                 = 14
# panel-padding             = 18
# popup-padding             = 14
# dropdown-width            = 240
# searchable-dropdown-width = 260
# number-field-width        = 120
# searchable-popup-min-height = 220

===
alacritty.toml
backgrounds
btop.theme
chromium.theme
claude.json
colors.toml
foot.ini
ghostty.conf
gum_env.lua
helix.toml
hermes.yaml
hyprland.lua
hyprland-preview-share-picker.css
icons.theme
keyboard.rgb
kitty.conf
neovim.lua
obsidian.css
pi.json
preview.png
preview-unlock.png
shell.toml
t3code.json
unlock.png
vscode.json
vscode-theme.json

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.5s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "grep -rn \"active\\|selected\\|foreground\\|Color\\.\" /usr/share/omarchy/shell/plugins/bar/widgets/*.qml 2>&1 | head -n 80; echo \"===\"; ls /usr/share/omarchy/shell/plugins/bar/widgets/"
}
```

**Output:**
```
/usr/share/omarchy/shell/plugins/bar/widgets/ActiveWindow.qml:9:  moduleName: "omarchy.active-window"
/usr/share/omarchy/shell/plugins/bar/widgets/ActiveWindow.qml:12:  readonly property var toplevel: ToplevelManager.activeToplevel
/usr/share/omarchy/shell/plugins/bar/widgets/ActiveWindow.qml:37:      color: root.bar ? root.bar.barForeground : Color.foreground
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:13:  property var activeIndicatorIds: []
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:18:  readonly property bool revealInactiveIndicators: alwaysShowIndicators || indicatorAreaHovered || indicatorItemHovered || (bar && bar.centerSectionRevealHeld === true && bar.centerHoverRevealSuppressed !== true)
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:22:  ListModel { id: activeIndicatorModel }
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:94:  function activeModelIndex(id) {
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:95:    for (var i = 0; i < activeIndicatorModel.count; i++) {
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:96:      if (activeIndicatorModel.get(i).activeId === id) return i
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:121:    for (var i = activeIndicatorModel.count - 1; i >= 0; i--) {
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:122:      if (activeIndicatorIds.indexOf(activeIndicatorModel.get(i).activeId) === -1)
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:123:        activeIndicatorModel.remove(i)
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:126:    for (var j = 0; j < activeIndicatorIds.length; j++) {
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:127:      var id = activeIndicatorIds[j]
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:128:      var index = activeModelIndex(id)
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:129:      if (index === -1) activeIndicatorModel.insert(j, { activeId: id })
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:130:      else if (index !== j) activeIndicatorModel.move(index, j, 1)
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:134:  function setIndicatorActive(entry, active) {
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:139:    if (active) states[id] = true
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:144:    var ids = orderedActiveIds(states, activeIndicatorIds)
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:145:    // The active block sits closest to the clock, so newcomers go on the far
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:147:    if (active && ids.indexOf(id) === -1 && hasIndicatorId(id)) ids.unshift(id)
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:148:    activeIndicatorIds = ids
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:153:    activeIndicatorIds = orderedActiveIds(indicatorActiveStates, activeIndicatorIds)
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:162:    ? Math.max(activeVerticalBlock.implicitWidth, inactiveVerticalArea.implicitWidth)
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:163:    : activeHorizontalBlock.implicitWidth + inactiveHorizontalArea.implicitWidth
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:165:    ? activeVerticalBlock.implicitHeight + inactiveVerticalArea.implicitHeight
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:166:    : Math.max(activeHorizontalBlock.implicitHeight, inactiveHorizontalArea.implicitHeight)
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:198:      id: inactiveHorizontalArea
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:200:      implicitWidth: root.revealInactiveIndicators ? inactiveHorizontalBlock.implicitWidth : 0
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:201:      implicitHeight: Math.max(inactiveHorizontalBlock.implicitHeight, root.barSize)
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:207:        id: inactiveHorizontalBlock
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:211:        indicatorBlock: "inactive"
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:222:      id: activeHorizontalBlock
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:224:      indicatorModel: activeIndicatorModel
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:241:      id: inactiveVerticalArea
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:243:      implicitWidth: Math.max(inactiveVerticalBlock.implicitWidth, root.barSize)
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:244:      implicitHeight: root.revealInactiveIndicators ? inactiveVerticalBlock.implicitHeight : 0
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:250:        id: inactiveVerticalBlock
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:254:        indicatorBlock: "inactive"
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:265:      id: activeVerticalBlock
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:267:      indicatorModel: activeIndicatorModel
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:278:    id: activeIndicatorBlockRoot
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:294:      sourceComponent: activeIndicatorBlockRoot.horizontal ? horizontalActiveIndicatorBlock : verticalActiveIndicatorBlock
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:304:          model: activeIndicatorBlockRoot.indicatorModel
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:307:            required property string activeId
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:308:            indicatorsModule: activeIndicatorBlockRoot.indicatorsModule
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:309:            entry: activeIndicatorBlockRoot.indicatorsModule.entryForId(activeId)
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:310:            indicatorBlock: "active"
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:311:            reportActiveState: activeIndicatorBlockRoot.reportActiveState
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:324:          model: activeIndicatorBlockRoot.indicatorModel
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:327:            required property string activeId
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:328:            indicatorsModule: activeIndicatorBlockRoot.indicatorsModule
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:329:            entry: activeIndicatorBlockRoot.indicatorsModule.entryForId(activeId)
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:330:            indicatorBlock: "active"
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:331:            reportActiveState: activeIndicatorBlockRoot.reportActiveState
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:343:    property string indicatorBlock: "active"
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:407:    property bool activeStateObserved: false
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:417:      activeStateObserved = false
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:456:      if ("activeOverride" in target) target.activeOverride = indicatorBlock === "active" ? true : null
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:462:      var active = !!indicatorSource.item && indicatorSource.item.active === true
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:463:      if (indicatorBlock === "active") {
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:464:        if (active) activeStateObserved = true
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:465:        else if (!activeStateObserved) return
/usr/share/omarchy/shell/plugins/bar/widgets/Indicators.qml:468:      indicatorsModule.setIndicatorActive(entry, active)
/usr/share/omarchy/shell/plugins/bar/widgets/KeyboardLayout.qml:16:  // and separately the one activelayout named as being typed on. A reading
/usr/share/omarchy/shell/plugins/bar/widgets/KeyboardLayout.qml:60:  // and by the keyboard activelayout named.
/usr/share/omarchy/shell/plugins/bar/widgets/KeyboardLayout.qml:92:      if (name === "activelayout") {
/usr/share/omarchy/shell/plugins/bar/widgets/KeyboardLayout.qml:99:      // reading, so it raises no activelayout to notice it by.
/usr/share/omarchy/shell/plugins/bar/widgets/KeyboardLayout.qml:100:      if (name.indexOf("activelayout") !== -1 || name === "configreloaded") root.refresh()
/usr/share/omarchy/shell/plugins/bar/widgets/KeyboardLayout.qml:134:        if (!kb || !kb.active_keymap) {
/usr/share/omarchy/shell/plugins/bar/widgets/KeyboardLayout.qml:152:        root.layoutFull = kb.active_keymap
/usr/share/omarchy/shell/plugins/bar/widgets/Microphone.qml:16:  readonly property var activeStreams: {
/usr/share/omarchy/shell/plugins/bar/widgets/Microphone.qml:25:  readonly property bool inUse: activeStreams.length > 0 && !muted
/usr/share/omarchy/shell/plugins/bar/widgets/Microphone.qml:42:    active: root.inUse
/usr/share/omarchy/shell/plugins/bar/widgets/Tray.qml:17:  property var activeTrayItem: null
/usr/share/omarchy/shell/plugins/bar/widgets/Tray.qml:18:  property var activeTrayAnchor: null
/usr/share/omarchy/shell/plugins/bar/widgets/Tray.qml:19:  readonly property color foreground: bar ? bar.foreground : Color.foreground
/usr/share/omarchy/shell/plugins/bar/widgets/Tray.qml:84:    // Clear the reactive stack before tearing anything down, so no binding can
/usr/share/omarchy/shell/plugins/bar/widgets/Tray.qml:125:    // activeTrayItem.menu, so assigning a new item invalidates the old root's
===
ActiveWindow.manifest.json
ActiveWindow.qml
Indicators.manifest.json
Indicators.qml
KeyboardLayout.manifest.json
KeyboardLayoutModel.js
KeyboardLayout.qml
Microphone.manifest.json
Microphone.qml
Spacer.manifest.json
Spacer.qml
SystemUpdate.manifest.json
SystemUpdate.qml
Tray.manifest.json
TrayModel.js
Tray.qml
Workspaces.manifest.json
Workspaces.qml

```

---

## Assistant (Build · Muse Spark 1.3 Free · 3.3s)

_Thinking:_



**Tool: read**

**Input:**
```json
{
  "filePath": "/usr/share/omarchy/shell/plugins/bar/widgets/Microphone.qml"
}
```

**Output:**
```
<path>/usr/share/omarchy/shell/plugins/bar/widgets/Microphone.qml</path>
<type>file</type>
<content>
1: import QtQuick
2: import Quickshell
3: import Quickshell.Services.Pipewire
4: import qs.Ui
5: 
6: BarWidget {
7:   id: root
8:   moduleName: "omarchy.microphone"
9: 
10: 
11:   readonly property var source: Pipewire.defaultAudioSource
12:   readonly property bool muted: source && source.audio ? source.audio.muted : true
13:   readonly property real volume: source && source.audio ? source.audio.volume : 0
14:   readonly property var nodes: Pipewire.nodes ? Pipewire.nodes.values : []
15: 
16:   readonly property var activeStreams: {
17:     var list = []
18:     for (var i = 0; i < nodes.length; i++) {
19:       var node = nodes[i]
20:       if (node && node.isStream && node.isSink === false && !node.audio?.muted) list.push(node)
21:     }
22:     return list
23:   }
24: 
25:   readonly property bool inUse: activeStreams.length > 0 && !muted
26: 
27:   visible: source !== null
28:   implicitWidth: button.implicitWidth
29:   implicitHeight: button.implicitHeight
30: 
31:   function toggleMute() {
32:     if (source && source.audio) source.audio.muted = !source.audio.muted
33:   }
34: 
35:   PwObjectTracker { objects: root.source ? [root.source] : [] }
36: 
37:   BarIconButton {
38:     id: button
39:     anchors.fill: parent
40:     bar: root.bar
41:     text: root.muted ? "󰍭" : "󰍬"
42:     active: root.inUse
43:     tooltipText: root.muted ? "Microphone muted" : (root.inUse ? "Microphone in use" : "Microphone live")
44:     onPressed: function(b) {
45:       if (b === Qt.MiddleButton) root.bar.run("omarchy-shell shell toggle omarchy.audio")
46:       else root.toggleMute()
47:     }
48:     onWheelMoved: function(delta) {
49:       if (!root.source || !root.source.audio) return
50:       var step = 0.05
51:       root.source.audio.volume = Math.max(0, Math.min(1, root.volume + (delta > 0 ? step : -step)))
52:     }
53:   }
54: }

(End of file - total 54 lines)
</content>
```

**Tool: bash**

**Input:**
```json
{
  "command": "grep -rn \"WidgetButton\" /usr/share/omarchy/shell/plugins/bar/widgets/*.qml 2>&1 | head -n 20; echo \"===\"; find /usr/share/omarchy/shell -name \"BarWidget.qml\" 2>&1"
}
```

**Output:**
```
/usr/share/omarchy/shell/plugins/bar/widgets/KeyboardLayout.qml:208:  WidgetButton {
/usr/share/omarchy/shell/plugins/bar/widgets/Workspaces.qml:54:      WidgetButton {
===
/usr/share/omarchy/shell/Ui/BarWidget.qml
/usr/share/omarchy/shell/plugins/menu/BarWidget.qml
/usr/share/omarchy/shell/plugins/panels/clock/BarWidget.qml
/usr/share/omarchy/shell/plugins/panels/weather/BarWidget.qml
/usr/share/omarchy/shell/plugins/services/media/BarWidget.qml

```

---

## Assistant (Build · Muse Spark 1.3 Free · 1.9s)

**Tool: read**

**Input:**
```json
{
  "filePath": "/usr/share/omarchy/shell/Ui/BarWidget.qml"
}
```

**Output:**
```
<path>/usr/share/omarchy/shell/Ui/BarWidget.qml</path>
<type>file</type>
<content>
1: import QtQuick
2: import qs.Commons
3: 
4: // Base item every bar widget extends. Codifies the three properties the
5: // bar host injects into each widget slot:
6: //   bar         - the host Bar instance (foreground/background/run/etc).
7: //   moduleName  - widget's canonical id, used by the host registry to look
8: //                 up settings and to disambiguate inline IPC routes.
9: //   settings    - per-widget overrides read from shell.json's layout entry.
10: //
11: // Widgets are free to add their own properties, signals, and child items.
12: Item {
13:   id: root
14: 
15:   property QtObject bar: null
16:   property string moduleName: ""
17:   property var settings: ({})
18: 
19:   // Bar geometry, lifted off the host. Widgets read these constantly to pick
20:   // between horizontal/vertical layouts; defining them on the base keeps the
21:   // `bar ? bar.x : fallback` ternary out of every widget body.
22:   readonly property bool vertical: bar ? bar.vertical : false
23:   readonly property int barSize: bar ? bar.barSize : Style.bar.sizeHorizontal
24: 
25:   // Run `method` on every live instance of this widget. An IPC target only
26:   // ever routes to one handler, but a bar surface exists per monitor, so the
27:   // instance that owns the target relays the call to its peers — otherwise a
28:   // refresh would land on a single screen and leave the others stale.
29:   function broadcast(method) {
30:     var items = bar && typeof bar.moduleWidgets === "function"
31:       ? bar.moduleWidgets(moduleName) : [root]
32:     for (var i = 0; i < items.length; i++) {
33:       if (items[i] && typeof items[i][method] === "function") items[i][method]()
34:     }
35:   }
36: 
37:   // Read a single value from this widget's inline shell.json entry, with a
38:   // fallback for missing/null values. Every widget that takes user-tunable
39:   // settings needs this; defining it once on the base keeps the wiring
40:   // consistent.
41:   function setting(name, fallback) {
42:     var value = settings ? settings[name] : undefined
43:     return value === undefined || value === null ? fallback : value
44:   }
45: }

(End of file - total 45 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/usr/share/omarchy/shell/Ui/BarIconButton.qml"
}
```

**Output:**
```
<path>/usr/share/omarchy/shell/Ui/BarIconButton.qml</path>
<type>file</type>
<content>
1: import QtQuick
2: import Quickshell
3: import qs.Commons
4: 
5: WidgetButton {
6:   id: root
7: 
8:   property Component iconComponent: null
9:   property real slotSize: Style.bar.iconSlot
10:   property real opticalSize: Style.bar.iconCanvas
11:   property bool debugOpticalBounds: Quickshell.env("OMARCHY_DEBUG_BAR_ICONS") === "1"
12:   readonly property real opticalCenterErrorX: glyph.visible ? glyph.paintedCenterX - opticalCanvas.width / 2 : 0
13:   readonly property real glyphPaintedWidth: glyph.visible ? glyph.tightWidth : 0
14:   readonly property real glyphBaselineY: glyph.visible ? glyph.baselineY : 0
15:   readonly property int glyphFontSize: glyph.visible ? glyph.renderedFontSize : 0
16: 
17:   labelVisible: false
18:   hasVisualContent: text !== "" || iconComponent !== null
19:   fontSize: Style.bar.iconFont
20:   fixedWidth: vertical ? -1 : slotSize
21:   fixedHeight: vertical ? slotSize : -1
22: 
23:   Item {
24:     id: opticalCanvas
25:     anchors.centerIn: parent
26:     width: root.opticalSize
27:     height: root.opticalSize
28: 
29:     OpticalGlyph {
30:       id: glyph
31:       anchors.fill: parent
32:       visible: root.iconComponent === null
33:       text: root.text
34:       fontFamily: root.fontFamily
35:       fontSize: root.fontSize
36:       color: root.active && root.useActiveColor ? root.activeColor : root.foreground
37:       rotation: root.textRotation
38:       debugBounds: root.debugOpticalBounds
39:     }
40: 
41:     Loader {
42:       anchors.fill: parent
43:       visible: root.iconComponent !== null
44:       sourceComponent: root.iconComponent
45:     }
46: 
47:     Rectangle {
48:       visible: root.debugOpticalBounds && root.iconComponent !== null
49:       anchors.fill: parent
50:       color: "transparent"
51:       border.width: 1
52:       border.color: "#4488ff"
53:     }
54:   }
55: 
56:   Rectangle {
57:     visible: root.debugOpticalBounds
58:     anchors.fill: parent
59:     color: "transparent"
60:     border.width: 1
61:     border.color: "#ff4455"
62:   }
63: }

(End of file - total 63 lines)
</content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 9.1s)

_Thinking:_



**Tool: bash**

**Input:**
```json
{
  "command": "grep -n \"urgent\\|barForeground\\|barBackground\\|foreground\" /usr/share/omarchy/shell/plugins/bar/Bar.qml 2>&1 | head -n 30"
}
```

**Output:**
```
77:  property color foreground: themeForeground
78:  property color barForeground: useTransparentForeground ? transparentForeground : themeForeground
79:  property bool foregroundAnimationEnabled: true
81:  property color urgent: Color.bar.active
83:  Behavior on barForeground { enabled: root.foregroundAnimationEnabled; ColorAnimation { duration: 420; easing.type: Easing.InOutCubic } }
85:  Behavior on urgent { ColorAnimation { duration: 420; easing.type: Easing.InOutCubic } }
126:    api.foreground = Qt.binding(function() { return root.foreground })
127:    api.barForeground = Qt.binding(function() { return root.barForeground })
129:    api.urgent = Qt.binding(function() { return root.urgent })
135:    api.foregroundAnimationEnabled = Qt.binding(function() { return root.foregroundAnimationEnabled })
1036:      foregroundAnimationEnabled = false
1048:      Qt.callLater(function() { root.foregroundAnimationEnabled = true })
1092:        root.foregroundAnimationEnabled = false
1437:        borderSpec: Border.flat(root.barForeground, 1)
1507:        borderSpec: Border.flat(root.barForeground, 1)
1833:      borderSpec: Border.flat(root.barForeground, 1)

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.3s)

_Thinking:_



The theme-aware way is to use the built-in highlight color — applying it to the active workspace now.

**Tool: bash**

**Input:**
```json
{
  "command": "cp ~/.config/omarchy/plugins/mb.workspaces/Workspaces.qml ~/.config/omarchy/plugins/mb.workspaces/Workspaces.qml.bak.$(date +%s) && echo \"backup done\""
}
```

**Output:**
```
backup done

```

---

## Assistant (Build · Muse Spark 1.3 Free · 4.8s)

**Tool: edit**

**Input:**
```json
{
  "filePath": "/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml",
  "newString": "        bar: root.bar\n        readonly property string customLabel: root.workspaceLabel(modelData)\n        text: customLabel !== \"\" && customLabel !== null ? customLabel : (focused ? \"󰻿\" : String(modelData))\n        // Theme-aware highlight: focused workspace uses bar.active\n        // (Color.bar.active → theme's bar.active, e.g. Gruvbox red #ea6962).\n        // Follows theme switches automatically with smooth animation.\n        active: focused\n        opacity: occupied || focused ? 1 : 0.5",
  "oldString": "        bar: root.bar\n        readonly property string customLabel: root.workspaceLabel(modelData)\n        text: customLabel !== \"\" && customLabel !== null ? customLabel : (focused ? \"󰻿\" : String(modelData))\n        opacity: occupied || focused ? 1 : 0.5"
}
```

**Output:**
```
Edit applied successfully.
```

---

## Assistant (Build · Muse Spark 1.3 Free · 3.3s)

**Tool: bash**

**Input:**
```json
{
  "command": "omarchy plugin validate ~/.config/omarchy/plugins/mb.workspaces 2>&1; echo \"validate done\"; omarchy-shell shell rescanPlugins 2>&1; sleep 1; echo \"rescan done\""
}
```

**Output:**
```
validate done
rescan done

```

---

## Assistant (Build · Muse Spark 1.3 Free · 2.2s)

_Thinking:_



**Tool: read**

**Input:**
```json
{
  "filePath": "/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml",
  "offset": 60
}
```

**Output:**
```
<path>/home/mb/.config/omarchy/plugins/mb.workspaces/Workspaces.qml</path>
<type>file</type>
<content>
60:       model: root.workspaceIds()
61: 
62:       WidgetButton {
63:         required property int modelData
64: 
65:         readonly property var workspace: root.workspaceById(modelData)
66:         readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
67:         readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData
68: 
69:         bar: root.bar
70:         readonly property string customLabel: root.workspaceLabel(modelData)
71:         text: customLabel !== "" && customLabel !== null ? customLabel : (focused ? "󰻿" : String(modelData))
72:         // Theme-aware highlight: focused workspace uses bar.active
73:         // (Color.bar.active → theme's bar.active, e.g. Gruvbox red #ea6962).
74:         // Follows theme switches automatically with smooth animation.
75:         active: focused
76:         opacity: occupied || focused ? 1 : 0.5
77:         horizontalMargin: 6
78:         verticalPadding: 6
79:         fixedWidth: customLabel !== "" && customLabel !== null ? (root.vertical ? root.barSize : -1) : (root.vertical ? root.barSize : Style.space(20))
80:         fixedHeight: root.barSize
81:         onPressed: function() { root.focusWorkspace(modelData) }
82:       }
83:     }
84:   }
85: }

(End of file - total 85 lines)
</content>
```

---

## Assistant (Build · Muse Spark 1.3 Free · 5.5s)

_Thinking:_



Done — the focused workspace is now highlighted with your theme's accent color.

**What I changed** (`~/.config/omarchy/plugins/mb.workspaces/Workspaces.qml`, backed up first):
```qml
active: focused
```
That's it — one line. `WidgetButton` already supports it:
- unfocused → `foreground` (`bar.barForeground` → `Color.foreground`)
- focused (`active:true`) → `activeColor` (`bar.urgent` → `Color.bar.active`)

**Why this is theme-aware (no hardcoded colors):**
- Current theme **Gruvbox**: unfocused `#d4be98` (beige) → focused `#ea6962` (red, `bar.active` in `shell.toml`)
- Switch themes via `omarchy theme set <name>` and the highlight follows automatically — `Bar.qml` even animates the color change (`ColorAnimation 420ms`), and `WidgetButton` animates text color (`160ms`).
- Same pattern the stock `Microphone` widget uses (`active: inUse` → red when live).

**Current behavior:**
- `1_code` focused → red `1_code`, unfocused → beige `1_code` at full/dimmed opacity as before
- Unnamed workspaces (4, 5…) → red dot icon when focused, dimmed number otherwise
- Validated (`omarchy plugin validate` clean) + `rescanPlugins` applied — no restart needed

If red text isn't prominent enough for you, I can add a background pill behind the focused label using `Style.selectedFill` (theme's `selected-fill-alpha 0.18`) — just say the word.

---

