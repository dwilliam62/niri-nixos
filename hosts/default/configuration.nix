{ config, pkgs, inputs, lib, self, ... }:

{
  imports = [
    ./hardware-configuration.nix
    "${self}/system/greeter/greetd.nix"
    #"${self}/system/programs/steam.nix"
    #"${self}/system/programs/lact.nix"
    "${self}/system/programs/nh.nix"
    "${self}/system/programs/thunar.nix"
    "${self}/system/programs/stylix.nix"
    "${self}/system/xdg.nix"
    "${self}/system/environment.nix"
    "${self}/system/packages.nix"
    "${self}/system/fonts.nix"
    #"${self}/system/filesystems.nix"
    inputs.home-manager.nixosModules.default
  ];

  nixpkgs.overlays = [
    (final: prev: {
      nur = import inputs.nur {
        nurpkgs = prev;
        pkgs = prev;
      };
    })
  ];

  users.groups.i2c = {}; # ✅ Ensure group exists

  users.users.dwilliams = {
    isNormalUser = true;
    description = "Don Williams";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
      "plugdev"
      "i2c"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      "dwilliams" = import ./home.nix;
    };
  };

  fonts.packages = with pkgs; [
    fira-sans
    roboto
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    material-symbols
    material-icons
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = [
      "video=Virtual-1,1920x1080@60"
    ];
    kernelModules = [ "v4l2loopback" "i2c-dev" ];
    initrd.availableKernelModules = [ "i2c-dev" ]; # ✅ Load early in initrd
    extraModprobeConfig = ''
      options v4l2loopback video_nr=0 card_label="DroidCam" exclusive_caps=1
    '';
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
  };

  services.udev.packages = [ pkgs.rwedid ]; # ✅ Enable I2C udev rules
  services.rpcbind.enable = true; 
  services.nfs.server.enable = true; 
  security.sudo.wheelNeedsPassword = false;
  services.flatpak.enable = true; 
  services.openssh.enable = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };

  networking = {
    hostName = "niri-nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/New_York";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  programs.zsh.enable = true;

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "intel" ];
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    dbus.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };
  };

  console.keyMap = "us";

  xdg.portal.enable = true;

  nixpkgs.config.allowUnfree = true;

  home-manager.backupFileExtension = "backup";

  system.stateVersion = "25.05";

  system.activationScripts.logRebuildTime = {
    text = ''
      LOG_FILE="/var/log/nixos-rebuild-log.json"
      TIMESTAMP=$(date "+%d/%m")
      GENERATION=$(readlink /nix/var/nix/profiles/system | grep -o '[0-9]\+')

      echo "{\"last_rebuild\": \"$TIMESTAMP\", \"generation\": $GENERATION}" > "$LOG_FILE"
      chmod 644 "$LOG_FILE"
    '';
  };
}
