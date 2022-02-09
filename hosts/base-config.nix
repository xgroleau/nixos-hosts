{ config, lib, pkgs, ... }:

{
  config = {

    nix = {
      package = pkgs.nixUnstable;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };

    services.xserver.layout = "ca";

    time.timeZone = "America/Toronto";

    users.users.xgroleau = {
      isNormalUser = true;
      initialPassword = "nixos";
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };
}
