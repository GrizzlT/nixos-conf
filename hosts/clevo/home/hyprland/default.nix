{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    recommendedEnvironment = true;
    extraConfig = "source=~/.config/hypr/grizz/hyprland.conf";
  };

  home.file.".config/hypr/grizz" = {
    source = ./hypr-conf;
    recursive = true;
  };
}