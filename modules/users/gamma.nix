{ ... }:

import ./common.nix {
  name = "gamma";
  extraGroups = [ "wheel" ];
}
