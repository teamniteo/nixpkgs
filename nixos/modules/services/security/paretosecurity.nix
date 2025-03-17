{
  config,
  lib,
  pkgs,
  ...
}: {
  options.services.paretosecurity = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ParetoSecurity.";
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.paretosecurity;
      defaultText = lib.literalExpression "pkgs.paretosecurity";
      description = "The ParetoSecurity package to use.";
    };
  };

  config = lib.mkIf config.services.paretosecurity.enable {
    environment.systemPackages = [ config.services.paretosecurity.package ];

    systemd.sockets."paretosecurity" = {
      wantedBy = ["sockets.target"];
      socketConfig = {
        ListenStream = "/var/run/paretosecurity.sock";
        SocketMode = "0666";
      };
    };

    systemd.services."paretosecurity" = {
      serviceConfig = {
        ExecStart = "${config.services.paretosecurity.package}/bin/paretosecurity helper";
        User = "root";
        Group = "root";
        StandardInput = "socket";
        Type = "oneshot";
        RemainAfterExit = "no";
        StartLimitInterval = "1s";
        StartLimitBurst = 100;
        ProtectSystem = "full";
        ProtectHome = true;
        StandardOutput = "journal";
        StandardError = "journal";
      };
    };

  };
}
