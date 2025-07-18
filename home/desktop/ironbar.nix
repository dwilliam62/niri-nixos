{ config, pkgs, lib, ... }:

let
  # Configuration options
  barHeight = 36;
  barPosition = "top";
  fontName = "JetBrains Mono";

  # Module definitions
  workspacesModule = {
    type = "workspaces";
    all_monitors = false;
    tooltip = "Workspaces";
    hidden = [ "special:special" ];
    highlight_active = true;
  };

  clockModule = {
    type = "label";
    class = "clock";
    label = "{{10000:date '+%H:%M'}}";
  };

  musicModule = {
    type = "music";
    player = "*";
    interval = 2;
    truncate = {
      mode = "end";
      length = 28;
      max_length = 32;
    };
    tooltip = true;
    format = "{artist} - {title}";
  };

  volumeModule = {
    type = "custom";
    class = "custom-volume";
    on_click_left = "pavucontrol";
    on_click_right = "pavucontrol";
    tooltip = "Volume controls\n- Left click: Open settings\n- Scroll: Adjust volume";
    on_scroll_up = "pamixer -i 5";
    on_scroll_down = "pamixer -d 5";
    bar = [
      {
        type = "volume";
        class = "volume-icon";
        format = "{icon}";
      }
      {
        type = "volume";
        class = "volume-percent";
        format = "{percentage}%";
      }
    ];
  };

  systrayModule = {
    type = "tray";
    class = "systray";
    icon_size = 18;
    spacing = 4;
  };

  powerModule = {
    type = "custom";
    class = "power";
    on_click_left = "swaync-client -t";
    on_click_right = "popup:toggle";
    tooltip = "Left click: Notifications\nRight click: Power menu";
    bar = [
      {
        type = "label";
        class = "power-icon";
        label = "";
      }
    ];
    popup = [
      {
        orientation = "vertical";
        type = "box";
        class = "power-popup";
        name = "power-popup";
        widgets = [
          {
            label = "<span font-weight='bold'>Power Menu</span>";
            name = "header";
            type = "label";
          }
          {
            type = "box";
            class = "power-button-box";
            widgets = [
              {
                class = "power-button";
                label = "";
                on_click = "!shutdown now";
                type = "button";
              }
              {
                class = "power-button";
                label = "";
                on_click = "!reboot";
                type = "button";
              }
              {
                class = "power-button";
                label = "";
                on_click = "!hyprlock";
                type = "button";
              }
            ];
          }
        ];
      }
    ];
  };

  ironbarConfig = pkgs.writeText "ironbar-config.json" (builtins.toJSON {
    position = barPosition;
    anchor_to_edges = true;
    height = barHeight;
    start = [ workspacesModule ];
    center = [ musicModule ];
    end = [ volumeModule systrayModule powerModule clockModule ];
  });

  ironbarStyle = pkgs.writeText "ironbar-style.css" ''
  .background {
    background: none;
  }

  #bar {
    all: unset;
    font-family: "JetBrains Mono", "Font Awesome 6 Free";
    font-weight: bold;
    background-color: #0f1419;
    color: #c5cdd3;
    padding-right: 5px;
    padding-left: 10px;
  }

  .popup {
    font-family: "JetBrains Mono";
    background-color: #0f1419;
    color: #c5cdd3;
    padding: 15px;
    border: 1px solid #1e2429;
    border-radius: 10px;
  }

  tooltip.background,
  menu {
    background-color: #0f1419;
    color: #c5cdd3;
    border: 1px solid #1e2429;
    border-radius: 10px;
  }

  tooltip label {
    color: #c5cdd3;
  }

  .workspaces {
    font-weight: bold;
    margin: 0;
    padding-left: 0;
  }

  .clock,
  .music,
  .workspaces .item,
  .tray,
  .script,
  .battery-icon,
  .power-icon,
  .volume-icon,
  .brightness-icon,
  .brightness-percent,
  .battery-percent,
  .volume-percent,
  .network_manager,
  .systray-revealer-icon {
    margin: 0;
    background: none;
    padding-left: 10px;
    padding-right: 10px;
    color: #c5cdd3;
  }

  .music {
    font-style: italic;
    color: #91b4d5;
  }

  .power-icon {
    color: #c5cdd3;
  }

  .battery,
  .custom-volume,
  .brightness {
    margin: 0;
    padding: 0;
  }

  .battery-icon,
  .brightness-icon,
  .systray-revealer-icon {
    font-size: 16px;
  }

  .volume-icon {
    font-size: 21px;
  }

  .battery-percent,
  .volume-percent,
  .brightness-percent,
  .tray {
    margin: 0;
    padding-right: 10px;
    padding-left: 0px;
  }

  .workspaces .item {
    color: #5c6773;
    padding-left: 3px;
    padding-right: 10px;
  }

  .workspaces .item.focused {
    color: #36a3d9;
  }

  .power-button {
    font-size: 42pt;
    padding-right: 35px;
    padding-left: 20px;
    margin: 5px;
  }

  .power-button-box {
    margin-top: 10px;
    margin-bottom: 10px;
  }

  .popup-music .album-art {
    margin-right: 1em;
  }

  .popup-music .icon-box {
    margin-right: 0.4em;
  }

  .popup-music .title .icon, .popup-music .title .label {
    font-size: 1.7em;
  }

  .popup-music .volume .slider slider {
    border-radius: 0px
  }

  .popup-music .volume .icon {
    margin-left: 4px;
  }

  .popup-music .progress .slider slider {
    border-radius: 0px
  }

  scale trough, scale slider {
    min-width: 5px;
    min-height: 5px;
  }

  .popup-volume .device-box .btn-mute,
  .popup-volume .apps-box .app-box .btn-mute {
    font-size: 24px;
  }
  '';

in {
  xdg.configFile = {
    "ironbar/config.json".source = ironbarConfig;
    "ironbar/style.css".source = ironbarStyle;
  };
}
