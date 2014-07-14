# Script "Test_1". v.0.1 - Mauricio Figueroa (www.mauriciofigueroa.cl)
# 
# Script to test "praatColourFromHex.proc" and "praatColourFromRGB.proc". The script includes
# both procedures (the path to the files is relative) and then calls them and uses the output
# variables from the procedures to create a draw in the Praat Picture window with user-defined
# colours.
# 
# The first procedure (praatColourFromHex.proc) converts hexadecimal colours (with or without
# initial hash) into RGB and then into Praat RGB-formatted colours. The input variable has to
# be provided as a string variable between quotation marks, unless a previous string variable
# has been assigned. The second procedure (praatColourFromRGB.proc) converts RGB colours into
# Praat RGB-formatted colours. It takes three numbers with the values for red, green and blue
# (numbers between 0 and 255). Numeric variables can also be used.
# 
# The output of both procedures corresponds to three variables containing Praat-formatted RGB
# colours: "praat_red", "praat_green" and "praat_blue". To the best of my knowledge, all the
# commands that take Praat RBG colours as arguments will require the use of variable
# substitution, because they take strings as arguments

# Including the procedures.
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
		optionmenu Alignment: 1
			option left
			option centre
			option right
endform

# Cleaning the Praat Picture window.
Erase all

# Calling "praatColourFromHex", providing arguments from form and then using output variables to draw.
@praatColourFromHex (hexadecimal_colour$)
Select inner viewport: 1, 5, 1, 2.5
Paint rectangle: "{'praat_red', 'praat_green', 'praat_blue'}", 0, 1, 0, 1 ; using of output variables.

# Calling "praatColourFromRGB", providing arguments from form and using output variables to draw.
@praatColourFromRGB (rGB_text_red, rGB_text_green, rGB_text_blue)
Colour: "{'praat_red', 'praat_green', 'praat_blue'}" ; using of output variables.
Text special: 0, alignment$, 0.5, "half", "Times", font_size, "0", text_to_draw$