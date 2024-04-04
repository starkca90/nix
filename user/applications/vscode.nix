{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      editorconfig.editorconfig

      # nix
      jnoortheen.nix-ide

      # devops
      redhat.ansible

    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-packer-powertools";
        publisher = "sztheory";
        version = "0.3.0";
        sha256 = "09ns4vv1x93rfq085yx90cjvn2fjag7bf2y0cdikn9v6yq8sfxd2";
      }

      {
        name = "opentofu";
        publisher = "gamunu";
        version = "0.1.1";
        sha256 = "1gw5bfbn3fysfzz7ys58zg1vm4kz60x2xm2w9kj7li3lz1b96w9h";
      }
    ];
  };
}
