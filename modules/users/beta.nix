{ ... }:

import ./common.nix {
  name = "beta";
  extraGroups = [ "wheel" ];
}
