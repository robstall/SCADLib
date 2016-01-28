module aaBattery() {
  cylinder(d=14, h=48.5);
  cylinder(d=5.5, h=50.3);
}

module aa4BatteryHolder() {
  difference() {
    cube([58,63,16]);
    translate([1.5,1.5,1.5]) cube([55, 60, 14.5]);
    translate([21,0,8]) cube([16.5,63,8]);
  }
  
  translate([5, 8.5,8.5]) rotate([0,90,0]) aaBattery();
  translate([54,8.5+15.5,8.5]) rotate([0,-90,0]) aaBattery();
  translate([5, 8.5+31,8.5]) rotate([0,90,0]) aaBattery();
  translate([54,8.5+46.5,8.5]) rotate([0,-90,0]) aaBattery();
  
  translate([-4.8, 45, 2]) cube([4.8,4.4,2]);
}

module pb2sBattery() {
  difference() {
    cube([98,62,7]);
    translate([-13, 13, 0]) rotate([0,0,-45]) cube([30,11,7]);
  }
}

//aaBattery();
//aa4BatteryHolder();
//pb2sBattery();