{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    inputs.hyprpolkitagent.packages."${pkgs.system}".hyprpolkitagent
  ];

  stylix.targets.hyprland.enable = false;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      # Default Apps
      "$mainMod" = "SUPER";
      "$terminal" = "ghostty";
      "$browser" = "google-chrome-stable";
      "$menu" = "walker";
      "$fileManager" = "thunar";

      # Keybinds Start
      bind = [
        "CTRL SHIFT, 1, exec, grimblast --freeze copy area"
        "CTRL SHIFT, 2, exec, grimblast --freeze copy window"
        "CTRL SHIFT, 3, exec, grimblast --freeze copy output"

        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, B, exec, $browser"
        "$mainMod, D, exec, $menu"
        "$mainMod CTRL, RETURN, exec, $menu"
        "$mainMod CTRL, W, exec, waypaper"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, T, togglefloating"
        "$mainMod, F, fullscreen"
        "$mainMod, J, togglesplit"
        "$mainMod, Q, killactive"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ", xf86audioraisevolume, exec, pactl set-sink-volume '@DEFAULT_SINK@' +5% && pactl get-sink-volume '@DEFAULT_SINK@' | grep -oP '\\d+(?=%)' | awk '{if($1>100) system(\"pactl set-sink-volume '@DEFAULT_SINK@' 100%\")}'"
        ", xf86audiolowervolume, exec, pactl set-sink-volume '@DEFAULT_SINK@' -5%"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = -0.2;
      };

      binds = {
        "workspace_back_and_forth" = "true";
        "allow_workspace_cycles" = "true";
        "pass_mouse_when_bound" = "false";
      };
      # Keybinds End

      general = {
        gaps_in = 5;
        gaps_out = 14;
        border_size = 3;
        "col.active_border" = "rgb(c488ec)";
        "col.inactive_border" = "rgb(6e6a86)";
      };

      decoration = {
        active_opacity = 1.0;
        inactive_opacity = 0.95;
        rounding = 20;

        blur = {
          enabled = true;
          size = 6;
          passes = 2;
          new_optimizations = "on";
          ignore_opacity = true;
          xray = true;
        };
      };

      animations = {
        enabled = true;

        bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      # Startup starts
      exec-once = [
        "hyprctl setcursor Adwaita 24"
        "systemctl --user start hyprpolkitagent"
        #"[workspace 2] vesktop"
        #"arrpc"
        #"waypaper --restore"
        "swaync"
        "ironbar"
        #"qs" # Run quickshell
        #"waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css"
      ];
      # Startup ends

      # Env starts
      env = [
        "XDG_SESSION_TYPE                    ,  wayland  "
        "XDG_CURRENT_DESKTOP                 ,  Hyprland "
        "XDG_SESSION_DESKTOP                 ,  Hyprland "

        "DISABLE_QT5_COMPAT                  , 1         "
        "QT_QPA_PLATFORM                     ,  wayland  "
        "QT_AUTO_SCREEN_SCALE_FACTOR         , 1         "
        "QT_WAYLAND_DISABLE_WINDOWDECORATION , 1         "

        "MOZ_ENABLE_WAYLAND                  , 1         "
        "NIXOS_OZONE_WL                      , 1         "
        "ELECTRON_OZONE_PLATFORM_HINT        , auto      "

        "GTK_WAYLAND_DISABLE_WINDOWDECORATION, 1         "

        "GDK_SCALE							 						 , 1.0		 	 "

        "XCURSOR_THEME						 					 ,Adwaita    "
        "XCURSOR_SIZE						 			 ,24			   "
      ];
      # Env ends

      # Monitor starts
      monitor = [
        "Virtual-1, 1920x1080@60, auto, 1"
      ];
      # Monitor ends

      xwayland = {
        force_zero_scaling = true;
      };

    };
  };
  home.file.".config/hypr/xdph.conf".text = ''
    screencopy {
      allow_token_by_default = true
    }
  '';
}
