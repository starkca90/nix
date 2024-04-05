{pkgs, ...}:

{
  environment.systemPackages = (with pkgs; [
    # Image creation (Packer)
    packer

    # Infrastructure as code (Terraform/OpenTofu)
    opentofu
    terraform-ls

    # Automation (Ansible)
    ansible
    ansible-lint

    gnumake
  ]);
}
