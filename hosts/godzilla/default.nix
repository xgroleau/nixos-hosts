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

    environment.systemPackages = with pkgs; [ vim nano curl wget firefox ];

    networking = {
      hostName = "godzilla"; # Define your hostname.
      networkmanager.enable = true;
      interfaces.wlp3s0.useDHCP = true;
    };

    # Dualbooting, avoids time issues
    time.hardwareClockInLocalTime = true;

    services = {
      # Enable CUPS to print documents. Add driver if needed
      printing.enable = true;

      # Enable touchpad
      libinput.enable = true;

      xserver = {
        enable = true;
        displayManager.sddm.enable = true;
        desktopManager.plasma5.enable = true;
      };
    };

    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    system.stateVersion = "21.11";

  };
}
