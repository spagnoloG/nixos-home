{
  description = "Nixos: Home-Manager and System configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypr-contrib.url = "github:hyprwm/contrib";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;

      mkDesktopSystem = pkgs: system: hostname: user: graphical-environment:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./modules/system/base-desktop/configuration.nix
            (./. + "/hosts/${hostname}/hardware-configuration.nix")
            (./. + "/hosts/${hostname}/default.nix")
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs user; };
                users.${user} = (./. + "/hosts/${hostname}/user.nix");
              };
            }
          ];
          specialArgs = { inherit inputs user hostname graphical-environment; };
        };

      mkServerSystem = pkgs: system: hostname: user:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./modules/system/base-server/configuration.nix
            (./. + "/hosts/${hostname}/hardware-configuration.nix")
            (./. + "/hosts/${hostname}/default.nix")
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs user; };
                users.${user} = (./. + "/hosts/${hostname}/user.nix");
              };
            }
          ];
          specialArgs = { inherit inputs user hostname; };
        };

    in {
      nixosConfigurations = {
        yoga =
          mkDesktopSystem inputs.nixpkgs "x86_64-linux" "yoga" "spagnologasper"
          "hypr";
        carbon = mkDesktopSystem inputs.nixpkgs "x86_64-linux" "carbon"
          "spagnologasper" "hypr";
        ml-node =
          mkServerSystem inputs.nixpkgs "x86_64-linux" "ml-node" "ml-node";
        ddvic-node = mkServerSystem inputs.nixpkgs "x86_64-linux" "ddvic-node"
          "ddvic-node";
      };
    };
}
