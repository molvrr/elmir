{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            elixir
            elixir-ls
            inotify-tools

            elmPackages.elm
            elmPackages.elm-language-server
            elmPackages.elm-format

            nodejs_20
          ];

          MIX_HOME = "/home/mateus/playground/elixir/elmir/.mix";
          MIX_ARCHIVES = "/home/mateus/playground/elixir/elmir/.mix/archives";
        };
      });
}
