{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    # flake-parts.url = "github:hercules-ci/flake-parts";
    # comma.url = "github:nix-community/comma";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # mango = {
    #   url = "github:DreamMaoMao/mango";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # caelestia-shell = {
    #   url = "github:caelestia-dots/shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # caelestia-cli = {
    #   url = "github:caelestia-dots/cli";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # noctalia = {
    #   url = "github:noctalia-dev/noctalia-shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    catppuccin.url = "github:catppuccin/nix";

  };

  outputs = { self, nixpkgs, home-manager, catppuccin, aagl, ...} @ inputs :
    let
      system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.vividskies = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        # nix.settings = aagl.nixConfig;
        modules = [
          ./configuration.nix
          catppuccin.nixosModules.catppuccin
          {
            imports = [ aagl.nixosModules.default ];
            nix.settings = aagl.nixConfig; # Set up Cachix
          }
          home-manager.nixosModules.home-manager
          # caelestia-shell.packages..default
          # ./.config/noctalia/noctalia.nix
          # ./.config/caelestia

          {
            home-manager = {
              
              extraSpecialArgs = { inherit inputs; };
              useGlobalPkgs = true;
              useUserPackages = true;
              users.vividskies = {
                imports = [
                  ./home.nix
                  catppuccin.homeModules.catppuccin
                  
                ];
              };
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
}
