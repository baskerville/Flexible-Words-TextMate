# Flexible Words #
This plugin allows you to define bundle based “Word Characters” preferences.

## Usage ##
Create, a Property List named *.TM_WordCharacters.plist* inside your home directory.

Use the language name as key and the word characters as value. 

If you modify this file you'll have to hit *Control-Command-U* to reload it.

## Example ##
See *WordCharacters.plist*.

## Tip ##
In order to easily edit the configuration file from the Terminal, you can add the following line to your *.profile*:
	
	alias ple='open -a "Property List Editor"'