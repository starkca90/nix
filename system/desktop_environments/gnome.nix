{pkgs, ...}:

{
  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
      '';
    };

    xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    epiphany
    geary
  ]) ++ (with pkgs.gnome; [
    tali
    iagno
    hitori
    atomix
  ]);

  environment.systemPackages =  with pkgs; [
    gnomeExtensions.toggle-alacritty
    gnomeExtensions.tailscale-status
  ];
}
