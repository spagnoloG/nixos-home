{ config, lib, inputs, pkgs, ... }:

{
  imports = [ ../../modules/home/default.nix ];
  config.modules = {
    dunst.enable = false;
    hyprland.enable = true;
    kitty.enable = true;
    packages.enable = true;
    waybar.enable = true;
    zsh.enable = true;
    fuzzel.enable = true;
    gtk.enable = true;
    direnv.enable = true;
    kanshi.enable = false; # currently bugged on hyprland
    git.enable = true;
    gammastep.enable = false; # Doesn't work on hyprland
    vscode.enable = true;
    tmux.enable = true;
    starship.enable = true;
    dconf.enable = true;
    nvim.enable = true;
    alacritty.enable = true;
    brave.enable = true;
  };
}
