{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../base-config.nix
  ];

  config = {
    # Use the systemd-boot EFI boot loader.
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };

    networking = {
      hostName = "mothra"; # Define your hostname.
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      interfaces.enp0s25.useDHCP = true;
    };

    # Dualbooting, avoids time issues
    time.hardwareClockInLocalTime = true;
    # Enable the X11 windowing system.
    services = {
      xserver = {
        enable = true;
        # Enable the Plasma 5 Desktop Environment.
        displayManager.sddm.enable = true;
        desktopManager.plasma5.enable = true;
      };
    };

    services.printing.enable = true;

    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    system.stateVersion = "21.11";
  };
}
