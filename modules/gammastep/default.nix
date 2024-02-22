{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.gammastep;

in {
  options.modules.gammastep = { enable = mkEnableOption "gammastep"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ gammastep ];

    services.gammastep = {
      enable = true;
      provider = "manual";
      latitude = 46.0569;
      longitude = 14.5058;
      tray = true;
      temperature.night = 4500;
    };

  };
}
