{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    citrix_workspace
    graphviz

    onedriver
    rclone
  ];
}
