# Adds support for Appimage and registers Appimage's Magic number
# to allow Appimages to be invoked directly (without launching
# via appimage-run)

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    appimage-run
  ];

  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };
}
