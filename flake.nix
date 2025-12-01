{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hoyoverse
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    blender-bin.url = "github:edolstra/nix-warez?dir=blender";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, aagl, blender-bin, ... }: {
    nixosConfigurations.vividskies-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit self inputs; };
      modules = [
        ./configuration.nix
        ./noctalia.nix
	      home-manager.nixosModules.home-manager
        ({config, pkgs, ...}: { nixpkgs.overlays = [ blender-bin.overlays.default ]; })
          
        {
          imports = [ aagl.nixosModules.default ];
          nix.settings = aagl.nixConfig;
          programs.anime-game-launcher.enable = true;
          programs.honkers-railway-launcher.enable = true;
          programs.wavey-launcher.enable = true;
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.vividskies = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
