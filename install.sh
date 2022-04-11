#!/bin/bash

COMMANDS='
mv /etc/bash.bashrc /etc/bash.bashrc.bak;
cp ./bash.bashrc /etc/bash.bashrc;
chmod +x ./ps1-colorize-16 ./ps1-luku-theme ./ps1-luku-square-theme;
cp ./ps1-colorize-16 /usr/local/bin/;
cp ./ps1-luku-theme /usr/local/bin/;
cp ./ps1-luku-square-theme /usr/local/bin/;
'

echo 'File "/etc/bash.bashrc" will be moved to "/etc/bash.bashrc.bak"'
echo 'A custom "/etc/bash.bashrc" will be written'
echo ''
echo 'The following files will be written to "/usr/local/bin" (please make sure this folder is in your $PATH or move them in another location):'
echo 'ps1-colorize-16'
echo 'ps1-luku-theme'
echo 'ps1-luku-square-theme'
echo ''
echo 'The previous files will be marked for execution'
echo ''

read -r -p "Are you sure you want to continue? [y/N] " response
case "$response" in
	[yY][eE][sS]|[yY]) 
		# Check if 'sudo' exists
		# Usefull on system without 'sudo' (example Cygwin)
		if command -v sudo &> /dev/null
		then
			sudo sh -c "$COMMANDS"
		else
			sh -c "$COMMANDS"
		fi
		source /etc/bash.bashrc
		;;
	*)
		echo 'Installation stopped by the user'
		;;
esac

