{ inputs, config, lib, pkgs, ... }: {
  imports = [ 
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };
  
  networking = {
    hostName = "vividskies-pc";
    networkmanager.enable = true;
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
  time.timeZone = "Australia/Melbourne";
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  
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
  
  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      windowManager.qtile.enable = true;
      exportConfiguration = true;
      xrandrHeads = [
      {
        output = "DP-4";
        primary = true;
        monitorConfig = ''
        ModeLine "3440x1440_174.96"  1347.58  3440 3752 4136 4832  1440 1441 1444 1594  -hsync +vsync
        Option "PreferredMode" "3440x1440_174.96"
        '';
      }
    ];
      displayManager.sessionCommands = ''
      xwallpaper --zoom ~/wallpapers/nixos-anime.jpg
      xset r rate 200 35 & 
      '';
    
      displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr \
      --output DP-4 --primary --mode 3440x1440 --rate 175 \
      --output DP-2  --mode 2560x1440 --rate 144 --above DP-4
      '';
    };
    
    picom = {
      enable = true;
      backend = "glx";
      fade = true;
    };
    
    printing.enable = true;
    # services.xserver.xkb.layout = "us";
    # services.xserver.xkb.options = "eurosign:e,caps:escape";
    
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
      touchpad = {accelProfile = "flat";};
    };
    
    openssh.enable = true;
  
    udisks2.enable = true;
    gvfs.enable = true;
    devmon.enable = true;
  };
  
   users.users.vividskies = {
     isNormalUser = true;
     extraGroups = [ 
       "wheel" 
       "networkmanager"
       "input"
       "docker"
       "audio" 
     ];
     # shell = pkgs.zsh;
   };
  programs = {
    firefox.enable = true;
  };
   
   fonts.packages = with pkgs; [
     jetbrains-mono
   ];

  nixpkgs.config = {
    allowUnfree = true;
    # cudaSupport = true;
  };

  environment.systemPackages = with pkgs; [
    wget
    gedit
    # alacritty
    btop
    xwallpaper
    pcmanfm
    rofi
    vesktop
    blender
    obs-studio
    git
    ungoogled-chromium
    udiskie
    #cudaPackages.cudatoolkit
    #cudaPackages.cudnn
    #cudaPackages.cuda_cudart
    tree
  ];
 

  fileSystems."/mnt/exampleDrive" = {
    device = "/dev/disk/by-uuid/4f999afe-6114-4531-ba37-4bf4a00efd9e";
    fsType = "exfat";
    options = [ # If you don't have this options attribute, it'll default to "defaults" 
      # boot options for fstab. Search up fstab mount options you can use
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
     
   ];
 };  

  system.stateVersion = "25.05"; 

}

