{ config, pkgs, ... }:

{
  imports = [
    ../../modules/system/nvidia/default.nix
    ../../modules/system/laptop/default.nix
  ];
}
