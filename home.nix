{ config, pkgs, ... }:

{
  home.username = "zach";
  home.homeDirectory = "/home/zach";
  home.stateVersion = "23.05"; # Matches system.stateVersion for stability

  nixpkgs.config.allowUnfree = true;

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
