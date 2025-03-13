{ lib, ... }:
{
  name = "pgweb";
  meta.maintainers = [ lib.maintainers.zupo ];

  nodes.machine =
    { config, pkgs, ... }:
    {
      services.paretosecurity.enable = true;
    };

  testScript = ''
    machine.wait_for_unit("paretosecurity.service")
    machine.wait_until_succeeds("paretosecurity check")
  '';
}
