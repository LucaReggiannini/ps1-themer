# PS1 Themer
A set of tools to easily customize Bash.

## ps1-colorize-16
*ps1-colorize-16* is a generic script that generates text ready to be inserted into your PS1 variable.

```
ps1-colorize-16

SYNOPSIS: 
	ps1-colorize-16 [FOREGROUND COLOR] [BACKGROUND COLOR] [TEXT]

DESCRIPTION:
	Prints a line colorized  with PS1 syntax.

	Syntax:
		\[\e[FOREGROUND_CODE;BACKGROUND_CODEm\] here my colored line \[\e[m\]

	Example:

		Input:
			ps1-colorize-16 39 49 " here my colored line "

		Output:
			\[\e[39;49m\] here my colored line \[\e[m\]
		
	
	This script generates 16 colors only.
	Use parameter '-h' or '--help' to show this manual.
	
	For more informations about PS1 colors: https://misc.flogisoft.com/bash/tip_colors_and_formatting

COLORS:
	
	Foreground colors:

		Default         39    Default
		Black           30    Black
		Red             31    Red
		Green           32    Green
		Yellow          33    Yellow
		Blue            34    Blue
		Magenta         35    Magenta
		Cyan            36    Cyan
		Light gray      37    Light gray
		Dark gray       90    Dark gray
		Light red       91    Light red
		Light green     92    Light green
		Light yellow    93    Light yellow
		Light blue      94    Light blue
		Light magenta   95    Light magenta
		Light cyan      96    Light cyan
		White           97    White

	Background colors:

		Default         49    Default
		Black           40    Black
		Red             41    Red
		Green           42    Green
		Yellow          43    Yellow
		Blue            44    Blue
		Magenta         45    Magenta
		Cyan            46    Cyan
		Light gray      47    Light gray
		Dark gray       100   Dark gray
		Light red       101   Light red
		Light green     102   Light green
		Light yellow    103   Light yellow
		Light blue      104   Light blue
		Light magenta   105   Light magenta
		Light cyan      106   Light cyan
		White           107   White

```
![screenshot_ps1-colorize-16.png](./screenshots/screenshot_ps1-colorize-16.png)

The script is invoked by the PS1 Themer package themes to customize your terminal.

## Themes
There are currently two themes available:
- **ps1-luku-theme** (main theme)
- **ps1-luku-squared-theme** (main theme variant, no Unicode symbols used)

### Luku themes features
- light and dark variants
- colorized *root* user
- different custom foreground/background colors for *username@hostname*, current directory and Git Branch name
- custom background colors for the Git Branch name if there are changes to be committed
- custom folder length for the current working directory *(used to prevent full long paths to be displayed)*
- squared theme variant for terminal which do not support Unicode symbols

Light variant:
![screenshot_light.png](./screenshots/screenshot_light.png)
Dark variant:
![screenshot_dark.png](./screenshots/screenshot_dark.png)
Cygwin Bash on Windows 11 (square variant):
![screenshot_win.png](./screenshots/screenshot_win.png)
An example of theme customization:
![screenshot_customization.png](./screenshots/screenshot_customization.png)

## How to install
To install a theme simply add the following code to */etc/bash.bashrc*
```console
ps1Update() { 
	PS1="$(ps1-luku-theme)"
}
PROMPT_COMMAND=ps1Update
```
replace "ps1-luku-theme" with your chosen theme.

Put "ps1-colorize-16" and your themes in a folder located in $ PATH.

Alternatively you can use "install.sh" to automatically install the package.

This is my *bash.bashrc*:
```
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
```
