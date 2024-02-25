{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "23.11";
  imports = [
    ./home/hyprland
    ./home/packages
    ./home/dunst
    ./home/kitty
    ./home/waybar
    ./home/zsh
    ./home/fuzzel
    ./home/gtk
    ./home/direnv
    ./home/kanshi
    ./home/git
    ./home/gammastep
    ./home/vscode
    ./home/tmux
    ./home/starship
    ./home/dconf
    ./home/nvim
    ./home/alacritty
    ./home/brave
  ];
}
