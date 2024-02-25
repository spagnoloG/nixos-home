{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.brave;

in {
  options.modules.brave = { enable = mkEnableOption "brave"; };
  config = mkIf cfg.enable {

    programs.chromium = {
      enable = true;
      extensions = [
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
        "gaiceihehajjahakcglkhmdbbdclbnlf" # Video Speed Controller
        "gppongmhjkpfnbhagpmjfkannfbllamg" # Wappalyzer
        "naeaaedieihlkmdajjefioajbbdbdjgp" # Svg Export
        "aapbdbdomjkkjkaonfhkkikfgjllcleb" # Google Translate
        "bkhaagjahfmjljalopjnoealnfndnagc" # Octotree
      ];
      commandLineArgs = [
        "--flag-switches-begin"
        "--hide-sidepanel-button"
        "--show-avatar-button=never"
        "--flag-switches-end"
      ];
    };
    programs.chromium.package = pkgs.brave;
    home.sessionVariables.BROWSER = "brave";
  };

}
