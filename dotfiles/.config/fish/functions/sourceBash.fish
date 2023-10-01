function sourceBash --description 'Source input script in Bash then collect new exported variables and source them in Fish'
	set argv $(string escape $argv)
	set bashVariables $(bash -c "comm -13 <(sort <(export)) <(sort <(source $argv 1>&2; export))")
	set fishVariables $(string replace --regex '^declare -x (\w+)="(.*)"$' 'set -gx $1 "$2"' $bashVariables)
	string join \n $fishVariables | source
end