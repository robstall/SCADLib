# SCADLib

## Introduction
The is a small collection of the SCAD libraries to make designing a little simpler.

## Contents

### plate.scad

A drop in replacement for cube() that adds radiused corners. 
* The r (radius) parameter is optional. If r is omitted or has a value that doesn't make sense, a cube will be rendered instead.
* The code is not very efficient and can take a long time to render for high $fn values. Using r=4 while developing will produce a beveled corner that renders quickly and can be set higher later.

Example:
```
// Create a 20x30x2 plate with rounded corners (radius 2) and current $fn value
plate([20, 30, 3], r=2);

// Create the same plate but with smoother corners
plate([20, 30, 3], r=2, $fn=24);
```

### servoS9001.scad

"Model of a Parallax 900 servo (https://www.parallax.com/product/900-00008). 
* The default rendering has the shaft centered on x=0, y=0 with the top of the mounting plate at z=0.
* To when printing a chassis, the servo assembly can be added to your design in the appropriate location with "screws=true" set. This whole unit can then be "differenced" out of the model leaving only the mounting holes.
* The oversize parameter can be used to make the body 1mm oversized to ensure the server will fit through a "differenced" hole in a model.

Example:
```
// Draw a servo with screw holes in its nominal size
servo59001()

// Creates a test piece with the hole, 1mm oversize,  cut out
difference() {
  color("green") cube([60, 30, 3]);
  color("red") translate([40, 15, 3]) rotate([180, 0, 0]) servoS9001(screws = true, oversize = 1, $fn=24);
}
```

