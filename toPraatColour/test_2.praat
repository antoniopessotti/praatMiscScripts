# Written by Mauricio Figueroa (www.mauriciofigueroa.cl)
# v.0.1 - 14th July 2014
# 
# Script to test "praatColourFromHex.proc" and "praatColourFromRGB.proc". The script includes
# both procedures (the path to the files is relative) and then calls them and uses local
# variables from the procedures to create a draw in the Praat Picture window with user-defined
# colours. For detailed instructions of use, see "test_1.praat" or the documentation contained
# in the procedures.
# 
# This script is free software: you can redistribute it and/or modify it under the terms of
# the GNU General Public License as published by the Free Software Foundation, either version
# 3 of the License, or (at your option) any later version.
#
# A copy of the GNU General Public License is available at 
# <http://www.gnu.org/licenses/>.

# Including colour-transforming procedures into this script.
include praatColourFromHex.proc
include praatColourFromRGB.proc

# Opening list of colours as table. List taken from:
# <http://cloford.com/resources/colours/500col.htm">
table_ID = Read Table from comma-separated file: "test_2_list.csv"

# Input from the user to decide whether to save the resulting palette or not.
form Saving palette.
	comment Do you want to save the (rather big) resulting palette as 300-dpi PNG file?
	boolean Save_palette 0
endform

# Cleaning Praat Picture window.
Erase all

# Initial vertical coordinate.
baseline = 0.5

# Dummy variable to alternate between procedures.
counter = 0

# For loop to access items from list and process them to create the palette.
for i from 1 to 554
	
	# Obtaining colour name and original hexadecimal and RGB codes.
	current_name$ = Get value: i, "Colour Name"
	current_hex$ = Get value: i, "Hex"
	current_red_string$ = Get value: i, "R"
	current_green_string$ = Get value: i, "G"
	current_blue_string$ = Get value: i, "B"
	current_red = number (current_red_string$)
	current_green = number (current_green_string$)
	current_blue = number (current_blue_string$)
	
	# Selecting portion of Praat's Picture window to write the name of the colour.
	Select inner viewport: 1, 3.7, baseline, baseline + 0.22
	
	# Adding text (black) with the number of the iterator and name of the colour.
	Text special: 0.0, "left", 0.0, "half", "Courier", 8, "0", "('i') 'current_name$':"
	
	# Selecting portion of the Picture window where to paint a rectangle.
	Select inner viewport: 3.7, 4.3, baseline, baseline + 0.22

	# Condition for using the first procedure.
	if counter == 0
		
		# Calling procedure to parse hexadecimal codes. The argument is provided as a string variable.
		@praatColourFromHex (current_hex$)
		
		# Painting rectangle in selected zone. Local variables from procedure and relative coordinates are used (the name of the procedure plus the name of the local variable have to be specified). Notice the use of variable substitution to call the variables into a string.
		Paint rectangle: "{'praatColourFromHex.praat_red', 'praatColourFromHex.praat_green', 'praatColourFromHex.praat_blue'}", 0, 1, -1, 1
		
		# Modifying the dummy variable's value to use other method in next iteration.
		counter = 1

	# Condition for using the second procedure.
	else
		
		# Calling procedure to parse RGB codes. The arguments are provided as numerical variables.
		@praatColourFromRGB (current_red, current_green, current_blue)
		
		# Painting rectangle in selected portion. Notice that the local variables have the same name (e.g. ".praat_red"), but the procedure has a different name ("praatColourFromRGB", instead of "praatColourFromHex").
		Paint rectangle: "{'praatColourFromRGB.praat_red', 'praatColourFromRGB.praat_green', 'praatColourFromRGB.praat_blue'}", 0, 1, -1, 1
		
		# Again, modifying the dummy variable to alternate methods.
		counter = 0
	endif
		
	# Increasing vertical coordinate to move a step down in the Picture window at each new iteration.
	baseline += 0.22

endfor

# Select the whole used canvas.
Select inner viewport: 1, 4.3, 0.5, baseline

# Saving the resulting image as 300-dpi PNG image if specified as such in form.
if save_palette
	
	# Checking current version of Praat.
	praat_version = praatVersion
	praat_version$ = praatVersion$
	
	# If current version of Praat is equal or bigger than 5369, the image is saved.
	if praat_version >= 5369
		appendInfoLine: "Saving image. It might take a couple of seconds..."
		Save as 300-dpi PNG file: "test_2.png"
		appendInfoLine: "The PNG file has been saved as <test_2.png>."
	
	# If Praat's version is too old, the script will terminate and send a message to the user.
	else
		exitScript: "You need a newer version of Praat to save an image as 300-dpi PNG (version 5.3.69 or higher). Your current version of Praat is: 'praat_version$'.'newline$'"
	endif

endif
