{ lib, pkgs, ... }:

{
  programs.niri.settings.spawn-at-startup = [
    { command = ["systemctl" "--user" "start" "hyprpolkitagent"]; }
    { command = ["arrpc"]; }
    { command = ["xwayland-satellite"]; }
    { command = ["qs"]; }
    { command = ["discordcanary"]; }
    { command = ["${pkgs.swaybg}/bin/swaybg" "-o" "Virtual-1" "-i" "/home/lysec/nixos/assets/wallpapers/clouds.png" "-m" "fill"]; }
    #{ command = ["sh" "-c" "swww-daemon & swww img /home/lysec/nixos/wallpapers/cloud.png"]; }
  ];
}
