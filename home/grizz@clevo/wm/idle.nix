{ pkgs, inputPkgs, ... }: let
  hyprland = inputPkgs.hyprland.hyprland;
in {
  programs.swaylock = {
    enable = true;
    settings = {
      show-failed-attempts = true;
      show-keyboard-layout = true;
    };
  };

  services.swayidle = {
    # enable = true;
    extraArgs = [ "-w" ];
    systemdTarget = "hyprland-session.target";
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
    ];
    timeouts = [
      {
        timeout = 180;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        timeout = 360;
        command = "${hyprland}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];
  };
}