{ ..., commonDir }: {
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs.config = import (commonDir + "/nixpkgs/config.nix");
  nixpkgs.overlays = import (commonDir + "/nixpkgs/overlays.nix");
}
