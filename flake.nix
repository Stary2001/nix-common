{
  description = "common system configuration and packages and such";

  inputs = {};

  outputs = inputs:
  {
      homeModules = {
        base = {pkgs, ...}: {
          _module.args.commonDir = ./.;
          imports = [./user/base.nix ./user/nix.nix ./user/dev.nix];
        };
      };

      nixosModules = {
        base = {pkgs, ...}: {
          _module.args.commonDir = ./.;
          imports = [./system/locale.nix ./system/ssh-keys.nix ./system/nix.nix];
        };
        prometheus-exporter = {pkgs, ...}: {
          imports = [./system/prometheus-exporter.nix];
        };
        nine-net = {pkgs, ...}: {
          imports = [./system/9net.nix];
        };
        auto-upgrade = {pkgs, ...}: {
          imports = [./system/auto-upgrade.nix];
        };
        avahi = {pkgs, ...}: {
          imports = [./system/avahi.nix];
        };
        wait-online-any = {...}: {
          systemd.network.wait-online.anyInterface = true;
	};
        service-lightspeed = { pkgs, ... }: {
          imports = [./system/service/lightspeed.nix];
        };
        #service-broadcast-box = { pkgs, ... }: {
        #  imports = [./system/service/broadcast-box.nix];
        #};
      };
  };
}
