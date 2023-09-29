{
  description = "common system configuration and packages and such";

  inputs = {
    nixpkgs.url = "nixpkgs";
    naersk.url = "github:nix-community/naersk/master";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, naersk }: let
    myKeys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJjUz1FruDlg5VNmvd4wi7DiXbMJcN4ujr8KtQ6OhlSc stary@pc"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ+q372oe3sFtBQPAH93L397gYGYrjeGewzoOW97gSy1 stary@wheatley"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLg5nSbedQYRzm4BAU1OIYpaiTwP+afCAE3BvPcG7OI eddsa-key-20210602" # Windows VM
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK45+pMQ9LCmGLbP4fmDmjJaxEsB0JfeqXm8NK/Q9QSp JuiceSSH" # Phone
    ];
  in utils.lib.eachDefaultSystem(system:
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
          users.users.root.openssh.authorizedKeys.keys = myKeys;
          users.users.stary.openssh.authorizedKeys.keys = myKeys;
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
