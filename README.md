# GUI-lib

Goes in addons/libs

Settings:
GUI.bound.y.lower/GUI.bound.y.upper - min and max pixels (starting from the top of the screen) where icon palettes can be displayed.
Write to the table when you're setting up the GUI rather than modifying the defaults in the lua file

To make a GUI element, you first create it with the constructor, then run element:draw() to initialize it.

Constructors:
IconButton({
  x = top left x coordinate of the button,
  y = top left y coordinate of the button,
  var = the Mode type variable you want to track (defined in Modes.lua)
  icons = {
    {img = 'file.png', value = 'whatever value of your Mode var the picture corresponds to'},
    {img = 'anotherfile.png', value = 'another value'},
    ...}
  command = a function to be called when a new value is selected, or a string that will be passed to windower.send_command(string)
})

