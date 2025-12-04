source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
		fastfetch --config ~/.config/fastfetch/config.jsonc
end
