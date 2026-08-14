{ ... }:

import ./common.nix {
  name = "alpha";
  extraGroups = [ "wheel" ];
}
