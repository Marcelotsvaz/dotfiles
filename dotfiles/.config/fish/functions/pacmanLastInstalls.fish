function pacmanLastInstalls --description 'List explicitly installed packages sorted by install date'
	set pkgs $(pacman -Q --explicit --quiet)
	set journal $(journalctl --identifier pacman --output short-iso | grep ': installed ')
	
	for pkg in $pkgs
		set installDate $(string match --regex --groups "^(.+) vaz-pc.lan .+: installed $pkg " $journal)[-1]
		
		if test -z $installDate
			continue
		end
		
		echo $installDate $pkg
	end | sort
end