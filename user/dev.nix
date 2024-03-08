{ pkgs, osConfig, ... }: {
  services.lorri.enable = true;
  programs.direnv = { 
    enable = true;
    enableBashIntegration = true;
  };
  programs.bash.shellAliases = {
    "rebuild-system" =
      "cd /home/stary/${osConfig.networking.hostName}; sudo nixos-rebuild switch --flake .#default";
    "rebuild-home" =
      "cd /home/stary/${osConfig.networking.hostName}; home-manager switch --flake .#default";
  };
}
