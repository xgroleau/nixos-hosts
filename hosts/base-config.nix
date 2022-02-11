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
      udev.packages = with pkgs;
        [
          # For embedded
          stlink
        ];
    };

    time.timeZone = "America/Toronto";

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
