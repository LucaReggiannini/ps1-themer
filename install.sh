#!/bin/bash

clear
DEFAULT_INSTALLATION_FOLDER="/usr/local/bin/"
read -p "Please enter your installation folder. Make sure this folder is in your \$PATH. Leave blank to use default [$DEFAULT_INSTALLATION_FOLDER]: " INSTALLATION_FOLDER
INSTALLATION_FOLDER="${INSTALLATION_FOLDER:-$DEFAULT_INSTALLATION_FOLDER}"

echo '

# BASE THEME INSTALLATION

File "/etc/bash.bashrc" will be renamed to "/etc/bash.bashrc.bak".
A custom "/etc/bash.bashrc" will be written.

The following files will be written in "'$INSTALLATION_FOLDER'".
ps1-colorize-16
ps1-luku-theme
ps1-luku-square-theme
libadwaita-theme-sync

The previous files will be marked for execution.

'

read -r -p "Do you want to install the base theme? [y/N] " response
case "$response" in
	[yY][eE][sS]|[yY]) 
		COMMANDS="
mv /etc/bash.bashrc /etc/bash.bashrc.bak;
cp ./bash.bashrc /etc/bash.bashrc;

chmod +x ./ps1-colorize-16 ./ps1-luku-theme ./ps1-luku-square-theme;

cp ./ps1-colorize-16 $INSTALLATION_FOLDER;
cp ./ps1-luku-theme $INSTALLATION_FOLDER;
cp ./ps1-luku-square-theme $INSTALLATION_FOLDER;
"
		if command -v sudo &> /dev/null; then # Check if 'sudo' exists (Usefull on system without 'sudo' like Cygwin)
			sudo sh -c "$COMMANDS"
		else
			sh -c "$COMMANDS"
		fi
		source /etc/bash.bashrc
		echo 'Base theme installation completed.'
		;;
	*)
		echo 'Base theme installation stopped by the user'
		;;
esac

clear
echo '

# SYSTEMD SERVICE FOR THEME SYNC

The following files will be written in "'$INSTALLATION_FOLDER'".
libadwaita-theme-sync
libadwaita-theme-sync-writer

The previous files will be marked for execution. 
File "libadwaita-theme-sync-writer" will also be owned by root and set with SUID bit.

File "ps1-themer.service" will be written to "~/.config/systemd/user".
Systemd unit "ps1-themer" will be enabled.

'
read -r -p "Do you want to install the synchronization Service? [y/N] " response
case "$response" in
	[yY][eE][sS]|[yY]) 
		
		if command -v sudo &> /dev/null; then # Check if 'sudo' exists (Usefull on system without 'sudo' like Cygwin)
			DEFAULT_INSTALLATION_USERNAME=$(sudo printenv SUDO_USER)
		else
			DEFAULT_INSTALLATION_USERNAME=$(whoami)
		fi

		# DEFAULT_INSTALLATION_GROUP=$DEFAULT_INSTALLATION_USERNAME
		# read -p "Select the user with whom the service will run. Leave blank to use the current real user [$DEFAULT_INSTALLATION_USERNAME]: " INSTALLATION_USERNAME
		# INSTALLATION_USERNAME="${INSTALLATION_USERNAME:-$DEFAULT_INSTALLATION_USERNAME}"
		# read -p "Select the group with whom the service will run. Leave blank for default value [$DEFAULT_INSTALLATION_GROUP]: " INSTALLATION_GROUP
		# INSTALLATION_GROUP="${INSTALLATION_GROUP:-$DEFAULT_INSTALLATION_GROUP}"

		# sed -i "s/User=.*/User=$INSTALLATION_USERNAME/g" ps1-themer.service
		# sed -i "s/Group=.*/Group=$INSTALLATION_GROUP/g" ps1-themer.service
		
		DEFAULT_GTK_THEME_LIGHT="adw-gtk3"
		DEFAULT_GTK_THEME_DARK="adw-gtk3-dark"
		read -p "Select the GTK Light theme you want to sync with Libadwaita. Leave blank to use the default one [$DEFAULT_GTK_THEME_LIGHT]: " GTK_THEME_LIGHT
		GTK_THEME_LIGHT="${GTK_THEME_LIGHT:-$DEFAULT_GTK_THEME_LIGHT}"
		read -p "Select the GTK Dark theme you want to sync with Libadwaita. Leave blank to use the default one [$DEFAULT_GTK_THEME_DARK]: " GTK_THEME_DARK
		GTK_THEME_DARK="${GTK_THEME_DARK:-$DEFAULT_GTK_THEME_DARK}"
		sed -i "s/GTK_THEME_LIGHT=\".*\"/GTK_THEME_LIGHT=\"$GTK_THEME_LIGHT\"/g" libadwaita-theme-sync
		sed -i "s/GTK_THEME_DARK=\".*\"/GTK_THEME_DARK=\"$GTK_THEME_DARK\"/g" libadwaita-theme-sync
		
		COMMANDS='
chmod +x ./libadwaita-theme-sync-writer ./libadwaita-theme-sync

cp ./libadwaita-theme-sync '$INSTALLATION_FOLDER';
cp ./libadwaita-theme-sync-writer '$INSTALLATION_FOLDER';

chown root:root '$INSTALLATION_FOLDER'/libadwaita-theme-sync-writer;
chmod u+s '$INSTALLATION_FOLDER'/libadwaita-theme-sync-writer;
'

		if command -v sudo &> /dev/null; then # Check if 'sudo' exists (Usefull on system without 'sudo' like Cygwin)
			sudo sh -c "$COMMANDS"
		else
			sh -c "$COMMANDS"
		fi
		mkdir -p ~/.config/systemd/user
		cp ./ps1-themer.service ~/.config/systemd/user;
		systemctl --user enable ps1-themer;
		echo 'Synchronization Service installation completed.'
		;;
	*)
		echo 'Synchronization Service installation stopped by the user'
		;;
esac



