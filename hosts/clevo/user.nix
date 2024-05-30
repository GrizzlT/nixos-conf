{ pkgs, lib, config, ... }:
let
  user = config.grizz.settings.user;
in
{
  grizz.settings.user = lib.mkDefault "grizz";

  users.mutableUsers = false;
  users.users.${user} = {
    hashedPasswordFile = "/persist/users/${user}/passwordFile";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" "wireshark" ];
    packages = [ pkgs.home-manager ];
    shell = pkgs.fish;
  };

  programs.light.enable = true;

  # My window manager of choice
  programs.hyprland = {
    enable = true;
  };

  # Necessary for swaylock
  environment.etc."pam.d/swaylock".text = ''auth include login'';

  # Gaming
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  # Shell
  programs.zsh.enable = true;
  programs.fish.enable = true;
}
