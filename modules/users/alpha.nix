{ pkgs, ... }:

import ./common.nix {
  inherit pkgs;

  name = "alpha";
  extraGroups = [ "wheel" ];
}
