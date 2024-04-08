{ lib, ... }:

{
  # Need some flatpaks
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  services.flatpak.remotes = lib.mkOptionDefault [{
    name = "flathub-beta";
    location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
  }];

  services.flatpak.update.auto.enable = false;
  services.flatpak.uninstallUnmanaged = false;
  services.flatpak.packages = [
    { appId = "org.remmina.Remmina"; origin = "flathub"; }
    { appId = "com.github.IsmaelMartinez.teams_for_linux"; origin = "flathub"; }
  ];
}
