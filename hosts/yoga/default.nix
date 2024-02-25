{ config, pkgs, lib, inputs, ... }:

{
  imports = [ ../../modules/system/default.nix ];
  config.modules = {
    laptop.enable = true;
    nvidia.enable = true;
  };

}
