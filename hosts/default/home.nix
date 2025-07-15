{
  config,
  pkgs,
  inputs,
  self,
  ...
}:

let
  allPackages = import ./packages.nix { inherit pkgs; };
in
{
  home.username = "dwilliams";
  home.homeDirectory = "/home/dwilliams";

  imports = [
    ../../home/niri/default.nix
    ../../home/desktop/hyprland.nix
    ../../home/quickshell/quickshell.nix
    ../../home/desktop/hyprlock.nix
    ../../home/desktop/hypridle.nix
    ../../home/desktop/walker.nix

    ../../home/editors/vscode.nix
    ../../home/editors/nixvim.nix

    ../../home/programs/ghostty.nix
    ../../home/programs/fastfetch.nix
    ../../home/programs/spicetify.nix
    ../../home/programs/obs.nix
    ../../home/programs/vesktop.nix
    ../../home/programs/firefox.nix

    ../../system/shell/zsh.nix

    inputs.hyprland.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home.packages = allPackages;

  xdg.portal.enable = true;

  home.stateVersion = "24.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  services.cliphist = {
    enable = true;
    allowImages = true;
  };

  programs.home-manager.enable = true;
}
