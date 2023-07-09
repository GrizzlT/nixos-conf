{ pkgs, ... }:
let
    configPath = ".config/wezterm/grizz";
in
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local myConfig = require('grizz')
      local config = {}
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end
      myConfig.apply_to_config(config)
      return config
    '';
    colorSchemes.snazzy = {
      foreground = "#eff0eb";
      background = "#282a36";
      cursor_fg = "#282a36";
      cursor_bg = "#97979b";
      cursor_border = "#97979b";
      selection_fg = "#282a36";
      selection_bg = "#feffff";
      ansi = [
        "#282a36" "#ff5c57" "#5af78e" "#f3f99d"
        "#57c7ff" "#ff6ac1" "#9aedfe" "#f1f1f0"
      ];
      brights = [
        "#686868" "#ff5c57" "#5af78e" "#f3f99d"
        "#57c7ff" "#ff6ac1" "#9aedfe" "#eff0eb"
      ];
      tab_bar = {
        background = "#282a36";
        active_tab = { bg_color = "#282a36"; fg_color = "#dcc7a0"; };
        inactive_tab = { bg_color = "#282a36"; fg_color = "#7C7D83"; };
        inactive_tab_hover = { bg_color = "#282a36"; fg_color = "#7C7D83"; };
        new_tab = { bg_color = "#282a36"; fg_color = "#7C7D83"; };
        new_tab_hover = { bg_color = "#282a36"; fg_color = "#7C7D83"; };
      };
    };
  };

  home.file."${configPath}" = {
    source = ./wez-conf;
    recursive = true;
  };
}
