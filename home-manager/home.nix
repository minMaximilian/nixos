{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "max";
    homeDirectory = "/home/max";
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.waybar = {
    enable = true;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
