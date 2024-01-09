{ commonDir, unstable, ... }: {
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs.config = import (commonDir + "/nixpkgs/config.nix");
  nixpkgs.overlays = import (commonDir + "/nixpkgs/overlays.nix") { inherit unstable; here = commonDir + "/common/nixpkgs"; };
}
