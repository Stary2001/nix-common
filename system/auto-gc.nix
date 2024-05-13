{...}: {
  nix.gc = {
   automatic = true;
   persistent = true;
   dates = "daily";
   options = "--delete-older-than 7d";
  };
}
