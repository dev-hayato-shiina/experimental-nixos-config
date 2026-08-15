{ ... }:

{
  home.username = "gamma";
  home.homeDirectory = "/home/gamma";

  xdg.configFile."niri/config.kdl".source = ./config.kdl;
  xdg.configFile."alacritty/alacritty.toml".source = ./alacritty.toml;
  xdg.configFile."quickshell/shell.qml".source = ./shell.qml;

  home.stateVersion = "26.05";
}
