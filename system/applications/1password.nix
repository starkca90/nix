{ pkgs, userSettings, ... }:

let
  package = pkgs._1password-gui-beta;

in
{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    inherit package;
    polkitPolicyOwners = [ userSettings.username ];
  };
}
