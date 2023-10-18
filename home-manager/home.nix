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
    stateVersion = "23.05";
    packages = with pkgs; [
      oh-my-zsh
    ];
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.waybar.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  systemd.user.startServices = "sd-switch";
}
