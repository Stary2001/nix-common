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
    onFailure = "notify-failure@nixos-upgrade.service";
  };
  systemd.services."notify-failure@" = {
  enable = true;
  description = "Failure notification for %i";
  scriptArgs = ''"%i" "Hostname: %H" "Machine ID: %m" "Boot ID: %b"'';
  script = ''
    unit="$1"
    extra_information=""
    for e in "''${@:2}"; do
      extra_information+="$e"$'\n'
    done
    ${pkgs.mailutils}/bin/mail \
    --subject="Service $unit failed on $2" \
    infra@chloe-is.online \
    <<EOF
    $(systemctl status -n 1000000 "$unit")
    $extra_information
    EOF
  '';
  };
}
