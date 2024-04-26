{pkgs, ...}:

{
  home.packages = ( with pkgs; [
    kubectl
    (wrapHelm kubernetes-helm { plugins = [ kubernetes-helmPlugins.helm-secrets kubernetes-helmPlugins.helm-diff ]; })
    k9s
    lens
  ]);
}
