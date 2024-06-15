{ pkgs, ... }:

{
  services.onedrive.enable = true;

  environment.systemPackages = with pkgs; [
    onedrive
    onedrivegui
    gnomeExtensions.onedrive
  ];
}
