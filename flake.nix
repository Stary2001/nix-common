{
  description = "common system configuration and packages and such";

  inputs = {
    nixpkgs.url = "nixpkgs";
    naersk.url = "github:nix-community/naersk/master";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, naersk }:
  utils.lib.eachDefaultSystem(system:
      let pkgs = import nixpkgs { inherit system; };
          naersk-lib = pkgs.callPackage naersk {}; in {
      packages = {
        lightspeed-ingest = pkgs.callPackage ./packages/lightspeed-ingest.nix { naersk-lib = naersk-lib; };
        lightspeed-webrtc = pkgs.callPackage ./packages/lightspeed-webrtc.nix {};
        lightspeed-frontend = pkgs.callPackage ./packages/lightspeed-frontend.nix {};
        #broadcast-box-backend = pkgs.callPackage ./packages/broadcast-box-backend.nix {};
        #broadcast-box-frontend = pkgs.callPackage ./packages/broadcast-box-frontend.nix {};
      };
  }) // {
      nixosModules = {
        nine-net = {pkgs, ...}: {
          imports = [./9net.nix];
        };
        avahi = {pkgs, ...}: {
          imports = [./avahi.nix];
        };
        locale = {pkgs, ...}: {
          imports = [./locale.nix];
        };
        ssh-keys = {pkgs, ...}: {
          imports = [./ssh-keys.nix];
        };
        wait-online-any = {...}: {
          systemd.network.wait-online.anyInterface = true;
	};
        service-lightspeed = { pkgs, ... }: {
          imports = [./service/lightspeed.nix];
        };
        #service-broadcast-box = { pkgs, ... }: {
        #  imports = [./service/broadcast-box.nix];
        #};
      };
  };
}
