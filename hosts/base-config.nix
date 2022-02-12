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
      udev = {
        packages = with pkgs; [
          # For embedded
          stlink
          openocd
        ];
      };
    };

    time.timeZone = "America/Toronto";

    environment.systemPackages = with pkgs; [ vim nano curl wget firefox ];

    programs.zsh.enable = true;
    users = {
      extraGroups.networkmanager = { };
      users.xgroleau = {
        isNormalUser = true;
        shell = pkgs.zsh;
        initialPassword = "nixos";
        extraGroups = [
          "wheel"

          "audio"
          "networkmanager"

          # For embedded development
          "plugdev"
          "dialout"
        ];
      };
    };
  };
}
