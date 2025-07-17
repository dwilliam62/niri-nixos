{
  pkgs,
  ...
}: {
  programs.nh = {
    enable = true;
    flake = "/home/dwilliams/nixos";
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
