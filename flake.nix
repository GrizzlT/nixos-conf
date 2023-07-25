{
  description = "GrizzlT's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    stylix.url = "github:danth/stylix";
    impermanence = {
      type = "github";
      owner = "nix-community";
      repo = "impermanence";
      ref = "master";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let nixSettings = import ./common/nix-settings.nix; in {
    packages = nixpkgs.lib.genAttrs [ "aarch64-linux" "x86_64-linux" ] (system: import ./packages {
      inherit self;
      pkgs = nixpkgs.legacyPackages.${system};
      flake-inputs = inputs;
    });

    nixosConfigurations."clevo" = let system = "x86_64-linux"; in nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        grizz-zfs-diff = self.packages.${system}.grizz-zfs-diff;
        inherit home-manager;
        inherit (inputs) hyprland stylix;
        inherit nixSettings;
      };
      modules = [
        inputs.hyprland.nixosModules.default
        inputs.impermanence.nixosModules.impermanence
        ./hosts/clevo/configuration.nix
      ];
    };

    homeConfigurations."grizz@clevo" = let pkgs = nixpkgs.legacyPackages."x86_64-linux"; in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = inputs;
        modules = [
          ./home/base
          ./home/desktop
          {
            home = {
              username = "grizz";
              homeDirectory = "/home/grizz";
              stateVersion = "23.05";
            };
            nix = nixSettings.home { inherit pkgs; };
          }
        ];
    };
  };
}
