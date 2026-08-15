{ pkgs, inputs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in {
  imports = [
    ./hardware-configuration.nix
    ./modules/users
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      libgbm
    ];
  };

  time.timeZone = "Asia/Tokyo";

  console.keyMap = "jp106";

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        sansSerif = [ "Noto Sans CJK JP" "Noto Color Emoji" ];
        serif = [ "Noto Serif CJK JP" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
    ];
    fontDir.enable = true;
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    openFirewall = true;
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = true;
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };

  system.stateVersion = "26.05";

  environment.systemPackages = with pkgs; [
    inputs.quickshell.packages.${system}.default
    zsh
    git
    jq
    xwayland-satellite
    niri
    bitwarden-cli
    bitwarden-desktop
    alacritty
    neovim
  ];

  users.defaultUserShell = pkgs.zsh;
}
