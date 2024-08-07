{ lib, ...}:

{
  imports = [
    ./keys.nix
  ];

home.file.".ssh/config" = {
  target = ".ssh/config_source";
  onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config'';
};

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

      "vg" = lib.hm.dag.entryBefore ["*.caseystark.com"] {
        user = "cisco";
        hostname = "172.16.50.15";
        extraOptions = {
          PubkeyAuthentication = "no";
          PreferredAuthentications = "password";
        };
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
