include <plate.scad>

module servoS9001() {
  shaftX = 40.5 - 10.4;
  shaftY = 10;
  plateDepth = 36.1 - 44.1;
  plateThickness = 29.1-26.1;
  screwInsetX = (55.5 - 50.5) / 2;
  
    union() {
      // Body
      plate([40.5,20,36.1], r=1); 
      // Screw Plate
      translate([-7.5,1,26.6]) {
        difference() {
          plate([55.1,18,plateThickness], r=1); 
          // Screw holes
          translate([screwInsetX, 4, 0]) cylinder(r=2.25, h=plateThickness);
          translate([screwInsetX, 14, 0]) cylinder(r=2.25, h=plateThickness);
          translate([55.1 - screwInsetX, 4, 0]) cylinder(r=2.25, h=plateThickness);
          translate([55.1 - screwInsetX, 14, 0]) cylinder(r=2.25, h=plateThickness);
        }
      }
      // Tabs on the screw plate
      translate([-4.5,9,29.1]) plate([49.5,2,1], r=0.5); 
      // Shaft
      translate([shaftX, shaftY, 36.1]) cylinder(r=3, h=8);
    }
}

servoS9001();
