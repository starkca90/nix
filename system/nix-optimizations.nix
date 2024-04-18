{pkgs, ...}:

{
  nix.optimise.automatic = true;

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/stark/.dotfiles";
  };
}
