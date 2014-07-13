
clearinfo

# Including the procedure in this script:
include hexToPraat.proc
include rbgToPraat.proc

Erase all

# Using hexadecimal:
@praatColourFromHex ("#ff950e")
Select inner viewport: 1.5, 4, 1, 2
Colour: "{'praat_red', 'praat_green', 'praat_blue'}"
Text special: 0, "left", 0, "half", "Times", 30, "0", "Sweet hexadecimal orange!"

# Using RGB:
@praatColourFromRGB (252, 211, 32)
Select inner viewport: 1.5, 4, 2, 3
Colour: "{'praat_red', 'praat_green', 'praat_blue'}"
Text special: 0, "left", 0, "half", "Times", 30, "0", "Sumptuous RGB yellow..."
