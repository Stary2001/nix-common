{ pkgs, config, ... }: {
  services.lorri.enable = true;
  programs.direnv = { 
    enable = true;
    enableBashIntegration = true;
  };
  programs.bash.shellAliases = {
    "rebuild-system" =
      "cd /home/stary/${config.networking.hostName}; sudo nixos-rebuild switch --flake .#default";
    "rebuild-home" =
      "cd /home/stary/${config.networking.hostName}; home-manager switch --flake .#default";
  };
}
