{config, lib, pkgs, ...}:

{
  home.packages = ( with pkgs; [
    kubectl
    k9s
    # lens
  ]);
}
