# praatMiscScripts

#### Collection of miscellaneous scripts for Praat

This repository contains a slowly growing number of scripts to conduct
miscellaneous tasks for which I've missed existing scripts. Please do send me
your comments, suggestions or ideas (you can find my contact details [here][]).

## Scripts included

* [toPraatColour][]: A procedure for Praat to convert colours in hexadecimal
or RGB format into Praat's colour format. The main procedure is meant to be
inserted into other scripts via `include colors.proc` and then two sub-procedures
can be called providing arguments. Once a sub-procedure has been called, a local
variable called `sub-procedure_name.color$` can be used to set Praat colours for
the Picture window inside a script. More details and instructions of use are
available in the procedures and test files.

[here]: http://www.mauriciofigueroa.cl
[toPraatColour]: https://github.com/mauriciofigueroa/praatMiscScripts/tree/master/toPraatColour