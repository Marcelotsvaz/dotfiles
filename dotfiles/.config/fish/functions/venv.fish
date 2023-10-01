function venv --description 'Create and activate a Python virtual environment.'
	python -m venv --clear --upgrade-deps --prompt venv .venv
	
	source .venv/bin/activate.fish
end
