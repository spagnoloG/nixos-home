{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "23.11";
  imports = [
    ./hyprland
    ./packages
    ./dunst
    ./kitty
    ./waybar
    ./zsh
    ./fuzzel
    ./gtk
    ./direnv
    ./kanshi
    ./git
    ./gammastep
    ./vscode
    ./tmux
    ./starship
    ./dconf
    ./nvim
    ./alacritty
    ./brave
  ];
}
