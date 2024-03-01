{ config, lib, inputs, pkgs, ... }:

{
  imports = [ ../../modules/home/default.nix ];
  config.modules = {
    dunst.enable = false;
    hyprland.enable = false;
    kitty.enable = false;
    packages.enable = true;
    waybar.enable = false;
    zsh.enable = true;
    fuzzel.enable = false;
    gtk.enable = false;
    direnv.enable = true;
    kanshi.enable = false;
    git.enable = true;
    gammastep.enable = false; # Doesn't work on hyprland
    vscode.enable = false;
    tmux.enable = true;
    starship.enable = true;
    dconf.enable = false;
    nvim.enable = true;
    alacritty.enable = false;
    brave.enable = false;
  };
}
