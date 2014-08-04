# Written by Mauricio Figueroa (www.mauriciofigueroa.cl)
# v.0.2 - 15th July 2014
# 
# Script to test "colors.proc". This script includes the main procedure (see
# line 36; the path to the file is relative) and then calls two procedures
# contained in "colors.proc", named "rgb2praat" and "hex2praat" (see lines 67
# and 56), which become available after the main procedure is included into the
# script. After these procedures have been called and arguments have been
# provided for them, a local variable from each procedure is used as a Praat
# colour argument, as seen in lines 71 and 63.
#
# The main procedure ("colors.proc") contains the following three
# sub-procedures: (a) "hex2rgb": converts hexadecimal colour codes into
# RGB-coded colours; (b) "rgb2praat": converts RGB colours into
# Praat-formatted RGB colours; and (c) "hex2praat": uses the two previous
# procedures to convert hexadecimal colours into Praat-formatted colours.
#
# In practice, you only have to call "hex2praat" and "rgb2praat". In the case
# of "hex2praat", you have to provide a hexadecimal string as the only required
# argument. In the case of "rgb2praat", you have to provide red, green and blue
# values (between 0 and 255) as the three required arguments. Once you have
# done that, a local variable called ".color$" will contain the Praat-formatted
# colour ready to use in Praat scripts. To call this variable, as is done in
# lines 63 and 71, you have to refer to the name of the sub-procedure plus
# ".color$".
#
# This script is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option)
# any later version.
#
# A copy of the GNU General Public License is available at 
# <http://www.gnu.org/licenses/>.

# Including the procedure into this script.
include colors.proc

# Form to introduce drawing parameters from the user.
form Choose drawing parameters:
	comment Choose a colour for the background:
		word Hexadecimal_colour: #FF950E
	comment Choose an RGB colour for the text:
		integer Red: 252
		integer Green: 211
		integer Blue: 32
	comment Other drawing parameters:
		sentence Text_to_draw: Sumptuous RGB yellow...
		integer Font_size: 27
endform

# Cleaning Praat Picture window.
Erase all

# Calling sub-procedure. Argument needs to be provided as a string or string
# variable.
@hex2praat(hexadecimal_colour$)

# Selecting section of Praat's Picture window via world coordinates.
Select inner viewport: 1, 5, 1, 2.5

# Painting rectangle using color from local variable from sub-procedure
# ("hex2praat.color$") and relative coordinates.
Paint rectangle: hex2praat.color$, 0, 1, 0, 1

# Calling sub-procedure. The three arguments have to be provided as numbers or
# numerical variables.
@rgb2praat(red, green, blue)

# Changing the pen's colour in Praat's Picture window by using the
# sub-procedure's local variable (rgb2praat.color$).
Colour: rgb2praat.color$

# Adding some coloured text to the draw.
Text special: 0, "left", 0.5, "half", "Times", font_size, "0", text_to_draw$
