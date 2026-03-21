<H3> Niri Changelog </H3>

### My testing config before moving to ddubsOS

### 3-21-26

### Summary:

- Updated deprecated Nix references (nixvim homeModules, thunar package path, nixfmt package name).
- Adjusted nvf language options for the renamed crates setting and list-based format types.
- Switched package lookups to use pkgs.stdenv.hostPlatform.system where applicable.
- Removed obsolete apps, neovim, clapgrep, etc
- Fixed `thunar` plugins eval warnings
- Set `walker` backend to `cairo` trying to resolve menu exiting
- Set `SUPER + R` Legacy rofi menu as backup for walker
- Set Hyprland to 0.54.2 Current main branch refactor isn't working VMs

### 7-15-25

- Initial setup
- Added:
  - Binding for scroll levels
  - Set offset (`struts`) Quick shell widgets in way
  - Overview binding `Super+A`
  - Plugins for vscode
  - Increased gaps
