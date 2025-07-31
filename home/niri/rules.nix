{...}: {
  programs.niri.settings = {
    layer-rules = [
      {
        matches = [
          {
            namespace = "swww-daemon";
          }
        ];
        place-within-backdrop = true;
      }
      {
        matches = [
          {
            namespace = "quickshell-desktop";
          }
        ];
        place-within-backdrop = true;
      }
      {
        matches = [
          {
            namespace = "quickshell-wallpaper";
          }
        ];
        place-within-backdrop = true;
      }
    ];
    window-rules = [
      {
        matches = [
          {app-id = "goggle-chrome";}
        ];
        open-on-workspace = "browser";
      }

      # Vesktop with rounded corners
      {
        matches = [
          {app-id = "discord";}
        ];
        open-on-workspace = "discord";
      }

      # Default rule for all other windows with rounded corners
      {
        matches = [{}]; # Matches all windows not matched by above rules
        default-column-width = {
          proportion = 0.85;
        };
      }
    ];
  };
}
