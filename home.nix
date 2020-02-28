{ pkgs, ... }:

{
  home.packages = [
    pkgs.htop
  ];

  programs.firefox = {
    enable = true;
  };

  programs.home-manager = {
    enable = true;
  };
}

