# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, pkgs-stable, pkgs-starkca90 , nixos-hardware, systemSettings, userSettings, modulesPath, ... }:

{
  imports =
    [
      (import  ../../hardware/${systemSettings.hardware}.nix { inherit config lib pkgs pkgs-starkca90 modulesPath nixos-hardware; })
      # ../../system/kerberos.nix
      ../../system/nix-optimizations.nix
      ../../system/certificates.nix
      ../../system/pam.nix
      ../../system/tailscale.nix
      ../../system/desktop_environments/gnome.nix
      ../../system/applications/devops.nix
      ../../system/applications/appimage.nix
      ../../system/applications/flatpak.nix
      ../../system/applications/1password.nix
      ../../system/applications/citrix.nix
      ../../system/applications/gaming.nix
      ../../system/docker.nix
      (import ../../system/virtualization.nix { inherit pkgs pkgs-stable; })
      # ../../system/applications/messaging.nix
    ];

  # Use the latest linux kernel
  boot.kernelPackages = pkgs-starkca90.linuxPackages_latest;

  # Apparently doing this in pkgs isn't enough
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot = {
    # Common kernel modules
    kernelModules = [ "i2c-dev" "i2c-piix4" "cpufreq_powersave" ];
    plymouth.enable = true;
    loader = {
      efi.canTouchEfiVariables = if (systemSettings.bootMode == "uefi") then true else false;
      grub = {
        enable = true;
        configurationLimit = 6;
        device = systemSettings.grubDevice;
        efiSupport = if (systemSettings.bootMode == "uefi") then true else false;
        useOSProber = true;
      };
    };
  };

  # Networking
  networking.hostName = systemSettings.hostname; # Define your hostname.
  networking.networkmanager.enable = true; # Use networkmanager

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      # Packer build ports
      { from = 8000; to = 8010; }
    ];
  };

  # Timezone and locale
  time.timeZone = systemSettings.timezone; # time zone

  i18n.defaultLocale = systemSettings.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };


  ## TODO: Move these to their own modules

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.dconf.enable = true;
  ## TODO END


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # User account
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.fullName;
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    packages = [ ];
    uid = 1000;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # System Applications
    aha
    clinfo
    glxinfo
    vulkan-tools
    wayland-utils

    openssl
    vim
    wget
    home-manager
    git
    nixd
    nixpkgs-fmt
    zsh

    thunderbird
  ];

  # Set ZSH as default shell
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
