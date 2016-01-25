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

"Work in progress" model of a Parallax 900 servo (https://www.parallax.com/product/900-00008). 
* At the time of this writing I've not completed it and have not tested it to ensure the dimensions are correct.
* To when printing a chassis, the servo assembly can be added to your design in the appropriate location with "screws=true" set. This whole unit can then be "differenced" out of the model leaving only the mounting holes.

Example:
```
// Creates a test piece with the right size hole cut out
difference() {
  cube([60, 30, 3]);
  translate([10, 25, 29.1+3]) rotate([180, 0, 0]) servoS9001(screws = true, $fn=24);
}
```

