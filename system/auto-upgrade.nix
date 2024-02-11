{config, pkgs, ...}: let flakePath = "/home/stary/sys-${config.networking.hostName}"; in {
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    flake = "${flakePath}#default";
    flags = [];
  };
  systemd.services.nixos-upgrade = {
    preStart = ''
      ${pkgs.sudo}/bin/sudo -u stary ${pkgs.bash}/bin/bash -c "cd ${flakePath}; ${pkgs.git}/bin/git pull --rebase"
    '';
  };
}
