{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.05";
  networking.hostName = "tyke";
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Paris";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fb87ae20-fb74-497d-af89-42175c01626e";
    fsType = "ext4";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
  };

  users.users.zach = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-7.0.410"
    "freeimage-unstable-2021-11-01"
  ];

  environment.systemPackages = with pkgs; [
    wget curl git unzip vim htop
    swayfx swaylock swayidle swaybg swaynotificationcenter
    waybar playerctl light grim slurp pulseaudio pavucontrol
    plymouth
    networkmanager networkmanagerapplet
    wofi kitty starship fish pywal
    vesktop spotify brave beeper
    jetbrains.rider dotnet-sdk_7
    gtk3 libinput fuse home-manager
    wlroots
    scenefx
];

  fonts.packages = with pkgs; [
    font-awesome
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  services.greetd = {
    enable = true;
    settings.default_session = {
      user = "zach";
      command = "${pkgs.swayfx}/bin/sway";
    };
  };

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  programs.dconf.enable = true;

  imports = [ ./hardware-configuration.nix ];

  # Swayfx Configuration with blur
  #xdg.configFile."sway/config".source = ./sway-config.conf;
}
