{
  description = "system configuration for bernoulli";

  inputs = {
    nixpkgs.url = "nixpkgs";
  };

  outputs = inputs: let
    system = "x86_64-linux";
    myKeys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJjUz1FruDlg5VNmvd4wi7DiXbMJcN4ujr8KtQ6OhlSc stary@pc"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ+q372oe3sFtBQPAH93L397gYGYrjeGewzoOW97gSy1 stary@wheatley"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLg5nSbedQYRzm4BAU1OIYpaiTwP+afCAE3BvPcG7OI eddsa-key-20210602" # Windows VM
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK45+pMQ9LCmGLbP4fmDmjJaxEsB0JfeqXm8NK/Q9QSp JuiceSSH" # Phone
    ];
  in {
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
      };
  };
}