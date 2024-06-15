{ lib, ...}:

{
  imports = [
    ./keys.nix
  ];

  programs.ssh = {
    enable = true;
    matchBlocks = {

      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github_personal.pub";
        identitiesOnly = true;
      };

      "github-personal" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github_personal.pub";
        identitiesOnly = true;
      };

      "github-cdw" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github_cdw.pub";
        identitiesOnly = true;
      };

      "pfsense.caseystark.com" = lib.hm.dag.entryBefore ["*.caseystark.com"] {
        user = "admin";
        identityFile = "~/.ssh/casey.pub";
        identitiesOnly = true;
      };

      "gitlab.caseystark.com" = lib.hm.dag.entryBefore ["*.caseystark.com"] {
        user = "git";
        identityFile = "~/.ssh/casey.pub";
        identitiesOnly = true;
      };

      "nas.caseystark.com" = lib.hm.dag.entryBefore ["*.caseystark.com"] {
        user = "casey";
        identityFile = "~/.ssh/casey.pub";
        identitiesOnly = true;
      };

      "vcenter.caseystark.com" = lib.hm.dag.entryBefore ["*.caseystark.com"] {
        user = "root";
        extraOptions = {
          PubkeyAuthentication = "no";
          PreferredAuthentications = "password";
        };
      };

      "esxi*.caseystark.com" = lib.hm.dag.entryBefore ["*.caseystark.com"] {
        user = "root";
        extraOptions = {
          PubkeyAuthentication = "no";
          PreferredAuthentications = "keyboard-interactive";
        };
      };

      "k8s-rancher-*.caseystark.com" = lib.hm.dag.entryBefore ["*.caseystark.com"] {
        user = "casey";
        identityFile = "~/.ssh/casey.pub";
        identitiesOnly = true;
      };

      "*.caseystark.com" = {
        user = "ansible";
        identityFile = "~/.ssh/ansible.pub";
        identitiesOnly = true;
      };

    };
  };
}
