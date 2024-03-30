{ lib, config, pkgs, ... }:

with lib;
let cfg = config.modules.hyprland;

in {
  options.modules.hyprland = { enable = mkEnableOption "hyprland"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprpaper
      hyprland
      wl-clipboard
      hyprland-protocols
      wlogout
      swayidle
      wlsunset
    ];

    wayland.windowManager.hyprland = {
      extraConfig = ''
        plugin = ${hy3.packages.x86_64-linux.hy3}/lib/libhy3.so
      '';
    };

    home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    home.file.".config/hypr/wallpaper.png".source =
      ../../../pictures/wallpaper.png;
    home.file.".config/hypr/lock-wallpaper.png".source =
      ../../../pictures/lock-wallpaper.png;
  };
}
