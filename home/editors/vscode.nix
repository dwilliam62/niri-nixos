{pkgs, ...}: {
  #nixpkgs.config.allowUnfree = true;

  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          esbenp.prettier-vscode
          catppuccin.catppuccin-vsc
          bbenoist.nix
          jeff-hykin.better-nix-syntax
          ms-vscode.cpptools-extension-pack
          vscodevim.vim # Vim emulation
          mads-hartmann.bash-ide-vscode
          tamasfe.even-better-toml
          zainchen.json
          shd101wyy.markdown-preview-enhanced
        ];
        userSettings = {
          #"workbench.colorTheme" = "Catppuccin Mocha";
          #"workbench.iconTheme" = "catppuccin-mocha";
           "editor.formatOnSave" = true;
           "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
      };
    };
  };
}
