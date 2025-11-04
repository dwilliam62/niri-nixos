{pkgs, ...}:
with pkgs; [
  # Applications
  #  protonplus
  #  lutris
  #  dolphin-emu
  #  prismlauncher
  #  heroic
  #  peazip
  # nautilus
  file-roller

  # TUI
  btop
  yazi
  atop
  htop

  # Desktop
  hyprlock
  nwg-look
  walker

  # Development
  nodejs
  rustup
  gcc
  gh
  nixfmt-rfc-style
  nixpkgs-fmt
  black

  # Utilities
  jq
  socat
  tree
  libnotify
  nvd
  #pywalfox-native
  imagemagick
  #amdvlk  # nO longer supported
  rar
  unzip
  gowall
  gruvbox-gtk-theme
  papirus-icon-theme
  grimblast
  gpu-screen-recorder
  mpv
  slop

  # Quickshell stuff
  qt6Packages.qt5compat
  libsForQt5.qt5.qtgraphicaleffects
  kdePackages.qtbase
  kdePackages.qtdeclarative

  # Niri
  xwayland-satellite
  grim
  slurp
  wl-clipboard
]
