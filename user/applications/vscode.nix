{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # General development
      editorconfig.editorconfig
      ms-vscode.makefile-tools

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

    userSettings = {
      # General editor config
      "editor.suggest.preview" = true;

      # nix-ide
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";

      # Opentofu
      "opentofu.experimentalFeatures.prefillRequiredFields" = true;
      "opentofu.languageServer.path" = "terraform-ls";
      "opentofu.languageServer.opentofu.path" = "/run/current-system/sw/bin/tofu";


      # File formatting
      "[terraform]" = {
        "editor.defaultFormatter" = "gamunu.opentofu";
        "editor.formatOnSave" = true;
        "editor.formatOnSaveMode" = "file";
      };
      "[terraform-vars]" = {
        "editor.defaultFormatter" = "gamunu.opentofu";
        "editor.formatOnSave" = true;
        "editor.formatOnSaveMode" = "file";
      };
    };
  };
}
