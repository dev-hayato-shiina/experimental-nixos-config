{ pkgs, ... }:

import ./common.nix {
  inherit pkgs;

  name = "gamma";
  extraGroups = [ "wheel" ];
}
