{ config, pkgs, ... }:

{
  home.username = "zach";
  home.homeDirectory = "/home/zach";
  home.stateVersion = "23.05"; # Matches system.stateVersion for stability

  nixpkgs.config.allowUnfree = true;

  home.file = {
    ".config/sway".source = ./config/sway;
    ".config/wofi".source = ./config/wofi;
    ".config/waybar".source = ./config/waybar;
    ".config/fish".source = ./config/fish;
    ".config/kitty".source = ./config/kitty;
    ".config/starship.toml".source = ./config/starship.toml;
    ".config/swaync".source = ./config/swaync;
  };

  # User-level packages
  home.packages = with pkgs; [
    # CLI tools
    bat ripgrep fd eza jq fzf neofetch

    # Games
    prismlauncher    
    
    # School
    unityhub
  ];

  # Environment Variables
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Enable Home Manager programs
  programs.home-manager.enable = true;
}
