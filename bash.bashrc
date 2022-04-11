#!/bin/bash


ps1Update() { 
	PS1="$(ps1-luku-theme)"
	# export PROMPT_DIRTRIM=3 # Uncomment to show the last three folders in PS1 Path
}
# Variable 'PROMPT_COMMAND' is used to update PS1 at every new command
PROMPT_COMMAND=ps1Update

# Print hidden files first ('dot files')
# Print directory first
# Print file on by line
# Colorize output
alias ls="ls -a1v --group-directories-first --color=auto"
