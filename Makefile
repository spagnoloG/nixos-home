
.PHONY: rebuild-os debug update-os format cleanup-os

FLAKE_PATH := /home/spagnologasper/.config/home-manager#yoga
SYSTEM_PACKAGES_PATH := /nix/var/nix/profiles/system

rebuild-os:
	@echo "Rebuilding NixOS from flake..."
	@sudo nixos-rebuild switch --flake $(FLAKE_PATH) --upgrade 

debug:
	@echo "Debugging NixOS..."
	@sudo nixos-rebuild switch --flake $(FLAKE_PATH) --upgrade --show-trace --verbose

update-os:
	@echo "Updating NixOS..."
	@sudo nix flake update $(FLAKE_PATH) 

cleanup-os:
	@echo "Cleaning garbage and optimizing packages..."
	@home-manager generations | tail -n +4 | awk '{print $5}' | xargs -I {} home-manager remove-generations {}
	@sudo nix-env --list-generations --profile $(SYSTEM_PACKAGES_PATH) 
	@sudo nix-env --delete-generations old --profile $(SYSTEM_PACKAGES_PATH)
	@sudo nix-collect-garbage -d
	@sudo nix-store --optimize
	@sudo nix-env --list-generations --profile $(SYSTEM_PACKAGES_PATH)

format:
	@echo "Formatting Nix & Lua files..."
	@find . -type f -iname "*.nix" -exec nixfmt {} \;
	@find . -type f -iname "*.lua" -exec lua-format --in-place {} \;
