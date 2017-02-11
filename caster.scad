module caster(ball_diameter) {
  r = ball_diameter / 2;
  
  sphere(r);
  
  t = 2; // Wall thickness
  s = 2.25 * r; // Cutout width
  
  // The main fingers and base
  difference() {
    translate([0, 0, -r-t]) {
      cylinder(1.6*r, r=r+t, center);
      // Mounting flange
      translate([0, 0, r]) 
        difference() {
          cylinder(t, r=r+t+1, center);
          cylinder(t, r=r+t, center);
        }
    }
    // Cutouts
    translate([-(s+r)/2, -r/2, -r]) cube([s+r, r, r*2], center);
    translate([-r/2, -(s+r)/2, -r]) cube([r, s+r, r*2], center);

    // Remove space for ball
    sphere(1.05*r);
  }
  
  // Fills in the divot in the base
  translate([0, 0, -r-t]) cylinder(t, r=r+t, center);
  
  // Reinforcing ring
  translate([0, 0, -r]) 
    difference() {
      cylinder(r/2, r=r+t, center);
      cylinder(r/2, r=r, center);
    }
}

caster(17);