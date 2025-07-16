{ lib, pkgs, ... }:

{
  programs.niri.settings.spawn-at-startup = [
    { command = ["systemctl" "--user" "start" "hyprpolkitagent"]; }
    { command = ["arrpc"]; }
    { command = ["xwayland-satellite"]; }
    # { command = ["qs"]; }
    { command = ["waybar" "-c" "/home/dwilliams/.config/waybar-niri/config" "-s" "/home/dwilliams/.config/waybar-niri/style.css"]; }
    { command = ["waypaper" "--restore" ]; }
    { command = ["discordcanary"]; }
    { command = ["${pkgs.swaybg}/bin/swaybg" "-o" "Virtual-1" "-i" "~/Pictures/wallpapers/Anime-Purple-eyes.png" "-m" "fill"]; }
    #{ command = ["sh" "-c" "swww-daemon & swww img /home/lysec/nixos/wallpapers/cloud.png"]; }
  ];
}
