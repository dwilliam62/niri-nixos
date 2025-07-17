{
  config,
  pkgs,
  inputs,
  ...
}:

{
  environment.variables = {
    XCURSOR_SIZE = "24";
    QT_QPA_PLATFORM = "wayland";
    NH_FLAKE="/home/dwilliams/nixos";
  };
}
