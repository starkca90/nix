{ pkgs, ... }:

{
  home.file = {
    ".ssh/ansible.pub".source = ./keys/ansible.pub;
    ".ssh/casey.pub".source = ./keys/casey.pub;
    ".ssh/github_cdw.pub".source = ./keys/github_cdw.pub;
    ".ssh/github_personal.pub".source = ./keys/github_personal.pub;
  };
}
