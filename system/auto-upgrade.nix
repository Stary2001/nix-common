{...}: {
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    flake = "/home/stary/sys-${networking.hostname}";
    flags = [];
  };
}
