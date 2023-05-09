{pkgs, ...}: {
  home.packages = with pkgs; [gh];

  programs.git = {
    enable = true;
    userEmail = "alexander@sellstrom.me";
    userName = "Alexander Sellström";
    signing = {
      key = "5A7CD3A160BF31A35F70E0FDD9586DF88DAC5A9B";
      signByDefault = true;
    };
    ignores = ["*result*" ".direnv" "node_modules"];
  };
}
