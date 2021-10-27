padline
=======

Features
--------

`padline` adds `<Plug>`-mappings and commands to insert or remove padding in the form of empty lines.

Padding can be added above, below or around a line or visual selection.

`padline` does not have any side-effects such as
 - changing cursor position
 - modifying jump-list
 - starting a new change (ie. it does not break dot-repeatability)

For more information, have a look at the [Documentation](doc/padline.txt)

Installation
------------

Using `vim-plug`:

Insert the following line in your `.vimrc` inside the `plug#begin(...)`/`plug#end()` block.

```
Plug 'notuxic/vim-padline'
```
