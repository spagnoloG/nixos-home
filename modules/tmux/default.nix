{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.tmux;

in {
  options.modules.tmux = { enable = mkEnableOption "tmux"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ tmux ];
    programs.tmux = {
      enable = true;
      clock24 = true;

      extraConfig = ''
        # Alacritty term support
        set -g default-terminal "tmux-256color"
        set -sg terminal-overrides ",*:RGB"

        # Enable vim keys
        set-window-option -g mode-keys vi
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R
        bind -r ^ last-window

        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy'

        # Remap prefix to Control + a
        # unbind C-b
        # set-option -g prefix C-a
        # bind-key C-a send-prefix

        # Set mouse
        set -g mouse on

        # Increase history size
        set-option -g history-limit 10000

        # Scripts
        # bind-key -r S run-shell "tmux neww ~/.local/scripts/ssh-connect.sh"
        # bind-key T run-shell "tmux neww tms"

        # Colors
        set-option -g pane-active-border-style fg='#6272a4'
        set-option -g pane-border-style fg='#ff79c6'
        # set-option -g status-bg black
        set-option -g status-fg black
        set -g status-right '#[fg=black,bg=#e95678] #{cpu_percentage}  %H:%M '
        run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
        run-shell ${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/main.tmux
      '';
    };

  };
}
