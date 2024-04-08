{
  description = "starkca90's Main Flake";

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, nixos-hardware, nix-flatpak, home-manager, nixd, ... }:
    let

      systemSettings = {
        system = "x86_64-linux"; # system arch
        hardware = "framework16"; # Platform installing onto (determines hardware-configuration.nix)
        hostname = "framework16"; # hostname
        profile = "personal"; # select a profile defined from my profiles directory
        timezone = "America/Chicago"; # select timezone
        locale = "en_US.UTF-8"; # select locale
        bootMode = "uefi"; # uefi or bios
        bootMountPath = "/boot"; # mount path for efi boot partition; only used for uefi boot mode
        grubDevice = "nodev"; # device identifier for grub; only used for legacy (bios) boot mode
        partitionFormat = "luks-btrfs"; # Define the partition table layout TODO
      };

      userSettings = {
        fullName = "Casey Stark";
        username = "stark";
        email = "stark@caseystark.com";
        dotfilesDir = "~/.dotfiles";
        de = "gnome"; # Selected desktop environment (or window manager)
        browser = "brave";
        editor = "code";
        easyeffects = true;
        easyeffectsprofile = "Framework16";
      };

      pkgs = import nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
        overlays = [
          (import overlays/kubectl.nix)
        ];
      };

      pkgs-stable = import nixpkgs-stable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      lib = nixpkgs.lib;
    in {
      homeConfigurations = {
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
            nix-flatpak.homeManagerModules.nix-flatpak
          ];
          extraSpecialArgs = {
            inherit pkgs-stable;
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };

      nixosConfigurations = {
        system = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
            nix-flatpak.nixosModules.nix-flatpak
          ];
          specialArgs = {
            inherit pkgs-stable;
            inherit nixos-hardware;
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };
    };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nixos-hardware.url = "nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixd.url = "github:nix-community/nixd";
  };
}
