{
  description = "My nixos configurations";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-dotfiles = {
      url = "github:xgroleau/nix-dotfiles/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nix-dotfiles, flake-utils, ... }:
    let
      hosts = import ./hosts;

      lib = nixpkgs.lib.extend (self: super: { my = nix-dotfiles.utils; });
    in {
      nixosConfigurations = lib.mapAttrs (hostName: hostConfig:
        nixpkgs.lib.nixosSystem {
          inherit (hostConfig) system;
          specialArgs = {
            inherit lib;
            inherit nix-dotfiles;
          };
          modules = [ hostConfig.cfg ./modules ];
        }) hosts;
    }

    # Utils of each system
    // (flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        apps = {
          fmt = let
            app = pkgs.writeShellApplication {
              name = "fmt";
              runtimeInputs = with pkgs; [ nixfmt statix ];
              text = ''
                nixfmt ./**/*.nix
                statix fix ./.
              '';
            };
          in {
            type = "app";
            program = "${app}/bin/${app.name}";
          };
        };

        checks = {
          # TODO: Fix check
          fmt = pkgs.runCommand "fmt" {
            buildInputs = with pkgs; [ nixfmt statix ];
          } ''
            ${pkgs.nixfmt}/bin/nixfmt --check ${./.}/**/*.nix && \
            ${pkgs.statix}/bin/statix check ${./.} && \
            touch $out
          '';

        };

        devShell =
          pkgs.mkShell { buildInputs = with pkgs; [ git nixfmt statix ]; };
      }));
}
