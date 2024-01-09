{ config, lib, pkgs, ... } : 
  with lib;
  let cfg = config.stary.services.lightspeed;
  in {

  options.stary.services.lightspeed = {
    enable = mkEnableOption "Enables the Lightspeed streaming service";

    packages = {
      ingest = mkOption rec {
        type = types.package;
        default = pkgs.lightspeed-ingest;
      };
      webrtc = mkOption rec {
        type = types.package;
        default = pkgs.lightspeed-webrtc;
      };
      frontend = mkOption rec {
        type = types.package;
        default = pkgs.lightspeed-frontend;
      };
    };
       
    ingest = {
        bindAddress = mkOption rec { 
          type = types.str;
          default = "0.0.0.0"; 
          description = "Bind address";
        };
        streamKey = mkOption rec { 
          type = types.str;
          default = "verysecure";
          description = "Bind address";
        };
    };

    webrtc = {
        iceServers = mkOption rec { 
          type = types.str;
          default = "none";
          description = "List of ICE servers";
        };
        bindAddress = mkOption rec { 
          type = types.str;
          default = "0.0.0.0"; 
          description = "Bind address";
        };
        publicAddress = mkOption rec { 
          type = types.str;
          default = "none";
          description = "Public IP address";
        };
        webRtcPorts = mkOption rec {
          type = types.str;
          default = "20000-20500";
          description = "Port range used for WebRC (TCP and UDP)";
        };
        rtpPort = mkOption rec {
          type = types.str;
          default = "65535";
          description = "Port used for RTP";
        };
        # SSL sucks to deal with therefore I won't
        websocketPort = mkOption rec {
          type = types.str;
          default = "8080";
          description = "Port used for websocket connections";
        };
    };

    domain = mkOption rec {
      type = types.str;
      default = null;
      description = "The domain name for Lightspeed";
    };
    ssl = mkOption rec {
      type = types.bool;
      default = false;
      description = "enable SSL?";
    };
  };
 
  config = mkIf cfg.enable {
    systemd.services."lightspeed-webrtc" = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Restart = "on-failure";
        ExecStart = "${cfg.packages.webrtc}/bin/lightspeed-webrtc -addr ${cfg.webrtc.bindAddress} -ip ${cfg.webrtc.publicIp} -ports ${cfg.webrtc.webrtcPorts} -rtp-port ${cfg.webrtc.rtpPort} -ws-port ${cfg.webrtc.websocketPort}";
        DynamicUser = "yes";
      };
    };
    systemd.services."lightspeed-ingest" = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Restart = "on-failure";
        ExecStart = "${cfg.packages.ingest}/bin/lightspeed-ingest --address ${cfg.ingest.bindAddress} --stream-key ${cfg.ingest.streamKey}";
        DynamicUser = "yes";
      };
    };
    services.nginx.virtualHosts.${cfg.domain} = {
      locations."/".root = "${cfg.packages.frontend}/lib/node_modules/lightspeed-react/public/";
      locations."/config.json" = {}; # ??
    } // mkIf cfg.ssl {
      enableACME = true; forceSSL = true;
    };
  };
}
