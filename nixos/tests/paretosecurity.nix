{ lib, ... }:
{
  name = "paretosecurity";
  meta.maintainers = [ lib.maintainers.zupo ];

  nodes.machine =
    { config, pkgs, ... }:
    {
      services.paretosecurity.enable = true;
    };

  testScript = ''
    machine.wait_until_succeeds("paretosecurity check")
  '';
}
