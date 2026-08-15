{ config, ... }:

{
  home.username = "alpha";
  home.homeDirectory = "/home/alpha";

  # TODO: 分割
  programs.zsh.enable = true;

  xdg.configFile."niri/config.kdl".source = ./config.kdl;
  xdg.configFile."alacritty/alacritty.toml".source = ./alacritty.toml;
  xdg.configFile."quickshell/main/shell.qml".source = ./shell.qml;

  home.stateVersion = "26.05";

  # TODO: 分割
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "dev-hayato-shiina" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "${config.home.homeDirectory}/.ssh/dev-hayato-shiina-key";
        TCPKeepAlive = true;
        IdentitiesOnly = true;
      };
    };
  };

  home.file = {
    ".ssh/dev-hayato-shiina-key.pub" = {
      source = ./../../ssh/dev-hayato-shiina-key.pub;
    };
  };

  services.ssh-agent.enable = true;
}
