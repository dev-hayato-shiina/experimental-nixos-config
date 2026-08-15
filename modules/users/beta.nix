{ pkgs, ... }:

import ./common.nix {
  inherit pkgs;

  name = "beta";
  extraGroups = [ "wheel" ];
}
