{ pkgs, pkgs-stable, ... }:

{
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
      };
    };
    spiceUSBRedirection.enable = true;
  };

  environment.systemPackages = with pkgs; [

    virtio-win
    pkgs-stable.looking-glass-client

    zenity
  ];

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 1000 qemu-libvirtd -"
  ];

}
