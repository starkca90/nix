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
  ]) ++ (with pkgs.gnome; [
    epiphany
    geary
    tali
    iagno
    hitori
    atomix
  ]);
}
