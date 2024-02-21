{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.git;

in {
  options.modules.git = { enable = mkEnableOption "git"; };
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Gašper Spagnolo";
      userEmail = "gasper.spagnolo@outlook.com";
      signing.key = "9EE5C796920C339839F4EFF646DCDBC936F8414C";
      signing.signByDefault = true;

      aliases = {
        ci = "commit";
        co = "checkout";
        cp = "cherry-pick";
        s = "status -uall";
        br = "branch";
        aliases = "!git config -l | grep alias | cut -c 7-";
        hist =
          "log --pretty=format:'%C(yellow)%h%Creset%C(auto)%d - %s %Cblue[%an]' --graph --date=short --decorate --branches --remotes --tags";
        blobs =
          "!git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | sed -n 's/^blob //p' | sort --numeric-sort --key=2 | cut -c 1-12,41- | $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest";
        fap = "fetch --all --prune --progress";
        l =
          "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
        fixup = "commit --fixup";
        pr-diff = "diff upstream/HEAD..";
        pr-log = "l upstream/HEAD..";
        pr-edit =
          "rebase --interactive --autosquash --rerere-autoupdate --rebase-merges --fork-point upstream/HEAD";
        pr-clean =
          "-c sequence.editor=true rebase --interactive --autosquash --rerere-autoupdate --empty drop --no-keep-empty --fork-point upstream/HEAD";
        pr-update = "pull --rebase=merges upstream HEAD";
      };

      extraConfig = {
        merge.conflictstyle = "diff3";
        push.default = "current";
        pull.rebase = true;
        init.defaultBranch = "master";
        url."git@github.com:".insteadOf = "https://github.com/";
        branch.sort = "-committerdate";
        tag.sort = "-v:refname";
      };
    };
  };
}
