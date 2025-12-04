{
  self,
  inputs,
  lib,
  config,
  pkgs,
  ...
} : {
  
  home = {
    username = "vividskies";
    homeDirectory = "/home/vividskies";
    stateVersion = "26.05";
    packages = with pkgs; [
      wget
      bat
      vim
      git
      btop
      tree
      lutris
      protonup-qt
      bottles
      thunderbird
      mpv
      obs-studio
      tmux
      yazi
      zellij
      (blender.override {cudaSupport = true;})
      # niri
      # steam
      # hyprlock
      jetbrains.rider
      # inputs.caelestia-shell.packages.${stdenv.hostPlatform.system}.default
      # inputs.caelestia-cli.packages.${stdenv.hostPlatform.system}.default
      (inputs.quickshell.packages.${stdenv.hostPlatform.system}.default.override {
        
        })

#      kate
    ];

    # file.".config/bat/config".text = ''
    #   --theme="Nord"
    #   --style="numbers,changes,grid"
    #   --paging=auto
    # '';

    # home.file.".config/qtile".source = "/dotfiles/qtile";

    # file.qtile_config = {
    #   source = ./.config/qtile/config.py;
    #   target = ".config/qtile/config.py";
    # };

    file.".config/niri/config.kdl".source = ./.config/niri/config.kdl;
    # file.".config/caelestia/shell.json".source = ./.config/caelestia/shell.json;
    # file.".config/fuzzel/fuzzel.ini".source = ./.config/fuzzel/fuzzel.ini;
  };

  catppuccin = {
    enable = true;
    accent = "pink";
    flavor = "mocha";
    waybar.mode = "createLink";
    # sddm.enable = true;
  };
  services = {
    mako.enable = true;
    autorandr.enable = true;
    udiskie.enable = true;
  };
  programs = {
    home-manager.enable = true;
    fastfetch.enable = true;
    neovim.enable = true;
    waybar.enable = true;
    
    fuzzel.enable = true;
    vesktop.enable = true;
    vscode.enable = true;
    firefox.enable = true;
    librewolf.enable = true;
    mullvad-vpn.enable = true;
    ghostty.enable = true;
    alacritty.enable = true;
    bash = {
      enable = true;
      shellAliases = {
        btw = "echo i use nixos btw";
        nrs = "sudo nixos-rebuild switch";
      };

      initExtra = ''
        export PS1='\[\e[38;5;153m\]\u\[\e[0m\] in \[\e[38;5;225m\]\w\[\e[0m\] \\$ '
      '';
    };
    # anime-game-launcher.enable = true;
    # alacritty = {
    #   enable = true;
    #   settings = {
    #     window.opacity = 0.9;
    #     font.normal = {
    #       family = "JetBrains Mono";
    #       style = "Regular";
    #     };
    #     font.size = 14;
    #   };
    # };

    #   programs.quickshell.enable = true;

  };
  # systemd.user.services.attic-watch-store = {
  #   Unit = {
  #     Description = "Push nix store changes to attic binary cache.";
  #   };
  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.writeShellScript "watch-store" ''
  #       #!/run/current-system/sw/bin/bash
  #       ATTIC_TOKEN=$(cat ${config.sops.secrets.attic_auth_token.path})
  #       ${pkgs.attic}/bin/attic login prod https://majiy00-nix-binary-cache.fly.dev $ATTIC_TOKEN
  #       ${pkgs.attic}/bin/attic use prod
  #       ${pkgs.attic}/bin/attic watch-store prod:prod
  #     ''}";
  #   };
  # };
}
