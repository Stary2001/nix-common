{
  description = "common system configuration and packages and such";

  inputs = {};

  outputs = inputs:
  {
      homeModules = {
        base = {pkgs, ...}: {
          imports = [./user/base.nix];
        };
        nix = {pkgs, ...}: {
          _module.args.commonDir = ./.;
          imports = [./user/nix.nix];
        };
      };

      nixosModules = {
        nine-net = {pkgs, ...}: {
          imports = [./system/9net.nix];
        };
        avahi = {pkgs, ...}: {
          imports = [./system/avahi.nix];
        };
        locale = {pkgs, ...}: {
          imports = [./system/locale.nix];
        };
        ssh-keys = {pkgs, ...}: {
          imports = [./system/ssh-keys.nix];
        };
        wait-online-any = {...}: {
          systemd.network.wait-online.anyInterface = true;
	};
        nix = {...}: {
          _module.args.commonDir = ./.;
          imports = [./system/nix.nix];
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
