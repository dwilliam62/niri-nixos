# Eza is a ls replacement
{
  programs.eza = {
    enable = true;
    icons = "auto";
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    git = true;

    extraOptions = [
      "--group-directories-first"
      "--no-quotes"
      "--header" # Show header row
      "--git-ignore"
      # "--time-style=long-iso" # ISO 8601 extended format for time
      "--classify" # append indicator (/, *, =, @, |)
      "--hyperlink" # make paths clickable in some terminals
    ];
  };
  # Aliases to make `ls`, `ll`, `la` use eza
  home.shellAliases = {
    sv = "sudo nvim";
    v = "nvim";
    c = "clear";
    ls = "eza -a";
    lt = "eza --tree --level=2";
    ll = "eza  -a --no-user --long";
    la = "eza -lah ";
    tree = "eza --tree ";
    d = "exa -a --grid ";
    dir = "exa -a --grid";
    jctl = "journalctl -p 3 -xb";
    notes = "nvim ~/notes.txt";
    gcCleaner = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
    cat = "bat";
    man = "batman";
    dysk = "dysk -c label+default";
    rebuild = "nh os switch -H default";
    update = "nh os switch -H default --update";
    ncg = "nh clean all";
  };
}
