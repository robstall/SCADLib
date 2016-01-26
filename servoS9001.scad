include <plate.scad>

module servoS9001(screws = false, oversize = 0) {
  shaftX = 40.5 - 10.4;
  shaftY = 10;
  plateZ = 26.6;
  plateDepth = 36.1 - 44.1;
  plateThickness = 29.1-26.6;
  screwInsetX = (55.5 - 50.5) / 2;
  screwRadius = 4.2164 / 2;
  screwLength = 10;
  
  translate([-shaftX, -shaftY, -(plateZ + plateThickness)]) {
    union() {
      // Body
      translate([-oversize/2, -oversize/2, 0])
        plate([40.5 + oversize,20 + oversize, 36.1], r=1); 
      // Screw Plate
      translate([-7.5,1,plateZ]) {
        difference() {
          plate([55.1,18,plateThickness], r=1); 
          // Screw holes
          if (screws == false) {
            translate([screwInsetX, 4, 0]) cylinder(r=2.25, h=plateThickness);
            translate([screwInsetX, 14, 0]) cylinder(r=2.25, h=plateThickness);
            translate([55.1 - screwInsetX, 4, 0]) cylinder(r=2.25, h=plateThickness);
            translate([55.1 - screwInsetX, 14, 0]) cylinder(r=2.25, h=plateThickness);
          }
        }
        if (screws) {
          translate([screwInsetX, 4, 0]) cylinder(r=screwRadius, h=screwLength);
          translate([screwInsetX, 14, 0]) cylinder(r=screwRadius, h=screwLength);
          translate([55.1 - screwInsetX, 4, 0]) cylinder(r=screwRadius, h=screwLength);
          translate([55.1 - screwInsetX, 14, 0]) cylinder(r=screwRadius, h=screwLength);
        }
      }
      // Tabs on the screw plate
      translate([-4.5-oversize/2,9-oversize/2,29.1]) plate([49.5+oversize,2+oversize,1], r=0.5); 
      // Shaft
      translate([shaftX, shaftY, 36.1]) cylinder(r=3, h=8);
    }
  }
}

// Test cases

// Just the servo 
//servoS9001();

// Servo from plate up
//difference() {
//  color("green") servoS9001();
//  color("red") translate([-40, -15, -50-29.1+26.6]) cube([60, 30, 50]);
//}

// Creates a test piece with the right size hole cut out
//difference() {
//  color("green") cube([60, 30, 3]);
//  color("red") translate([40, 15, 3]) rotate([180, 0, 0]) servoS9001(screws = true, oversize = 1, $fn=24);
//}