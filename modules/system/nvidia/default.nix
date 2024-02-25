{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.nvidia;

in {
  options.modules.nvidia = { enable = mkEnableOption "nvidia"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
      libva-utils
      cudatoolkit
    ];

    # Enable OpenGL
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    hardware.nvidia = {
      nvidiaSettings = true;
      modesetting.enable = true;
      nvidiaPersistenced = true;
      open = false;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

  };

}

