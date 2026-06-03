{
  config,
  pkgs,
  lib,
  self,
  ...
}: {
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.base16Scheme = toString (builtins.path {
    path = ../../assets/themes/base-16/oxocarbon.yaml;
  });
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon.yaml";
  stylix.enableReleaseChecks = false;
  stylix.targets.kmscon.enable = false;
}
