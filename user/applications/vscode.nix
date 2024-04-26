{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # General development
      eamodio.gitlens
      editorconfig.editorconfig
      ms-vscode.makefile-tools
      github.copilot

      # nix
      jnoortheen.nix-ide

      # devops
      redhat.ansible

      # Docker
      ms-azuretools.vscode-docker

    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "markdown-checkbox";
        publisher = "bierner";
        version = "0.4.0";
        sha256 = "0jbfi0av84ixwhcpysh9gyrsfxpy65igiidrdarn7vgsvxsdr0q2";
      }

      {
        name = "markdown-emoji";
        publisher = "bierner";
        version = "0.3.0";
        sha256 = "0llmgk3rwcslqfnqp7xgvrqjqly3hvisahzmi0p49wn0w0fky3xg";
      }

      {
        name = "markdown-mermaid";
        publisher = "bierner";
        version = "1.22.0";
        sha256 = "1ii6slnmj5ck40mdnixbybqjqbmqg7wl7yqw66p31wsnpqk71q28";
      }

      {
        name = "markdown-preview-github-styles";
        publisher = "bierner";
        version = "2.0.4";
        sha256 = "0p2iwc52id5616wcvhw7dcnjw190s36fc6vbma8cldncz33ab6wc";
      }

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
