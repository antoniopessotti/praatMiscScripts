# Written by Mauricio Figueroa (www.mauriciofigueroa.cl)
# v.0.1 - 14th July 2014
# 
# Script to test "praatColourFromHex.proc" and "praatColourFromRGB.proc". The script includes
# both procedures (the path to the files is relative) and then calls them and uses local
# variables from the procedures to create a draw in the Praat Picture window with user-defined
# colours.
# 
# The first procedure (praatColourFromHex.proc) converts hexadecimal colours (with or without
# initial hash) into RGB and then into Praat RGB-formatted colours. The input variable has to
# be provided as a string variable between quotation marks, unless a previous string variable
# has been assigned to a string variable. The second procedure (praatColourFromRGB.proc)
# converts RGB colours into Praat RGB-formatted colours. It takes three numbers with the
# values for red, green and blue (numbers between 0 and 255). Numeric variables can also be
# used.
# 
# The output of both procedures corresponds to three local variables containing Praat-formatted
# RGB colours: ".praat_red", ".praat_green" and ".praat_blue". To use this variables it is
# necessary to call them appending the name of the variables to the name of the procedure:
#
#		Colour: "{'praatColourFromRGB.praat_red', 'praatColourFromRGB.praat_green',
#		...'praatColourFromRGB.praat_blue'}"
# 
# To the best of my knowledge, all the commands that take Praat RBG colours as arguments will
# require the use of variable substitution, given that they take strings as arguments.
#
# This script is free software: you can redistribute it and/or modify it under the terms of
# the GNU General Public License as published by the Free Software Foundation, either version
# 3 of the License, or (at your option) any later version.
#
# A copy of the GNU General Public License is available at 
# <http://www.gnu.org/licenses/>.

# Including the procedures into this script.
include praatColourFromHex.proc
include praatColourFromRGB.proc

# Form to introduce drawing parameters from the user.
form Choose drawing parameters:
	comment Choose a colour for the background:
		word Hexadecimal_colour: #FF950E
	comment Choose a colour for the text:
		integer RGB_text_red: 252
		integer RGB_text_green: 211
		integer RGB_text_blue: 32
	comment Other drawing parameters:
		sentence Text_to_draw: Sumptuous RGB yellow...
		integer Font_size: 27
endform

# Cleaning Praat Picture window.
Erase all

# Calling first procedure. The argument is provided as a string variable taken from the form.
@praatColourFromHex (hexadecimal_colour$)

# Selecting portion of Praat's Picture window via world coordinates.
Select inner viewport: 1, 5, 1, 2.5

# Painting rectangle using local variables from procedure and relative coordinates.
Paint rectangle: "{'praatColourFromHex.praat_red', 'praatColourFromHex.praat_green', 'praatColourFromHex.praat_blue'}", 0, 1, 0.88, -0.9

# Calling second procedure. The arguments have been taken from numerical variables from the form.
@praatColourFromRGB (rGB_text_red, rGB_text_green, rGB_text_blue)

# Changing the colour of the pen by using the procedure's local variables.
Colour: "{'praatColourFromRGB.praat_red', 'praatColourFromRGB.praat_green', 'praatColourFromRGB.praat_blue'}"

# Adding some coloured text.
Text special: 0, "left", 0, "half", "Times", font_size, "0", text_to_draw$