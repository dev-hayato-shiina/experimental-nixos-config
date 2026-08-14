{ ... }:

{
  home.username = "alpha";
  home.homeDirectory = "/home/alpha";

  xdg.configFile."niri/config.kdl".source = ./config.kdl;
  xdg.configFile."alacritty/alacritty.toml".source = ./alacritty.toml;
  xdg.configFile."quickshell/main/shell.qml".source = ./shell.qml;

  home.stateVersion = "26.05";
}
