{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.05"; # Matches your NixOS version
  networking.hostName = "tyke";  
  i18n.defaultLocale = "en_US.UTF-8"; 
  time.timeZone = "Europe/Paris";

  # Filesystem
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fb87ae20-fb74-497d-af89-42175c01626e";
    fsType = "ext4";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
  };

  # User configuration
  users.users.zach = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # sudo access
  };

  # Unfree/insecure package handling
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ 
    "dotnet-sdk-7.0.410"
    "freeimage-unstable-2021-11-01"
  ];

  # System-wide packages
  environment.systemPackages = with pkgs; [
    # Core utilities
    wget curl git unzip vim htop neofetch

    # Wayland / Sway environment
    sway swaylock swayidle swaybg swaynotificationcenter 
    waybar playerctl light grim slurp pulseaudio pavucontrol
    plymouth
        
    # Networking tools
    networkmanager networkmanagerapplet 

    # Apps & Utilities
    wofi kitty starship fish pywal 

    vesktop spotify brave beeper

    # Development tools
    jetbrains.rider dotnet-sdk_7 unityhub 

    # Other
    gtk3 libinput fuse home-manager chromium

    # Games
    prismlauncher forge 
  ];

  fonts.packages = with pkgs; [
    nerdfonts
    font-awesome
  ];

  # Greetd (Login Manager)
  services.greetd = {
    enable = true;
    settings.default_session = {
      user = "zach";
      command = "${pkgs.sway}/bin/sway";
    };
  };
  
  # Bluetooth
  services.blueman.enable = true;  # Enables Blueman for management
  hardware.bluetooth.enable = true; # Enables Bluetooth support
  hardware.bluetooth.powerOnBoot = true; # Turns on Bluetooth at boot
  programs.dconf.enable = true;

  # Import hardware configuration
  imports = [ ./hardware-configuration.nix ];
}
