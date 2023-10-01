# 
# File locations.
#-------------------------------------------------------------------------------
set -x XDG_CONFIG_HOME ~/.config
set -x XDG_DATA_HOME ~/.local/share
set -x XDG_CACHE_HOME ~/.cache

# Config.
set -x KDEHOME "$XDG_CONFIG_HOME/kde4"
set -x GTK2_RC_FILES "$XDG_CONFIG_HOME/gtkrc-2.0"
set -x PYTHONSTARTUP "$XDG_CONFIG_HOME/python.py"
set -x DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -x MINIKUBE_HOME "$XDG_CONFIG_HOME/minikube"
set -x AWS_CONFIG_FILE "$XDG_CONFIG_HOME/aws/config"

# Data.
set -x VSCODE_EXTENSIONS "$XDG_DATA_HOME/code-oss"
set -x GOPATH "$XDG_DATA_HOME/go"
set -x PLATFORMIO_CORE_DIR "$XDG_DATA_HOME/platformio"

# Cache.
set -x LESSHISTFILE "$XDG_CACHE_HOME/lesshst"
set -x HISTFILE "$XDG_CACHE_HOME/bash_history"
set -x NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
set -x PLATFORMIO_CACHE_DIR "$XDG_CACHE_HOME/platformio"



# 
# Environment.
#-------------------------------------------------------------------------------
fish_add_path --path "$GOPATH/bin"
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"	# SSH Key Agent.
set -x GTK_USE_PORTAL 1	# Make GTK applications use xdg-desktop-portal for native KDE dialogs.
set -x MOZ_ENABLE_WAYLAND 1
set -x PYTHONPYCACHEPREFIX "$XDG_CACHE_HOME/python"
set -x AUR_USERNAME Marcelotsvaz

# VSCode shell integration.
string match -q $TERM_PROGRAM vscode
and . /usr/lib/code/out/vs/workbench/contrib/terminal/browser/media/fish_xdg_data/fish/vendor_conf.d/shellIntegration.fish



# 
# Interactive.
#-------------------------------------------------------------------------------
if status is-interactive
	# Configuration.
	set -x EDITOR nano
	set -x VISUAL code --wait
	set -x LESS
		set -a LESS --chop-long-lines
		set -a LESS --window=-2
		set -a LESS --shift=4
		set -a LESS --tabs=8
		set -a LESS --ignore-case
		set -a LESS --LONG-PROMPT
		set -a LESS --use-color
		set -a LESS --status-column
		set -a LESS --RAW-CONTROL-CHARS
		set -a LESS --quit-if-one-screen
		set -a LESS --HILITE-UNREAD
	set -x SYSTEMD_LESS $LESS
	
	set fish_greeting
	set VIRTUAL_ENV_DISABLE_PROMPT 1
	tabs -4
	
	# Aliases.
	alias ls 'exa --group-directories-first'
	alias ll 'ls --long --header --git --time-style long-iso --icons'
	alias la 'll --all'
	alias ip 'ip --color=auto'
	alias bridge 'bridge --color=auto'
	alias bash "bash --init-file $XDG_CONFIG_HOME/bash/bashrc"
	
	# Abbreviations.
	abbr --position anywhere sc 'systemctl'
	abbr --position anywhere jc 'journalctl'
	abbr --position anywhere nc 'networkctl'
	abbr --position anywhere rc 'resolvectl'
	abbr dr 'docker run -it --rm'
end