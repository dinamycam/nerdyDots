if status is-interactive
    # Commands to run in interactive sessions can go here
		starship init fish | source
		fish_vi_key_bindings
end
batman --export-env | source
alias cat bat
