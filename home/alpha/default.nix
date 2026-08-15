{ config, ... }:

{
  home.username = "alpha";
  home.homeDirectory = "/home/alpha";

  xdg.configFile."niri/config.kdl".source = ./config.kdl;
  xdg.configFile."alacritty/alacritty.toml".source = ./alacritty.toml;
  xdg.configFile."quickshell/main/shell.qml".source = ./shell.qml;

  home.stateVersion = "26.05";

  # TODO: 分割
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "dev-hayato-shiina" = {
        hostname = "github.com";
        user = "git";
        identityFile = "${config.home.homeDirectory}/.ssh/dev-hayato-shiina-key";
        extraOptions = {
          TCPKeepAlive = "yes";
          IdentitiesOnly = "yes";
        };
      };
      "sheena-develop" = {
        hostname = "github.com";
        user = "git";
        identityFile = "${config.home.homeDirectory}/.ssh/sheena-develop-key";
        extraOptions = {
          TCPKeepAlive = "yes";
          IdentitiesOnly = "yes";
        };
      };
    };
  };

  home.file = {
    ".ssh/dev-hayato-shiina-key.pub" = {
      source = ./../../ssh/dev-hayato-shiina-key.pub;
    };
    ".ssh/sheena-develop-key.pub" = {
      source = ./../../ssh/sheena-develop-key.pub;
    };
  };
}
