{ config, lib, pkgs, nix-dotfiles, ... }:

with lib;
with lib.my.option;
let cfg = config.modules.home;
in {

  options.modules.home = with types; {
    profile = mkOpt {
      type = nullOr str;
      default = null;
      description = ''
        The name of the home nix-dotfiles
      '';
    };
    username = mkOpt {
      type = nullOr str;
      default = null;
      description = ''
        The username of the home nix-dotfiles
      '';
    };
  };

  imports = mkIf (cfg.profile != null) [
    (nix-dotfiles.utils.core.nixosConfigurationFromProfile {
      username = cfg.username;
      profile = nix-dotfiles.profiles."${cfg.profile}";
    })
  ];
}
