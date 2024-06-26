{ config, inputs, pkgs, commonDir, unstable, ... }:

{
  # Don't pipe stuff like nix-store output (which is frequently a single line) through a pager.
  # NB: this doesn't actually use cat(1); nix checks specifically for the string "cat" and disables the pager in that case.
  home.sessionVariables.NIX_PAGER = "cat";

  nix.registry = {
    nixpkgs.flake = inputs.nixpkgs;
    nixpkgs-unstable.flake = inputs.nixpkgs-unstable;
  };

  nixpkgs.config = import (commonDir + "/nixpkgs/config.nix");
  xdg.configFile."nixpkgs/config.nix".source = commonDir
    + "/nixpkgs/config.nix";

  nixpkgs.overlays = import (commonDir + "/nixpkgs/overlays.nix") {
    inherit unstable;
    here = commonDir + "/common/nixpkgs";
  };
  xdg.configFile."nixpkgs/overlays.nix".text = let
    inherit (pkgs.lib) hasPrefix removePrefix;
    inherit (pkgs.lib.strings) escapeNixString;
    raw = builtins.readFile (commonDir + "/nixpkgs/overlays.nix");
    prefix = ''
      { unstable, here }:
    '';
    processed = assert hasPrefix prefix raw; removePrefix prefix raw;
  in ''
    # TODO: work out how to get (applicable) overlays registered with this instance of nixpkgs-unstable
    let unstable = import ${
      escapeNixString (toString inputs.nixpkgs-unstable)
    } { system = ${escapeNixString pkgs.system}; config = import ${
      config.xdg.configFile."nixpkgs/config.nix".source
    }; }; here = /. + ${
      escapeNixString (toString (commonDir + "/common/nixpkgs"))
    }; in
    ${processed}
  '';
}
