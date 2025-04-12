{ config, pkgs, ... }:
let flakePath = "/home/stary/sys-${config.networking.hostName}";
in {
  # needed with newer git to have it owned by me but have nixos-upgrade do things as root
  programs.git.enable = true;
  programs.git.config = {
    safe = { directory = "${flakePath}/"; };
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    flake = "${flakePath}#default";
    flags = [ ];
  };
  systemd.services.nixos-upgrade = {
    preStart = ''
      ${pkgs.sudo}/bin/sudo -u stary ${pkgs.bash}/bin/bash -c "cd ${flakePath}; ${pkgs.git}/bin/git pull --rebase"
    '';
  };
}
