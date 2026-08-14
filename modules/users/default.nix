{ ... }:

{
  imports = [
    ./alpha.nix
    ./beta.nix
    ./gamma.nix
  ];

  services.openssh.settings.AllowUsers = [
    "alpha"
    "beta"
    "gamma"
  ];
}
