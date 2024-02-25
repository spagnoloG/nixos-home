{ config, pkgs, ... }:

{
  imports =
    [ ../../modules/nvidia/default.nix ../../modules/laptop/default.nix ];
}
