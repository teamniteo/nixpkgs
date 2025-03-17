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
  version = "0.0.85";

  src = fetchFromGitHub {
    owner = "ParetoSecurity";
    repo = "agent";
    rev = version;
    hash = "sha256-C1rjRVc0icSaHhOVIm8sXV9g7GchPCevIXAlSqN4D3g=";
  };

  doCheck = false;

  vendorHash = "sha256-XK5ma3c84OakVYEVkEropiNU1KaZsdPpiYw0dkTdfdY=";

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
