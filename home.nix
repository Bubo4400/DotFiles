{ config, pkgs, ... }:

{
  home.username = "zach";
  home.homeDirectory = "/home/zach";
  home.stateVersion = "23.05"; # Matches system.stateVersion for stability

  nixpkgs.config.allowUnfree = true;

  home.file = {
    ".config/sway".source = ./configs/sway;
    ".config/wofi".source = ./configs/wofi;
    ".config/waybar".source = ./configs/waybar;
    ".config/fish".source = ./configs/fish;
    ".config/kitty".source = ./configs/kitty;
    ".config/starship.toml".source = ./configs/starship.toml;
    ".config/swaync".source = ./configs/swaync;
    ".config/vesktop".source = ./configs/vesktop;
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
