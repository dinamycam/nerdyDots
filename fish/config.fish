if status is-interactive
    # Commands to run in interactive sessions can go here
		starship init fish | source
        batman --export-env | source
		fish_vi_key_bindings
end
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

# replace cat with bat
alias cat bat

# editor and visual for sudoedit and visudo
set -x EDITOR "nvim"
set -x VISUAL "nvim"

