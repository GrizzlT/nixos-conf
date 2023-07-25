let
  package = pkgs: pkgs.nixFlakes;
  extraOptions = ''
    experimental-features = nix-command flakes
  '';
  settings = {
    auto-optimise-store = true;
    builders-use-substitutes = true;
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      # "https://anyrun.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      # "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };
in
{
  home = { pkgs }: {
    package = package pkgs;
    inherit extraOptions settings;
  };
  system = { pkgs }: {
    package = package pkgs;
    inherit extraOptions settings;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
