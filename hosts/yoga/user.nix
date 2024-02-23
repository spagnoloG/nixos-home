{ config, lib, inputs, pkgs, ... }:

{
  imports = [ ../../modules/default.nix ];
  config.modules = {
    dunst.enable = true;
    hyprland.enable = true;
    kitty.enable = true;
    packages.enable = true;
    waybar.enable = true;
    zsh.enable = true;
    fuzzel.enable = true;
    gtk.enable = true;
    direnv.enable = true;
    kanshi.enable = true;
    git.enable = true;
    gammastep.enable = true;
    vscode.enable = true;
    tmux.enable = true;
    starship.enable = true;
    dconf.enable = true;
    nvim.enable = true;
  };
}
