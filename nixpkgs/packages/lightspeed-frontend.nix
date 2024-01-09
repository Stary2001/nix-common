{pkgs, buildNpmPackage, fetchFromGitHub}: let repo = fetchFromGitHub {
     owner = "GRVYDEV";
     repo = "Project-Lightspeed";
     rev = "2ab01cca33f9302bcb8da112592686de5191656d";
     hash = "sha256-pQEkoy5YPqJN1Zu3DTrQMQv7DnA61r6uaJibYxiCeHE=";
   }; in
buildNpmPackage rec {
   pname = "lightspeed-frontend";
   version = "two";
   src = "${repo}/frontend";

   npmDepsHash = "sha256-uO1FmUhVJCE/bxIMM0AUiIagOgCv26+L0/gdRHtU3m8=";
   # The prepack script runs the build script, which we'd rather do in the build phase.
   npmPackFlags = [ "--ignore-scripts" ];

   NODE_OPTIONS = "--openssl-legacy-provider";

   meta = with pkgs.lib; {
    description = "Some stuff";
  };
}
