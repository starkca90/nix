{pkgs, ...}:

{
  imports = [
    # ./python.nix
  ];

  environment.systemPackages = (with pkgs; [
    # Image creation (Packer)
    packer
    xorriso
    jq

    # Infrastructure as code (Terraform/OpenTofu)
    opentofu
    terraform-ls

    # Automation (Ansible) (Moved to shell.nix in Project directory... Couldn't get pywinrm to work correctly at the system level)
    # ansible
    # ansible-lint
    # (python3.withPackages(ps: [ ps.ansible ps.pip ps.requests ps.pywinrm]))

    gnumake
  ]);
}
