{pkgs, ...}:

{
  imports = [
    ./python.nix
  ];

  environment.systemPackages = (with pkgs; [
    # Image creation (Packer)
    packer
    xorriso
    jq

    # Infrastructure as code (Terraform/OpenTofu)
    opentofu
    terraform-ls

    # Automation (Ansible)
    # ansible <- Installed in python.nix
    ansible-lint

    gnumake
  ]);
}
