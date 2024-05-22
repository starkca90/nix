{ pkgs, ... }:

{
  imports =
  [
    # ./ucap.nix
  ];

  environment.systemPackages = with pkgs; [
    openconnect
  ];
}
