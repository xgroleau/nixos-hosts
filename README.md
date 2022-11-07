# NixOS hosts configuration
> This repo is not maintained anymore. It was merged with [nix-dotfiles](https://github.com/xgroleau/nix-dotfiles) to ease host and configuraiton management. Seperating them was a bit pointless and added overhead when modifying configurations.

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

### Rodan
The free oracle A1 vm tier. For doing random projects.
