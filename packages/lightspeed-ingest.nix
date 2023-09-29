{pkgs, naersk-lib, fetchFromGitHub}: let repo = fetchFromGitHub {
     owner = "GRVYDEV";
     repo = "Project-Lightspeed";
     rev = "2ab01cca33f9302bcb8da112592686de5191656d";
     hash = "sha256-pQEkoy5YPqJN1Zu3DTrQMQv7DnA61r6uaJibYxiCeHE=";
   }; in
naersk-lib.buildPackage { src = "${repo}/ingest"; }
