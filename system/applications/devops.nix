{pkgs, ...}:

{
  environment.systemPackages = (with pkgs; [
    # Image creation (Packer)
    packer

    # Infrastructure as code (Terraform/OpenTofu)
    opentofu

    # Automation (Ansible)
    ansible
    ansible-lint

    gnumake
  ]);
}
