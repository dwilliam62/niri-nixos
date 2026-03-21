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
  settingsFormat = pkgs.lib.generators.toJSON {} {
    layer = "top";
    position = "top";
    height = 30;

    modules-left = ["custom/menu" "tray"];
    modules-center = ["clock"];
    modules-right = ["idle_inhibitor" "cpu" "memory" "pulseaudio" "battery" "custom/power"];

    "clock" = {
      format = " {:%H:%M}";
      tooltip-format = "<big>{:%A, %d.%B %Y }</big><tt><small>{calendar}</small></tt>";
    };
    "custom/power" = {
      format = "⏻";
      tooltip = false;
      on-click = "powermenu";
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
      on-click = "rofi-legacy.menu";
    };
    "cpu" = {
      format = " {load}%";
      tooltip = true;
    };
    "memory" = {
      format = " {}%";
      tooltip = true;
      tooltip-format = "Memory: {used:0.1f}GB/{total:0.1f}GB";
    };
    "idle_inhibitor" = {
      format = "{icon}";
      format-icons = {
        activated = "";
        deactivated = "";
      };
    };
  };

  # Waybar stylesheet
  stylesheet = ''
    * {
      font-size: 18px;
      font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
      font-weight: bold;
    }

    window#waybar {
      background-color: rgba(19, 23, 33, 0.8);
      color: #${base0F};
    }

    tooltip {
      background: #${base00};
      border: 1px solid #${base0E};
      border-radius: 10px;
    }

    tooltip label {
      color: #${base07};
    }

    #clock,
    #tray,
    #pulseaudio,
    #battery,
    #custom-menu,
    #custom-power,
    #cpu,
    #memory,
    #idle_inhibitor {
      background: transparent;
      padding: 0 15px;
      margin: 0 2px;
    }

    #clock { color: #${base0B}; }
    #pulseaudio { color: #${base0D}; }
    #battery { color: #${base08}; }
    #custom-menu { color: #${base0E}; }
    #custom-power { color: #${base0E}; }
    #cpu { color: #${base0A}; }
    #memory { color: #${base0C}; }
    #idle_inhibitor { color: #${base05}; }
  '';
in
{
  # Use home.file to create the configuration files directly in the desired location
  home.file.".config/niri/waybar/config".text = settingsFormat;
  home.file.".config/niri/waybar/style.css".text = stylesheet;

  # Add waybar to home packages so it's available to be run
  home.packages = [ pkgs.waybar ];
}