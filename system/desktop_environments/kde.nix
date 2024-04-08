{ pkgs, ... }:

{
  # services.desktopManager.plasma6.enable = true;

  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;
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

  security.pam.services.kwallet = {
    name = "kwallet";
    enableKwallet = true;
  };

  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   plasma-browser-integration
  #   konsole
  #   oxygen
  # ];
}
