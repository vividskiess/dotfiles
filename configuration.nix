# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs,  pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "vividskies";
    networkmanager.enable = true;

    extraHosts = ''
      0.0.0.0 hkrpg-log-upload-os.hoyoverse.com
      0.0.0.0 log-upload-os.hoyoverse.com
      0.0.0.0 sg-public-data-api.hoyoverse.com
    '';
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";

    };
  };
  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;

    nvidia = {
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    steam-hardware.enable = true;
    wooting.enable = true;
    usb-modeswitch.enable = true;
    opentabletdriver.enable  = true;
  };

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha-pink";
      package = pkgs.kdePackages.sddm;
    };
    # desktopManager.plasma6.enable = true;
    xserver = {
      enable = false;
      videoDrivers = ["nvidia"];
      exportConfiguration = true;
      xkb = {
        layout = "au";
        variant = "";
      };
      xrandrHeads = [
      {
        output = "HMDI-A-2";
        primary = true;
        monitorConfig = ''
        ModeLine "3440x1440_174.96"  1347.58  3440 3752 4136 4832  1440 1441 1444 1594  -hsync +vsync
        Option "PreferredMode" "3440x1440_174.96"
        '';
      }
    ];
#             xwallpaper --zoom ~/wallpapers/nixos-anime.jpg
      displayManager.sessionCommands = ''

      xset r rate 200 35 &
      '';

      displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr \
      --output HDMI-A-2 --primary --mode 3440x1440 --rate 175 \
      --output DP-2  --mode 2560x1440 --rate 144 --above HDMI-A-2
      '';
      };

    printing.enable = true;

    # pulseaudio.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      audio.enable = true;
      wireplumber.enable = true;
    };

    libinput = {
      enable = true;
      mouse = {accelProfile = "flat";};
      # touchpad = {accelProfile = "flat";};
    };

    openssh.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
    devmon.enable = true;
#     blueman.enable = true;
#     tumbler.enable = true;
#     fstrim.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vividskies = {
    isNormalUser = true;
    description = "vividskies";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # kdePackages.kate
      #  thunderbird
    ];
  };

  # Install firefox.
  programs = {
    anime-game-launcher.enable = true;
    wavey-launcher.enable = true;
    honkers-launcher.enable = true;
    honkers-railway-launcher.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    # firefox.enable = true;
    niri.enable = true;
#     steam.enable = true;
  };
#   programs.mangowc = {
#     enable = true;
#   };
  fonts.packages = with pkgs; [
    jetbrains-mono

    ];

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;

  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
#     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
#     wget
#     vim
#     git
#     ghostty
#     btop
#     neovim
#     vesktop
#     tree
#     bat
#     tree
#     lutris
#     protonup-qt
#     bottles
#     (blender.override {cudaSupport = true;})
    godot
    godot-mono
    github-desktop
    xwayland-satellite
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    kdePackages.xdg-desktop-portal-kde
    wl-clipboard
    catppuccin-cursors.mochaPink
    (catppuccin-sddm.override {
      flavor = "mocha";
      accent = "pink";
      font  = "JetBrains Mono";
      fontSize = "9";
      background = "${./images/wallpapers/pink-clouds.jpg}";
      loginBackground = true;
    })
     kdePackages.qtmultimedia
     qt6Packages.qt5compat
     libsForQt5.qt5.qtgraphicaleffects
     kdePackages.qtbase
#    pcmanfm
    cudaPackages.cudatoolkit
    # inputs.caelestia-shell.packages.${stdenv.hostPlatform.system}.default
    kdePackages.kate
    gparted
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
