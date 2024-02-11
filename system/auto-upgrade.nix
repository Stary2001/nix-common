{config, pkgs, ...}: {
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    flake = "/home/stary/sys-${config.networking.hostName}";
    flags = [];
  };
  systemd.services.nixos-upgrade = {
    preStart = ''
      ${pkgs.sudo}/bin/sudo -u stary ${pkgs.bash}/bin/bash -c "cd ${config.system.autoUpgrade.flake}; ${pkgs.git}/bin/git pull --rebase"
    '';
  };
}
