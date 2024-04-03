{ pkgs, osConfig, ... }: {
  services.lorri.enable = true;
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.bash.enable = true;
  programs.bash.shellAliases = {
    "rebuild-system" =
      "cd /home/stary/sys-${osConfig.networking.hostName}; sudo nixos-rebuild switch --flake .#default";
    "rebuild-home" =
      "cd /home/stary/sys-${osConfig.networking.hostName}; home-manager switch --flake .#default";
  };
}
