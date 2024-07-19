{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # General development
      eamodio.gitlens
      editorconfig.editorconfig
      esbenp.prettier-vscode
      ms-vscode.makefile-tools
      # github.copilot
      # ms-vscode-remote.remote-containers

      # Markdown
      davidanson.vscode-markdownlint

      # nix
      jnoortheen.nix-ide

      # devops
      redhat.ansible

      # Docker
      ms-azuretools.vscode-docker

      hashicorp.hcl

    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      #{
      #  name = "reflow-markdown";
      #  publisher = "marvhen";
      #  version = "2.1.0";
      #  sha256 = "1y99zry5ivwvw2imr376435q1g911aj4rzkh5x8h83rzlg9lgz2f";
      #}

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
        version = "1.23.1";
        sha256 = "1qyhm4cq5i2f1c17hy61bhr3h6ydg44s52ygqq6cga712mw951c5";
      }

      {
        name = "markdown-preview-github-styles";
        publisher = "bierner";
        version = "2.0.4";
        sha256 = "0p2iwc52id5616wcvhw7dcnjw190s36fc6vbma8cldncz33ab6wc";
      }

      #{
      #  name = "vscode-packer-powertools";
      #  publisher = "sztheory";
      #  version = "0.3.0";
      #  sha256 = "09ns4vv1x93rfq085yx90cjvn2fjag7bf2y0cdikn9v6yq8sfxd2";
      #}

      #{
      #  name = "opentofu";
      #  publisher = "gamunu";
      #  version = "0.2.1";
      #  sha256 = "1lip09r9618pk8id39yicxjs9blxwrw3vsizp18h1fw66hfxsb1s";
      #}
    ];

    userSettings = {
      # General editor config
      "editor.suggest.preview" = true;
      "editor.bracketPairColorization.enabled" = true;
      "editor.bracketPairColorization.independentPairColors" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.formatOnSaveMode" = "modificationsIfAvailable";
      "editor.guides.bracketPairs" = "true";
      "files.insertFinalNewline" = true;
      "files.trimTrailingWhitespace" = true;

      "files.watcherExclude" = {
        "**/.DS_Store" = true;
        "**/.site/**" = true;
        "**/.trunk/**" = true;
      };

      # Reflow Markdown
      "reflowMarkdown.preferredLineLength" = 100;
      "reflowMarkdown.wrapLongLinks" = "wrap";

      # nix-ide
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";

      # Opentofu
      "opentofu.experimentalFeatures.prefillRequiredFields" = true;
      "opentofu.languageServer.path" = "terraform-ls";
      "opentofu.languageServer.opentofu.path" = "/run/current-system/sw/bin/tofu";


      # File formatting
      "[json]" = {
        "editor.defaultFormatter" = "vscode.json-language-features";
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;
        "editor.trimAutoWhitespace" = true;
      };
      "[md]" = {
        "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = false;
        "editor.formatOnType" = true;
        "editor.trimAutoWhitespace" = true;
        "editor.wordWrap" = "bounded";
        "editor.wordWrapColumn" = 100;
        "editor.rulers" = [ 100 ];
      };
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
