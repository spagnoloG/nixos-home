# nixos-home

Home-manager and nixos system configuration using flakes!

Use it as a template for your nixos setup:)

## Getting started

Installation steps:

- [Installation](https://nixos.org/manual/nixos/stable/index.html#ch-installation): Install NixOS.
- Clone repo `git clone git@github.com:spagnoloG/nixos-home.git ~/.config/home-manager`
- Edit the username and hostname in `flake.nix` 
- Copy you `hardware-configuration.nix` file located at `/etc/nixos/hardware-configuration.nix` to the host folder.
- Enable Nix-Command and Flakes options: Edit your `configuration.nix` file located at /etc/nixos/configuration.nix adding this line -> `nix.settings.experimental-features = [ "nix-command" "flakes" ];`.
- Rebuild your system: run -> `sudo nixos-rebuild switch`. 
- Apply the flake: Open a terminal and inside `~/.config/home-manager/` run `make rebuild-os`.


## After installation

When you modify any contents, you need to rebuild os. This will create a new `nixos` generation.

Rebuilding:

```bash
make rebuild-os
```

Formatting all `*nix` files:

```bash
make  lint
```

Cleaning up old generations:

```bash
make clean-os
```
