# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, systemSettings, lib, pkgs, modulesPath, nixos-hardware, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      (nixos-hardware + "/framework/16-inch/7040-amd")
    ];

  nixpkgs.hostPlatform = lib.mkDefault systemSettings.system;

  boot = {

    # extraModprobeConfig = "options vfio-pci ids=1002:7480,1002:ab30";
    extraModulePackages = with config.boot.kernelPackages; [ kvmfr ];

    initrd = {

      availableKernelModules = [
        "amdgpu"
        "nvme"
        "xhci_pci"
        "thunderbolt"
        "usbhid"
        "usb_storage"
        "uas"
        "sd_mod"
        "pci_stub"
        # "vfio"
        # "vfio-pci"
        # "vfio_iommu_type1"
      ];

      kernelModules = [
        # "vfio"
        # "vfio-pci"
        # Order matters. vfio needs to come before amdgpu
        # Else GPU will grab PCI device before it can be set for vfio-pci passthru
        "amdgpu"
      ];

      # preDeviceCommands = ''
      #   DEVS="0000:03:00.0 0000:03:00.1"
      #   for DEV in $DEVS; do
      #     echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
      #   done
      #   modprobe -i vfio-pci
      # '';
    };

    kernelModules = [
      "kvm-amd"
      "pci_stub"
      # "vfio_pci"
      # "vfio"
      # "vfio_iommu_type1"
      "kvmfr"
    ];

    kernelParams = [
      "iommu=pt"
      "amd_iommu=on"
      # "vfio-pci.ids=1002:7480,1002:ab30"
      # "pci-stub.ids=1002:7480,1002:ab30"
      "mem_sleep_default=deep"
    ];

  };

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    sensor.iio.enable = false;

    opengl = {
      driSupport32Bit = true;
      enable = true;
      extraPackages = with pkgs; [
        amdvlk
        libva
        libvdpau
        libvdpau-va-gl
        vaapiVdpau
      ];

      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
  };

  # Fingerprint Sensor
  services.fprintd = {
    enable = lib.mkForce false;
    package = pkgs.fprintd.overrideAttrs {
      mesonCheckFlags = [
        "--no-suite"
        "fprintd:TestPamFprintd"
      ];
    };
  };

  # TODO Move to seperate moduele ???
  # DHCP by default
  networking.useDHCP = lib.mkDefault true;

  # Firmware and microcode
  services.fwupd.enable = true;

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/3e95bfab-f94f-4ba2-bfbc-16343f0509c2";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  boot.initrd.luks.devices."crypted".device = "/dev/disk/by-uuid/82ff8ec6-cfa4-4c21-94b6-5343dc48f5e3";

  fileSystems."/.swapvol" =
    {
      device = "/dev/disk/by-uuid/3e95bfab-f94f-4ba2-bfbc-16343f0509c2";
      fsType = "btrfs";
      options = [ "subvol=swap" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/30A1-2339";
      fsType = "vfat";
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/3e95bfab-f94f-4ba2-bfbc-16343f0509c2";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/3e95bfab-f94f-4ba2-bfbc-16343f0509c2";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };
  # END TODO
}
