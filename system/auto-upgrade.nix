{config, ...}: {
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    flake = "/home/stary/sys-${config.networking.hostName}";
    flags = [];
  };
}
