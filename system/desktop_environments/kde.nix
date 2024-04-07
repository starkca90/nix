{ pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;

  services.xserver = {
    enable = true;
    displayManager = {
      defaultSession = "plasma";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };

  };

  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   plasma-browser-integration
  #   konsole
  #   oxygen
  # ];
}
