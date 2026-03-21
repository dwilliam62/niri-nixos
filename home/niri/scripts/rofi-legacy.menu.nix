{pkgs}:
pkgs.writeShellScriptBin "rofi-legacy.menu" ''
  rofi -config ~/.config/rofi/legacy.config.rasi -show drun
''
