{
  config,
  pkgs,
  inputs,
  self,
  ...
}: let
  allPackages = import ./packages.nix {inherit pkgs;};
  niriScripts = import ../../home/niri/scripts.nix {inherit pkgs;};
in {
  home.username = "dwilliams";
  home.homeDirectory = "/home/dwilliams";

  imports = [
    ../../home/niri/default.nix
    ../../home/desktop/hyprland.nix
    ../../home/quickshell/quickshell.nix
    ../../home/desktop/hyprlock.nix
    ../../home/desktop/hypridle.nix
    ../../home/desktop/walker.nix
    ../../home/desktop/waybar-ddubs-2.nix
    ../../home/desktop/ironbar.nix

    ../../home/editors/vscode.nix
    #../../home/editors/nixvim.nix
    ../../home/editors/nvf.nix

    ../../home/programs/ghostty.nix
    ../../home/programs/fastfetch.nix
    #../../home/programs/spicetify.nix
    ../../home/programs/obs.nix
    ../../home/programs/vesktop.nix
    ../../home/programs/firefox.nix
    ../../home/programs/eza.nix
    ../../home/programs/bat.nix
    ../../home/programs/bottom.nix
    ../../home/programs/cava.nix
    ../../home/programs/fzf.nix
    ../../home/programs/tmux.nix
    ../../home/programs/evil-helix.nix
    ../../home/programs/kitty.nix
    ../../home/programs/wezterm.nix
    ../../home/programs/tealdeer.nix

    ../../system/shell/zsh.nix

    inputs.hyprland.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModules.default
    inputs.nixvim.homeModules.nixvim
  ];

  home.packages = allPackages ++ niriScripts;

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
