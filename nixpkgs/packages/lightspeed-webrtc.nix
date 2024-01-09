{ pkgs, buildGoModule, fetchFromGitHub }: let repo = fetchFromGitHub {
     owner = "GRVYDEV";
     repo = "Project-Lightspeed";
     rev = "2ab01cca33f9302bcb8da112592686de5191656d";
     hash = "sha256-pQEkoy5YPqJN1Zu3DTrQMQv7DnA61r6uaJibYxiCeHE=";
   }; in
buildGoModule {
  pname = "lightspeed-webrtc";
  version = "two";
  src = "${repo}/webrtc";

  # 10 line comment removed
  vendorSha256 = "A9eyLpIc/hbcnZywVwyl2F6IWcDtFuYUau2xbZju77A=";
}
