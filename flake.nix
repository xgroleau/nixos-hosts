{
  description = "My nixos configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-dotfiles.url = "github:xgroleau/nix-dotfiles/main";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nix-dotfiles, flake-utils }:
    {

      nixosConfigurations = {
        example = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/godzilla/configuration.nix
            ./hosts/godzilla/hardware-configuration.nix
            (nix-dotfiles.utils.nixosConfigurationFromProfile {
              username = "xgroleau";
              profile = nix-dotfiles.profiles.desktop;
            })
          ];
        };
      };
    }

    # Utils of each system
    // (flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShell =
          pkgs.mkShell { buildInputs = with pkgs; [ git nixfmt statix ]; };
      }));
}
