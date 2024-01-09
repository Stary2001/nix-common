{ ..., unstable, commonDir }:
{
  nixpkgs.config = import (commonDir + "/common/nixpkgs/config.nix");
  nixpkgs.overlays = import (commonDir + "/common/nixpkgs/overlays.nix") { inherit unstable; here = commonDir + "/common/nixpkgs"; };
}
