{
  config,
  pkgs,
  ...
}: {
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
            namespace = "waypaper";
          }
        ];
        layer = "background";
        overview = "show";
      }
    ];
    window-rules = [
      {
        matches = [
          { app-id = "goggle-chrome-stable"; }
        ];
        open-on-workspace = "browser";
        geometry-corner-radius = {
          top-left = 20.0;
          top-right = 20.0;
          bottom-left = 20.0;
          bottom-right = 20.0;
        };
        clip-to-geometry = true;
      }

      # Vesktop with rounded corners
      {
        matches = [
          { app-id = "discord"; }
        ];
        open-on-workspace = "discord";
        geometry-corner-radius = {
          top-left = 20.0;
          top-right = 20.0;
          bottom-left = 20.0;
          bottom-right = 20.0;
        };
        clip-to-geometry = true;
      }

      # Default rule for all other windows with rounded corners
      {
        matches = [{}]; # Matches all windows not matched by above rules
        geometry-corner-radius = {
          top-left = 20.0;
          top-right = 20.0;
          bottom-left = 20.0;
          bottom-right = 20.0;
        };
        clip-to-geometry = true;

        default-column-width = {
          proportion = 0.75;
        };

      }
    ];
  };
}
