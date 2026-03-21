<H3> Niri Changelog </H3>

### My testing config before moving to ddubsOS

### 3-21-26

### Summary:

- Updated deprecated Nix references (nixvim homeModules, thunar package path, nixfmt package name).
- Adjusted nvf language options for the renamed crates setting and list-based format types.
- Switched package lookups to use pkgs.stdenv.hostPlatform.system where applicable.
- Removed obsolete apps, neovim, clapgrep, etc

### 7-15-25

- Initial setup
- Added:
  - Binding for scroll levels
  - Set offset (`struts`) Quick shell widgets in way
  - Overview binding `Super+A`
  - Plugins for vscode
  - Increased gaps
