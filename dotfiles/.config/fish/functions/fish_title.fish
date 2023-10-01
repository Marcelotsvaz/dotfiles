function fish_title
	# Title elements.
	set --query argv[1] || set argv fish
	# TODO: set host.
	set --query environment && set environmentPrompt " [$environment]"
	
	# Print title.
	printf "$argv$host$environmentPrompt"
end