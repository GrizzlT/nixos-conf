{ pkgs, ... }:
{
  home.packages = with pkgs; [
    filezilla
    gtkwave

    neovide
  ];
}
