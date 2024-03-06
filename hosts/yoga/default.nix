{ config, pkgs, lib, inputs, ... }:

{
  imports = [ ../../modules/system/default.nix ];
  config.modules = {
    laptop.enable = false;
    nvidia.enable = false;
  };

}
