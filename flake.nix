{
  description = "My Python application";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        packageName = "example";
        pkgs = nixpkgs.legacyPackages.${system};

        customOverrides = self: super: {
          # Overrides go here e.g
          # more-itertools = super.more-itertools.overridePythonAttrs(old: {
          #   buildInputs = old.buildInputs or [] ++ [ pkgs.python39.pkgs.flit-core];
          # });
        };

        app = pkgs.poetry2nix.mkPoetryApplication {
          projectDir = ./.;
          python = pkgs.python39;
          overrides = [ pkgs.poetry2nix.defaultPoetryOverrides customOverrides ];
        };

        env = pkgs.poetry2nix.mkPoetryEnv {
          projectDir = ./.;
          python = pkgs.python39;
          overrides = [ pkgs.poetry2nix.defaultPoetryOverrides customOverrides ];
          editablePackageSources = {
            example = "./example";
          };
        };

        docker = pkgs.dockerTools.buildLayeredImage {
          name = packageName;
          contents = [ app.dependencyEnv ];
          config = {
            Cmd = [ "/bin/example" "example:main"];
            WorkingDir = "/";
          };
        };

      in
      {
        packages.${packageName} = app;

        packages = {
          app = app;
          docker = docker;
        };

        packages.default = self.packages.${system}.${packageName};

        devShells.default  = pkgs.mkShell {
          buildInputs = with pkgs; [ env poetry ];
        };
      });
}
