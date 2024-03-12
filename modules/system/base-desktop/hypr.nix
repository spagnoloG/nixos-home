{ config, pkgs, inputs, lib, user, hostname, ... }:

{
  programs.hyprland = { xwayland.enable = true; };
  xdg = {
    icons.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };
  };
}
