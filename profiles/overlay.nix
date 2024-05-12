self: super: {
  profiles = self.lib.makeScope self.newScope (self: {
    mkProfile = self.callPackage ./mk-profile.nix {};

    c = self.callPackage ./c.nix {};
    myDeploy = self.callPackage ./deploy.nix {};
    python = self.callPackage ./python.nix {};
    web = self.callPackage ./web.nix {};
    pwn = self.callPackage ./pwn.nix {};
    crypto = self.callPackage ./crypto.nix {};
    forensics = self.callPackage ./forensics.nix {};
    misc = self.callPackage ./misc.nix {};
    audio = self.callPackage ./audio.nix {};
    hardware = self.callPackage ./hardware.nix {};
    typescript = self.callPackage ./typescript.nix {};
    typst-profile = self.callPackage ./typst.nix {};
    vpn = self.callPackage ./vpn.nix {};
    games = self.callPackage ./games.nix {};

    primefac = ps: self.callPackage ./primefac.nix { pythonPackages = ps; };
    padding-oracle = ps: self.callPackage ./padding-oracle.nix { pythonPackages = ps; };
    rp = self.callPackage ./rp.nix {};
  });
}
