{
  lib,
  config,
  pkgs,
  ...
}: let
  apps = import ./applications.nix {inherit pkgs;};
in {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    pactl = "${pkgs.pulseaudio}/bin/pactl";

    volume-up = spawn pactl ["set-sink-volume" "@DEFAULT_SINK@" "+5%"];
    volume-down = spawn pactl ["set-sink-volume" "@DEFAULT_SINK@" "-5%"];
  in {
    "xf86audioraisevolume".action = volume-up;
    "xf86audiolowervolume".action = volume-down;

    "control+super+xf86audioraisevolume".action = spawn "brightness" "up";
    "control+super+xf86audiolowervolume".action = spawn "brightness" "down";

    "super+q".action = close-window;
    "super+b".action = spawn apps.browser;
    "super+Return".action = spawn apps.terminal;
    "super+Control+Return".action = spawn apps.editor;
    "super+E".action = spawn apps.fileManager;
    "super+space".action = spawn "walker";

    "super+a".action = toggle-overview;
    "super+f".action = fullscreen-window;
    "super+t".action = toggle-window-floating;

    #"control+shift+1".action = screenshot;
    #"control+shift+2".action = screenshot-window { write-to-disk = true; };

    "super+Left".action = focus-column-left;
    "super+Right".action = focus-column-right;
    "super+Down".action = focus-workspace-down;
    "super+Up".action = focus-workspace-up;

    "super+Shift+Left".action = move-column-left;
    "super+Shift+Right".action = move-column-right;
    "super+Shift+Down".action = move-column-to-workspace-down;
    "super+Shift+Up".action = move-column-to-workspace-up;

    "super+1".action = focus-workspace "cli";
    "super+2".action = focus-workspace "browser";
    "super+3".action = focus-workspace "discord";

    "Mod+WheelScrollDown".action = focus-workspace-down;
    "Mod+WheelScrollUp".action = focus-workspace-up;
  };
}
