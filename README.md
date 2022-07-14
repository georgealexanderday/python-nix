# python-nix

Example nix flake for use with python and poetry, using poetry2nix.

nix - https://nixos.org/
poetry - https://python-poetry.org/
https://github.com/nix-community/poetry2nix

## Usage:

Build the app -> creates an executable
```
nix build .#app
./result/bin/example
```

Create dev env -> spawns nix shell with all dev dependencies
```
nix develop
```

Create docker image -> Builds minimal layered docker image
```
nix build .#docker
docker load < result
docker run -itp 5000:5000 example-<image-identifier>
```

\\TODO
dev env broken :(
