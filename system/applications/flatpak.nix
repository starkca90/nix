{ lib, ... }:

{
  services.flatpak = {
    enable = true;
    update.auto.enable = true;
    uninstallUnmanaged = false;

    remotes = lib.mkOptionDefault [{
      name = "flathub-beta";
      location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    }];

    packages = [
      { appId = "org.remmina.Remmina"; origin = "flathub"; }
      { appId = "io.github.mahmoudbahaa.outlook_for_linux"; origin = "flathub"; }
      { appId = "com.github.IsmaelMartinez.teams_for_linux"; origin = "flathub"; }
      { appId = "org.gnome.World.PikaBackup"; origin = "flathub"; }
      { appId = "com.usebottles.bottles"; origin = "flathub"; }
    ];
  };

  xdg.portal.enable = true;

}
