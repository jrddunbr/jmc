{ pkgs, ... }:

{
  home.packages = [
    pkgs.htop
    #pkgs.discord
    pkgs.dmidecode
    pkgs.ffmpeg
    pkgs.multimc
    #pkgs.steam-run
    pkgs.virt-manager
    pkgs.vlc
    pkgs.wireshark-qt
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.firefox = {
    enable = true;
  };

  programs.home-manager = {
    enable = true;
  };
}

