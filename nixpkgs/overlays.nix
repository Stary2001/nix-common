{ unstable }: [
  (self: super: {
    # Add packages
    lightspeed-ingest = super.callPackage ./packages/lightspeed-ingest.nix {};
    lightspeed-webrtc = super.callPackage ./packages/lightspeed-webrtc.nix {};
    lightspeed-frontend = super.callPackage ./packages/lightspeed-frontend.nix {};
  })
]
