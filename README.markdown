# Flexible Words -- A TextMate Plugin
This plugin makes it possible for a TextMate bundle to override the default “Word Characters” option.

## Usage
Create, inside your bundle, a custom shell variable named *TM_WORD_CHARACTERS*.
You must, for the moment, manually invoke the plugin on the front document (the default binding is Control-Command-U).

## Example
Common Lisp settings:

    shellVariables = (
        { name = 'TM_WORD_CHARACTERS';
          value = '<=>+-*/';
        },  
    );