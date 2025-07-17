{ config, pkgs, ... }:

{
  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      workspaces = {
        "CLI" = {};
        "browser" = {};
        "discord" = {};
      };

      prefer-no-csd = true;

      hotkey-overlay = {
        skip-at-startup = true;
      };


    overview  = {
        zoom = 0.65;
        workspace-shadow = {
          off = true;
        };
     };

      layout = {

        focus-ring = {
          enable = true;
          width = 3;
          active = {
            color = "#c488ec";
          };
          inactive = {
            color = "#505050";
          };
        };

        gaps = 15;

        struts = {
          left = 40;
          right = 20;
          top = 20;
          bottom = 40;
        };
      };

      input = {
        keyboard.xkb.layout = "us";
        touchpad = {
          click-method = "button-areas";
          dwt = true;
          dwtp = true;
          natural-scroll = true;
          scroll-method = "two-finger";
          tap = true;
          tap-button-map = "left-right-middle";
          middle-emulation = true;
          accel-profile = "adaptive";
        };
        focus-follows-mouse.enable = false;
        warp-mouse-to-focus.enable = false;
      };

      outputs = {
        "Virtual-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.0;
          };
          scale = 1.0;
          position = { x = 0; y = 0; };
        };
      };

      cursor = {
        size = 22;
        theme = "Adwaita";
      };

      environment = {
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        ELECTRON_ENABLE_HARDWARE_ACCELERATION = "1";

        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
        DISPLAY = ":0";
      };
    };
  };
}
