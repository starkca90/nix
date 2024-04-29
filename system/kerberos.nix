{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kerberos
  ];
}
