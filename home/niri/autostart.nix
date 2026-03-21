{
  lib,
  pkgs,
  ...
}: {
  programs.niri.settings.spawn-at-startup = [
    {command = ["hyprpolkitagent"];}
    #{ command = ["arrpc"]; }
    {command = ["xwayland-satellite"];}
    #{command = ["qs"];}
    {command = ["waybar" "-c" "/home/dwilliams/.config/niri/waybar/config" "-s" "/home/dwilliams/.config/niri/waybar/style.css"];}
    #{command = ["waypaper" "--restore"];}
    #{ command = ["discordcanary"]; }
    #{ command = ["${pkgs.swaybg}/bin/swaybg" "-o" "Virtual-1" "-i" "~/Pictures/wallpapers/Anime-Purple-eyes.png" "-m" "fill"]; }
    #{command = ["sh" "-c" "swww-daemon & "];}
    {command = ["sh" "-c" "swww-daemon & swww img /home/dwilliams/Pictures/wallpapers/Purple-Nightmare.jpg"];}
  ];
}
