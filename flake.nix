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

  };

  outputs = inputs@{ self, nixpkgs, home-manager, aagl, ... }: {
    nixosConfigurations.vividskies-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [ 
        ./configuration.nix
	home-manager.nixosModules.home-manager
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
      ] ;
    };
  };
}
