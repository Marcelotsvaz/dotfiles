function fish_prompt
	# Preserve $pipestatus.
	set lastPipestatus $pipestatus
	
	# Colors.
	set venvColor	$(set_color 4B8BBE)
	set userColor	$(set_color --bold $fish_color_user)
	set pwdColor	$(set_color --bold $fish_color_cwd)
	set statusColor	$(set_color --bold $fish_color_status)
	set resetColor	$(set_color normal)
	
	# Python virtual environment.
	# TODO: Cache the file read?
	if set --query VIRTUAL_ENV
		set venvPrompt $(
			cat $VIRTUAL_ENV/pyvenv.cfg | string match --regex --groups '^prompt = \'(.*)\'$'	\
			|| basename $VIRTUAL_ENV
		)
		set venv [🐍 $venvColor$venvPrompt$resetColor]
	end
	
	# Project environment.
	if set --query environment
		set environmentPrompt [$environment]
	end
	
	# Shell nesting level.
	if test $SHLVL -gt 1
		set shellLevel [⑂$SHLVL]
	end
	
	# Prompt elements.
	set user		$userColor$USER$resetColor
	set host		$userColor$(prompt_hostname)$resetColor
	set pwd			$pwdColor$(prompt_pwd --dir-length 0)$resetColor
	set vcs			$(fish_vcs_prompt '[ %s]')
	set code		$(__fish_print_pipestatus '[' ']' '|' $resetColor $statusColor $lastPipestatus)
	
	# Print prompt.
	printf "┌[$user@$host $pwd]$vcs$environmentPrompt$venv$shellLevel$code\n"
	printf "└> "
end



function fish_right_prompt
	# Prompt elements.
	set currentTime	$(date '+%H:%M:%S')
	
	# Print prompt.
	printf [$currentTime]
end