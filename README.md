# python-nix

Example nix flake for use with python and poetry, using poetry2nix.

nix - https://nixos.org/

poetry - https://python-poetry.org/

poetry2nix - https://github.com/nix-community/poetry2nix

## Usage:

Build the app -> creates an executable
```
nix build .#app
./result/bin/example
```

Create dev env -> spawns nix shell with all dev dependencies
```
nix develop

e.g
python example/main.py
poetry add <package-name> 
```

Create docker image -> Builds minimal layered docker image
```
nix build .#docker
docker load < result
docker run -itp 5000:5000 example-<image-identifier>
```
