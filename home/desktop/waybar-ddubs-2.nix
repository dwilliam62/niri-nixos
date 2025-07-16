{
  pkgs,
  config,
  lib,
  ...
}: let
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
in
  with lib; {
    # Configure & Theme Waybar

    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = [
        {
          layer = "top";
          position = "top";

          modules-left = ["custom/startmenu" "sway/workspaces" "sway/window" "tray"];
          modules-center = ["clock"];
          modules-right = ["idle_inhibitor" "pulseaudio" "battery" "custom/exit"];

          "sway/workspaces" = {
            format = "{name}";
            format-icons = {
              default = " ";
              active = " ";
              urgent = " ";
            };
          };
          "clock" = {
            format = '' {:%H:%M}'';
            /*
            ''{: %I:%M %p}'';
            */
            tooltip = true;
            tooltip-format = "<big>{:%A, %d.%B %Y }</big><tt><small>{calendar}</small></tt>";
          };
          "sway/window" = {
            max-length = 60;
            separate-outputs = false;
          };
          "memory" = {
            interval = 5;
            format = " {}%";
            tooltip = true;
            on-click = "${terminal} -e btop";
          };
          "cpu" = {
            interval = 5;
            format = " {usage:2}%";
            tooltip = true;
            on-click = "${terminal} -e btop";
          };
          "disk" = {
            format = " {free}";
            tooltip = true;
            # Not working with zaneyos window open then closes
            #on-click = "${terminal} -e sh -c df -h ; read";
          };
          "network" = {
            format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
            format-ethernet = " {bandwidthDownBits}";
            format-wifi = " {bandwidthDownBits}";
            format-disconnected = "󰤮";
            tooltip = false;
            on-click = "${terminal} -e btop";
          };
          "tray" = {
            spacing = 12;
          };
          "pulseaudio" = {
            format = "{icon} {volume}% {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = " {volume}%";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" ""];
            };
            on-click = "pavucontrol";
          };
          "custom/exit" = {
            tooltip = false;
            format = "⏻";
            on-click = "sleep 0.1 && wlogout";
          };
          "custom/startmenu" = {
            tooltip = false;
            format = " ";
            # exec = "rofi -show drun";
            on-click = "walker";
          };
          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = " ";
              deactivated = " ";
            };
            tooltip = "true";
          };
          "custom/notification" = {
            tooltip = false;
            format = "{icon} {}";
            format-icons = {
              notification = "<span foreground='red'><sup></sup></span>";
              none = "";
              dnd-notification = "<span foreground='red'><sup></sup></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='red'><sup></sup></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = "";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t";
            escape = true;
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
            on-click = "";
            tooltip = false;
          };
        }
      ];
      style = concatStrings [
        ''
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

          #workspaces {
            background: transparent;
            margin: 0 5px;
            padding: 0 5px;
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

          tooltip {
            background: #${base00};
            border: 1px solid #${base0E};
            border-radius: 10px;
          }

          tooltip label {
            color: #${base07};
          }

          /* Reset individual module styles */
          #window,
          #memory,
          #clock,
          #idle_inhibitor,
          #cpu,
          #disk,
          #battery,
          #network,
          #tray,
          #pulseaudio,
          #custom-notification,
          #custom-startmenu,
          #custom-exit {
            color: #${base0F};
            background: transparent;
            border-radius: 0px;
            margin: 0;
            padding: 0 15px;
          }

          #clock {
            color: #${base0B};
          }
          #pulseaudio {
            color: #${base0D};
          }
          #custom-notification {
            color: #${base0C};
          }
          #custom-startmenu {
            color: #${base0E};
          }
          #custom-exit {
            color: #${base0E};
          }
          #battery {
            color: #${base08};
          }
          #network {
            color: #${base09};
          }
          #idle_inhibitor {
            color: #${base0A};
          }
        ''
      ];
    };
  }
