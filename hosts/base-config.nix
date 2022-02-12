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
        # For embedded
        extraRules = (builtins.readFile ../data/69-probe-rs.rules);
      };
    };

    time.timeZone = "America/Toronto";

    environment.systemPackages = with pkgs; [ vim nano curl wget firefox ];

    programs.zsh.enable = true;
    users.users.xgroleau = {
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
}
