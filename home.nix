{ config, pkgs, ... }:

{
  home.username = "vividskies";
  home.homeDirectory = "/home/vividskies";
  home.stateVersion = "26.05";
  
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos btw";
      nrs = "sudo nixos-rebuild switch";
    };
    
    initExtra = ''
      export PS1='\[\e[38;5;153m\]\u\[\e[0m\] in \[\e[38;5;225m\]\w\[\e[0m\] \\$ '
    '';
    
  };
  
  programs.alacritty = {
    enable = false;
    settings = {
      window.opacity = 0.9;
      font.normal = {
        family = "JetBrains Mono";
        style = "Regular";
      };
      font.size = 14;
    };
  };
  
  
  home.file.".config/bat/config".text = ''
    --theme="Nord"
    --style="numbers,changes,grid"
    --paging=auto
  '';
  
  home.file.".config/qtile".source = /home/vividskies/dotfiles/qtile;
  
  home.packages = with pkgs; [ 
    bat
    kdePackages.kate
    ghostty
  ];
}
