{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Enable Hyprland and niri to create sessions and set dependenciew

  programs = {
    hyprland = {
      enable = true;
    };
    niri = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    inputs.wfetch.packages.${pkgs.system}.default #custom fetch for nixos

    ironbar
    pamixer
    swaynotificationcenter
    cliphist
    rofi
    glxinfo
    mesa-demos
    pciutils

    adwaita-icon-theme
    atop
    #arrpc
    #alvr
    btop
    base16-schemes
    bottom
    cava
    clapgrep
    curl
    ddcutil
    discord
    discord-canary
    dua
    duf
    dysk
    eza
    fastfetch
    fzf
    fd
    findutils
    ffmpeg
    gemini-cli
    ghostty
    git
    gnome-themes-extra
    google-chrome
    gcc
    gitnuro #desktop gui for git
    glab #gitlab cli toosl
    gnumake
    htop
    hyfetch #includisve system fetch
    iotop
    inxi
    kitty
    lazygit
    lshw
    libva
    libva-utils
    libayatana-appindicator
    luarocks
    lunarvim
    lsd
    mesa
    nh
    nitch
    nodePackages.prettier
    pavucontrol
    pulseaudio
    playerctl
    pywal16
    pywalfox-native
    ripgrep
    swww
    swaybg
    spicetify-cli
    xwayland
    waypaper
    wezterm
    wget
    unzip
    ugrep
    virt-viewer
  ];
}
