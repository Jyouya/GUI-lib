# GUI-lib

A GUI library for Windower4 addons.

## Why GUI-lib?

As gearswap user files and other addons grow more complex, their command line interfaces become more esoteric.  By creating GUIs for addons, we can manage the complexity and create a far better user experience.

## Installation

Place `GUI.lua` and the folder named `GUI` in `addons/libs`

## Components

### Combobox

```
myComboBox = Combobox(options)
myComboBox:draw()
```


Takes the following options:


x: The x coordinate of the element

y: The y coordinate of the element

var: The `Mode` type variable that the element represents

width: The width of the element

size: The number of options to dispaly before scrolling

callback: A function that is run when the element changes the value it represents.  Receives the new value as its only argument

### Divider

```
myDivider = Divider(options)
myDivider:draw()
```


Takes the following options:


x: The x coordinate of the element

y: The y coordinate of the element

size: The width of the element

### FunctionButton

```
myFunctionButton = FunctionButton(options)
myFuncitonButton:draw()
```


Takes the following options:


x: The x coordinate of the element

y: The y coordinate of the element

icon: The image to be displayed on the button

command: Either a string to be run through the console, or a callback function to be called when the button is clicked

disabled: Flag for disabling the button

### GridButton

```
myGridButton = GridButton(options)
myGridButton:draw()
```

A button that displays a popout grid menu when clicked.

The graphic on the button corresponds to the current value.

It's a combobox, but with pictures instead of words, and a grid instead of a list.


Takes the following options:


x: The x coordinate of the element

y: The y coordinate of the element

var: The `Mode` type variable that the element represents

icons: A 2D table of icons in column-major format.  Icons are lua tables with keys `img=filepath` and `value="the state of the Mode var which the icon represents"`

command: Either a string to be run through the console, or a callback function to be called when the value is changed by the element

disabled: Flag for disabling the button

overlay: An additional graphic that can be displayed over the button

show_overlay: Sets if the overlay is to be displayed

on_click: A callback function for when the button is clicked

direction: The direction where the popup will appear, defaults to West of the button.

### IconButton

```
myIconButton = IconButton(options)
myIconButton:draw()
```

A button that displays a popout menu when clicked.

The graphic on the button corresponds to the current value.

It's a combobox, but with pictures instead of words.

### PassiveText

```
myPassiveText = passiveText(options, var)
myPassiveText:draw()
```

A text element that reflects the state of a string or number type variable

### RadioButton

```
myRadioButton = RadioButton(options)
myRadioButton:draw()
```

### SliderButton

```
mySliderButton = SliderButton(options)
mySliderButton:draw()
```

A button that displays a popout slider when clicked

