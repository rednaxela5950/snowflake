{
  description = "snowflake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-22.11";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      name = "snowflake";
      packages = with pkgs; [
        nil
        yaml-language-server
        alejandra
        git
        deploy-rs
        sops
        file
        inlyne
      ];
    };
    deploy = import ./hosts/deploy.nix inputs;
    formatter.${system} = pkgs.alejandra;
    nixosConfigurations = {
      cumputer = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/cumputer
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
              users.cellis = {
                imports = [
                  hyprland.homeManagerModules.default
                  ./hosts/cumputer/home.nix
                ];
              };
            };
          }
        ];
      };
      tsuki = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/tsuki
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
              users.notoh = {
                imports = [
                  hyprland.homeManagerModules.default
                  ./hosts/tsuki/home.nix
                ];
              };
            };
          }
        ];
      };
      hime = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/hime
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.oh = {imports = [./hosts/hime/home.nix];};
            };
          }
        ];
      };
      sutakku = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/sutakku
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.oh = {
                imports = [./hosts/sutakku/home.nix];
              };
            };
          }
        ];
      };
    };
  };
}
