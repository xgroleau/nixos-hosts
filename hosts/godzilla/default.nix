{ config, pkgs, ... }:

{
  imports = [ ../base-config.nix ./hardware-configuration.nix ];

  config = {
    # Use the systemd-boot EFI boot loader.
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };

    networking = {
      hostName = "godzilla"; # Define your hostname.
      networkmanager.enable = true;
      interfaces.wlp3s0.useDHCP = true;
    };

    environment.systemPackages = with pkgs; [ pavucontrol ];

    # Dualbooting, avoids time issues
    time.hardwareClockInLocalTime = true;

    services = {
      # Enable CUPS to print documents. Add driver if needed
      printing.enable = true;

      xserver = {
        enable = true;
        displayManager.sddm.enable = true;
        desktopManager.plasma5.enable = true;

        # Enable touchpad
        libinput.enable = true;
      };
    };

    # Enable sound.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    system.stateVersion = "21.11";

  };
}
