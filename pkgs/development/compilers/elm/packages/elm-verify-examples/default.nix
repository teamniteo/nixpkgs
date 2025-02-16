{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  testers,
  elm-review,
}:

buildNpmPackage rec {
  pname = "elm-verify-examples";
  version = "6.0.3";

  src = fetchFromGitHub {
    owner = "stoeffel";
    repo = "elm-verify-examples";
    rev = "v${version}";
    hash = "sha256-HUmIrwmJyGvkCRHRiA069Aj25WBIGtJ7DJxwwF6OvWU=";
  };

  npmDepsHash = "sha256-frNCo97GOwiClzQwRXHpqqjimJrmipsBebAshJqGZco=";

  # postPatch = ''
  #   sed -i "s/elm-tooling install/echo 'skipping elm-tooling install'/g" package.json
  # '';

  dontNpmBuild = true;

  # passthru.tests.version = testers.testVersion {
  #   version = "${version}";
  #   package = elm-review;
  #   command = "elm-review --version";
  # };

  meta = {
    changelog = "https://github.com/stoeffel/elm-verify-examples/blob/v${src.rev}/CHANGELOG.md";
    description = "Verify examples in your docs";
    mainProgram = "elm-verify-examples";
    homepage = "https://github.com/stoeffel/elm-verify-examples";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [
      turbomack
      zupo
    ];
  };
}
