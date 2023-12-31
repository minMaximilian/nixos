{ outputs, config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../modules/home-manager.nix
    ];

  nixpkgs = {
    overlays = [
    ];

    config = {
      allowUnfree = true;
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Dublin";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IE.UTF-8";
    LC_IDENTIFICATION = "en_IE.UTF-8";
    LC_MEASUREMENT = "en_IE.UTF-8";
    LC_MONETARY = "en_IE.UTF-8";
    LC_NAME = "en_IE.UTF-8";
    LC_NUMERIC = "en_IE.UTF-8";
    LC_PAPER = "en_IE.UTF-8";
    LC_TELEPHONE = "en_IE.UTF-8";
    LC_TIME = "en_IE.UTF-8";
  };

  services.xserver.enable = true;

  services.xserver.displayManager.sddm.enable = true;
  programs.hyprland.enable = true;

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users= {
    defaultUserShell = pkgs.zsh;
    users.max = {
      isNormalUser = true;
      description = "max";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.zsh;
      createHome = true;
      packages = with pkgs; [
        firefox
      ];
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    vim
    wget
    home-manager
    alacritty
    rofi-wayland
    spotify
    swww
    discord
    lua
    docker
    docker-compose
    rustc
    cargo
    dunst
    libnotify
    go_1_21
    jdk17
    python311
    zsh
    gradle
    maven
    tree
    unzip
    htop
    neofetch
  ];
  
  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
    font-awesome
  ];

  system.stateVersion = "23.05";
}
