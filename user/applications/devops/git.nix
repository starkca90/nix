{ config, lib, pkgs, userSettings, ... }:

{
  programs.git = {
    enable = true;
    userName = userSettings.fullName;
    userEmail = userSettings.email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
