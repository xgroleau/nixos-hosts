# NixOS hosts configuration
The configurations for to manage my different hosts on NixOS.

This uses my [Nix dotfiles](https://github.com/xgroleau/nix-dotfiles) to manage user configurations.

## Installation

Simply run the command with flakes enabled
 ```sh
 sudo nixos-rebuild switch --flake .#<host>
 ``` 

## Hosts

### Godzilla
My old Ideapad Y580 from 2012. A thick boy but still fully functionning. NixOS gave it a breath of fresh air. 

### Mothra
My main tower for development, work and games.
