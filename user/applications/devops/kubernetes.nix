{config, lib, pkgs, pkgs-starkca90 , ...}:

{
  home.packages = ( with pkgs; [
    kubectl
    k9s
    pkgs-starkca90.lens
  ]);
}