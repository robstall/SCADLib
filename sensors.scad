module hcsr04Ultrasonic() {
  difference() {
    cube([45, 20.3, 1.4]);
    d = 1.2;
    translate([d, d, 0]) cylinder(d=1.7,h=1.4);
    translate([d + 42.5, d, 0]) cylinder(d=1.7,h=1.4);
    translate([d, d + 17.6, 0]) cylinder(d=1.7,h=1.4);
    translate([d + 42.5, d + 17.6, 0]) cylinder(d=1.7,h=1.4);
  }
  translate([10, 20.3/2, .7]) {
    difference() {
      cylinder(d=16, h=12);
      translate([0,0,6]) cylinder(d=13, h=6);
    }
  }
  translate([35.6, 20.3/2, .7]) {
    difference() {
      cylinder(d=16, h=12);
      translate([0,0,6]) cylinder(d=13, h=6);
    }
  }
  translate([22.5-9.8/2, 16, 1.4]) cube([9.8,3.4,3.5]);
}

//hcsr04Ultrasonic();