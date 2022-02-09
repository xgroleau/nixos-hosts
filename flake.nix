{
  description = "My nixos configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-dotfiles.url = "github:xgroleau/nix-dotfiles/main";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nix-dotfiles, flake-utils }:
    let
      hosts = import ./hosts;

      lib = nixpkgs.lib.extend (self: super: { my = nix-dotfiles.lib.my; });

    in {
      nixosConfigurations = lib.mapAttrs (hostName: hostConfig:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            hostConfig
            (nix-dotfiles.utils.nixosConfigurationFromProfile {
              username = "xgroleau";
              profile = nix-dotfiles.profiles.desktop;
            })
          ];
        } hosts);
    }

    # Utils of each system
    // (flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        apps = {
          fmt = pkgs.writeShellApplication {
            name = "fmt";
            runtimeInputs = with pkgs; [ nixfmt ];
            text = ''
              nixfmt ./**/*.nix
              statix fix ${./.}
            '';
          };
        };

        checks = {
          fmt = pkgs.runCommand "fmt" {
            buildInputs = with pkgs; [ nixfmt statix ];
          } ''
            ${pkgs.nixfmt}/bin/nixfmt --check ${./.}/**/*.nix && \
            ${pkgs.statix}/bin/statix check ${./.}
          '';

        };

        devShell =
          pkgs.mkShell { buildInputs = with pkgs; [ git nixfmt statix ]; };
      }));
}
