{
  lib,
  buildGoModule,
  fetchFromGitHub,
  testers,
  paretosecurity,
  nixosTests,
}:

buildGoModule rec {
  pname = "paretosecurity";
  version = "0.0.82";

  src = fetchFromGitHub {
    owner = "ParetoSecurity";
    repo = "agent";
    rev = version;
    hash = "sha256-kW2mpCS0heB1kwPO83KqhkHESUUKYyUYFgGCLRX5qeg=";
  };

  vendorHash = "sha256-TlZ7Z6qZCdmXej9oaB4ImnVuP1AKoLhDIqM0ga1V/O8=";

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/ParetoSecurity/agent/shared.Version=${version}"
    "-X=github.com/ParetoSecurity/agent/shared.Commit=${src.rev}"
    "-X=github.com/ParetoSecurity/agent/shared.Date=1970-01-01T00:00:00Z"
  ];

  passthru.tests = {
    version = testers.testVersion {
      version = "${version}";
      package = paretosecurity;
      command = "paretosecurity version";
    };
    integration_test = nixosTests.paretosecurity;
  };

  meta = {
    description = "Pareto Security app makes sure your laptop is correctly configured for security.";
    homepage = "https://github.com/ParetoSecurity/agent";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "paretosecurity";
  };
}
