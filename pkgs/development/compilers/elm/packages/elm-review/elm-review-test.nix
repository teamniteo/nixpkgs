{ runCommand, elm-review, elmPackages }:

let
  env = {
    nativeBuildInputs = [ elm-review elmPackages.elm ];
  };
in

runCommand "elm-review" env ''
  set -xeuo pipefail
  cp -r ${./example-project}/* .

  elm-review
''
