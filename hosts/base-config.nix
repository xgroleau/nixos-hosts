{ config, lib, pkgs, ... }:

{
  config = {

    nixpkgs.config.allowUnfree = true;
    nix = {
      package = pkgs.nixUnstable;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };

    services = {
      xserver.layout = "ca";
      udev = {
        packages = with pkgs;
          [
            # For embedded
            stlink
          ];
        extraRules = (builtins.readFile ../data/69-probe-rs.rules);
      };
    };

    time.timeZone = "America/Toronto";

    programs.zsh.enable = true;
    users.users.xgroleau = {
      isNormalUser = true;
      shell = pkgs.zsh;
      initialPassword = "nixos";
      extraGroups = [
        "wheel"
        "networkmanager"

        # For embedded development
        "plugdev"
        "dialout"
      ];
    };
  };
}
