{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.dconf;

in {
  options.modules.dconf = { enable = mkEnableOption "dconf"; };
  config = mkIf cfg.enable {

    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
}
