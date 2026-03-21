{ pkgs }:

{
  browser = "google-chrome-stable";
  #browser = "${pkgs.firefox}/bin/firefox";
  terminal = "${pkgs.ghostty}/bin/ghostty";
  fileManager = "${pkgs.thunar}/bin/thunar";
  editor = "nvim";
  #editor = "${pkgs.walker}/bin/walker";

  screenshotArea = "${pkgs.bash}/bin/bash -c '${pkgs.grim}/bin/grim -g \"\\\$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy'";
  screenshotWindow = "${pkgs.bash}/bin/bash -c '${pkgs.grim}/bin/grim -g \"\\\$(${pkgs.slurp}/bin/slurp -w)\" - | ${pkgs.wl-clipboard}/bin/wl-copy'";
  screenshotOutput = "${pkgs.bash}/bin/bash -c '${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy'";
}
