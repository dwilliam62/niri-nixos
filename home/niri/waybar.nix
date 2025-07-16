{
  pkgs,
  lib,
  ...
}:
let
  terminal = "kitty";
  base00 = "0F1419";
  base01 = "131721";
  base03 = "3E4B59";
  base05 = "E6E1CF";
  base06 = "E6E1CF";
  base07 = "F3F4F5";
  base08 = "F07178";
  base09 = "FF8F40";
  base0A = "FFB454";
  base0B = "B8CC52";
  base0C = "95E6CB";
  base0D = "59C2FF";
  base0E = "D2A6FF";
  base0F = "E6B673";

  # Waybar settings in JSON format
  settingsFormat = pkgs.lib.generators.toJSON {} [{
    layer = "top";
    position = "top";

    modules-left = ["sway/workspaces" "sway/window"];
    modules-center = ["clock"];
    modules-right = ["tray" "pulseaudio" "battery" "custom/menu"];

    "sway/workspaces" = {
      format = "{name}";
    };
    "sway/window" = {
      max-length = 60;
      separate-outputs = false;
    };
    "clock" = {
      format = " {:%H:%M}";
      tooltip-format = "<big>{:%A, %d.%B %Y }</big><tt><small>{calendar}</small></tt>";
    };
    "tray" = {
      spacing = 12;
    };
    "pulseaudio" = {
      format = "{icon} {volume}%";
      format-muted = "";
      format-icons = {
        default = ["" "" ""];
      };
      on-click = "pavucontrol";
    };
    "battery" = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      format-charging = "󰂄 {capacity}%";
      format-plugged = "󱘖 {capacity}%";
      format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
    };
    "custom/menu" = {
      format = "";
      on-click = "walker";
    };
  }];

  # Waybar stylesheet
  stylesheet = ''
    * {
      font-size: 18px;
      font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
      font-weight: bold;
    }

    window#waybar {
      background-color: rgba(19, 23, 33, 0.8);
      border-radius: 15px;
      color: #${base0F};
      margin: 20px 10% 0 10%;
    }

    tooltip {
      background: #${base00};
      border: 1px solid #${base0E};
      border-radius: 10px;
    }

    tooltip label {
      color: #${base07};
    }

    #workspaces button {
      padding: 0px 5px;
      margin: 4px 3px;
      border-radius: 10px;
      color: #${base00};
      background: linear-gradient(45deg, #${base0D}, #${base0E});
      opacity: 0.5;
      transition: all 0.3s ease-in-out;
    }

    #workspaces button.active {
      opacity: 1.0;
      min-width: 40px;
    }

    #workspaces button:hover {
      opacity: 0.8;
    }

    #window,
    #clock,
    #tray,
    #pulseaudio,
    #battery,
    #custom-menu {
      background: transparent;
      padding: 0 15px;
      margin: 0 2px;
    }

    #clock { color: #${base0B}; }
    #pulseaudio { color: #${base0D}; }
    #battery { color: #${base08}; }
    #custom-menu { color: #${base0E}; }
  '';
in
{
  # Use home.file to create the configuration files directly
  home.file.".config/waybar-niri/config".text = settingsFormat;
  home.file.".config/waybar-niri/style.css".text = stylesheet;

  # Add waybar to home packages
  home.packages = [ pkgs.waybar ];
}