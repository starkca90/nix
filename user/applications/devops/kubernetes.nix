{config, lib, pkgs, pkgs-starkca90 , ...}:

{
  home.packages = ([
    pkgs.kubectl
    pkgs-starkca90.lens
  ]);
}