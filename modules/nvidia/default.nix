{ config, pkgs, lib, ... }: {

  environment.systemPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
    libva-utils
    cudatoolkit
  ];

  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaPersistenced = true;
  hardware.nvidia.powerManagement = {
    enable = false;
    finegrained = false;
  };

}
