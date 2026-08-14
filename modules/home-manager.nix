{ ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users = {
      alpha = import ../home/alpha;
      beta = import ../home/beta;
      gamma = import ../home/gamma;
    };
  };
}
